#!/usr/bin/env bash
set -e

# ----------------------------
# Cores para output
# ----------------------------
VERDE='\033[0;32m'
AMARELO='\033[1;33m'
VERMELHO='\033[0;31m'
AZUL='\033[0;34m'
NC='\033[0m'

info()  { echo -e "${AZUL}[INFO]${NC} $*"; }
ok()    { echo -e "${VERDE}[OK]${NC} $*"; }
aviso() { echo -e "${AMARELO}[AVISO]${NC} $*"; }
erro()  { echo -e "${VERMELHO}[ERRO]${NC} $*" >&2; }

# ----------------------------
# Configurações
# ----------------------------
REPO_URL="https://github.com/pixelcatbr/CapyFlow.git"
APP_NOME="CapyFlow"
APP_ID="capyflow"
DIR_INSTALACAO="$HOME/.local/share/capyflow"
DIR_BIN="$HOME/.local/bin"
DIR_APPS="$HOME/.local/share/applications"
DESKTOP_DIR="$(xdg-user-dir DESKTOP 2>/dev/null || echo "$HOME/Desktop")"
PYTHON_BIN="$(command -v python3 || true)"

# ----------------------------
# Verificações iniciais
# ----------------------------
info "Verificando dependências..."

# git
if ! command -v git >/dev/null 2>&1; then
    erro "git não encontrado. Instale com:"
    erro "  sudo apt install git    # Debian/Ubuntu"
    erro "  sudo dnf install git    # Fedora"
    erro "  sudo pacman -S git      # Arch"
    exit 1
fi

# python3
if [ -z "$PYTHON_BIN" ]; then
    erro "Python 3 não encontrado. Instale com:"
    erro "  sudo apt install python3 python3-pip    # Debian/Ubuntu"
    erro "  sudo dnf install python3 python3-pip    # Fedora"
    exit 1
fi

# flask
if ! "$PYTHON_BIN" -c "import flask" 2>/dev/null; then
    aviso "Flask não encontrado. Tentando instalar via pip..."
    if "$PYTHON_BIN" -m pip install --user flask; then
        ok "Flask instalado."
    else
        erro "Falha ao instalar Flask. Instale manualmente: pip install flask"
        exit 1
    fi
fi

# ----------------------------
# Criar diretórios base
# ----------------------------
info "Criando diretórios..."
mkdir -p "$DIR_BIN"
mkdir -p "$DIR_APPS"

# ----------------------------
# Clonar (ou atualizar) o repositório
# ----------------------------
if [ -d "$DIR_INSTALACAO/.git" ]; then
    info "Repositório já existe em $DIR_INSTALACAO — atualizando..."
    if git -C "$DIR_INSTALACAO" pull --ff-only; then
        ok "Repositório atualizado."
    else
        aviso "Não foi possível atualizar (conflitos?). Continuando com versão local."
    fi
else
    info "Clonando $REPO_URL ..."
    rm -rf "$DIR_INSTALACAO"
    if git clone --depth=1 "$REPO_URL" "$DIR_INSTALACAO"; then
        ok "Repositório clonado em $DIR_INSTALACAO"
    else
        erro "Falha ao clonar o repositório."
        exit 1
    fi
fi

# ----------------------------
# Detectar arquivo principal Python
# ----------------------------
info "Detectando arquivo principal..."

APP_PY=""
for candidato in app.py main.py capyflow.py server.py; do
    if [ -f "$DIR_INSTALACAO/$candidato" ]; then
        APP_PY="$DIR_INSTALACAO/$candidato"
        break
    fi
done

# Fallback: primeiro .py com 'Flask(' dentro
if [ -z "$APP_PY" ]; then
    APP_PY="$(grep -rl --include='*.py' 'Flask(' "$DIR_INSTALACAO" 2>/dev/null | head -n1 || true)"
fi

if [ -z "$APP_PY" ]; then
    erro "Não foi possível localizar o arquivo principal Flask no repositório."
    erro "Verifique o conteúdo de $DIR_INSTALACAO"
    exit 1
fi

ok "Arquivo principal detectado: $APP_PY"

# ----------------------------
# Instalar requirements (se existir)
# ----------------------------
if [ -f "$DIR_INSTALACAO/requirements.txt" ]; then
    info "Instalando dependências de requirements.txt..."
    "$PYTHON_BIN" -m pip install --user -r "$DIR_INSTALACAO/requirements.txt" \
        || aviso "Algumas dependências falharam; prossiga com cautela."
fi

# ----------------------------
# Criar binário local capyflow
# ----------------------------
info "Criando binário local capyflow..."

cat > "$DIR_BIN/capyflow" <<BINEOF
#!/usr/bin/env bash
# CapyFlow - launcher
cd "$DIR_INSTALACAO" || exit 1
exec "$PYTHON_BIN" "$APP_PY" "\$@"
BINEOF

chmod +x "$DIR_BIN/capyflow"
ok "Binário criado: $DIR_BIN/capyflow"

# ----------------------------
# Criar .desktop
# ----------------------------
info "Criando atalho .desktop..."

DESKTOP_FILE_CONTENT="[Desktop Entry]
Version=1.0
Type=Application
Name=CapyFlow
Comment=Executor de shellscripts com interface web
Exec=$DIR_BIN/capyflow
Icon=utilities-terminal
Terminal=false
Categories=Development;Utility;
StartupNotify=true
"

echo "$DESKTOP_FILE_CONTENT" > "$DIR_APPS/capyflow.desktop"
chmod +x "$DIR_APPS/capyflow.desktop"

# Atalho na área de trabalho
if [ -d "$DESKTOP_DIR" ]; then
    echo "$DESKTOP_FILE_CONTENT" > "$DESKTOP_DIR/capyflow.desktop"
    chmod +x "$DESKTOP_DIR/capyflow.desktop"

    # Marca como confiável (GNOME)
    if command -v gio >/dev/null 2>&1; then
        gio set "$DESKTOP_DIR/capyflow.desktop" metadata::trusted true 2>/dev/null || true
    fi
    ok "Atalho criado em: $DESKTOP_DIR/capyflow.desktop"
else
    aviso "Área de trabalho não encontrada em $DESKTOP_DIR (atalho só no menu)."
fi

# Atualiza cache do menu (se aplicável)
if command -v update-desktop-database >/dev/null 2>&1; then
    update-desktop-database "$DIR_APPS" 2>/dev/null || true
fi

# ----------------------------
# Ajustar PATH (se necessário)
# ----------------------------
if [[ ":$PATH:" != *":$DIR_BIN:"* ]]; then
    aviso "$DIR_BIN não está no PATH."
    for rc in "$HOME/.bashrc" "$HOME/.zshrc"; do
        if [ -f "$rc" ] && ! grep -q 'capyflow' "$rc"; then
            {
                echo ''
                echo '# CapyFlow'
                echo 'export PATH="$HOME/.local/bin:$PATH"'
            } >> "$rc"
            ok "PATH adicionado em $rc (reabra o terminal)."
        fi
    done
fi

# ----------------------------
# Finalização
# ----------------------------
echo
ok "=========================================="
ok " CapyFlow instalado com sucesso!"
ok "=========================================="
echo
info "Repositório:    $DIR_INSTALACAO"
info "Arquivo main:   $APP_PY"
info "Binário:        $DIR_BIN/capyflow"
info "Atalho desktop: $DESKTOP_DIR/capyflow.desktop"
info "Menu apps:      $DIR_APPS/capyflow.desktop"
echo
info "Execute com:    capyflow"
info "Ou clique no ícone 'CapyFlow' na área de trabalho."
echo
