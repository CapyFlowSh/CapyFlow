

```markdown
# 🚀 Início do Script

O bloco **Início do Script** marca o começo do seu script no CapyFlow.

Ele é criado automaticamente quando você começa um novo projeto e não precisa ser adicionado manualmente.

## O que ele faz

O bloco gera a primeira linha do script:

```bash
#!/bin/bash
```

Essa linha informa ao sistema que o script deve ser executado utilizando o **Bash**.

## Código Shell

```bash
#!/bin/bash
```

## Exemplo

Um projeto simples:

```text
▶ Início do Script
    📢 Escrever [Olá, mundo!]
```

Gera:

```bash
#!/bin/bash

echo "Olá, mundo!"
```

## Observações

O bloco é criado automaticamente e não possui entradas configuráveis.
```

```markdown
# 📢 Escrever

O bloco **Escrever** mostra um texto no terminal.

Ele utiliza o comando `echo` do Shell.

## Como usar

Adicione o bloco **Escrever** ao seu projeto e coloque no campo **Texto** a mensagem que deseja mostrar.

Exemplo:

```text
📢 Escrever [Olá, mundo!]
```

Ao executar o projeto, aparecerá:

```text
Olá, mundo!
```

## Código Shell

O bloco:

```text
📢 Escrever [Olá, mundo!]
```

gera:

```bash
echo "Olá, mundo!"
```

## Sobre o comando `echo`

`echo` é utilizado para escrever texto na saída do terminal.

### Exemplo no Shell

```bash
echo "Olá, mundo!"
```

## Usando variáveis

Também é possível mostrar o conteúdo de uma variável:

```text
✏️ Definir [NOME] [Capy]
📢 Escrever [Olá, $NOME!]
```

Isso gera:

```bash
NOME="Capy"
echo "Olá, $NOME!"
```

O Shell substituirá `$NOME` pelo valor armazenado na variável.

## Entrada

| Campo | Descrição |
|---|---|
| Texto | Texto que será exibido no terminal |
```

```markdown
# 📁 Ir para

O bloco **Ir para** altera a pasta atual do script.

Ele utiliza o comando `cd` do Shell.

## Como usar

No campo **Caminho**, coloque o diretório para o qual deseja ir.

Exemplo:

```text
📁 Ir para [/tmp]
```

Isso fará com que os comandos executados depois desse bloco sejam executados dentro de `/tmp`.

## Código Shell

```bash
cd /tmp
```

## Sobre o comando `cd`

`cd` significa **change directory** e serve para mudar o diretório atual.

### Exemplo no Shell

```bash
cd /tmp
```

Depois disso:

```bash
touch exemplo.txt
```

criará `exemplo.txt` dentro de `/tmp`.

## Usando caminhos relativos

Também é possível utilizar caminhos relativos:

```bash
cd documentos
```

Nesse caso, o Shell tentará entrar em uma pasta chamada `documentos` dentro do diretório atual.

## Entrada

| Campo | Descrição |
|---|---|
| Caminho | Diretório para onde o script irá |
```

docs/blocos/criar-pasta.md

```markdown
# 📂 Criar pasta

O bloco **Criar pasta** cria um novo diretório.

Ele utiliza o comando `mkdir`.

## Como usar

No campo **Nome**, coloque o nome ou caminho da pasta que deseja criar.

Exemplo:

```text
📂 Criar pasta [projeto]
```

Gera:

```bash
mkdir -p projeto
```

## Sobre o comando `mkdir`

`mkdir` significa **make directory** e serve para criar diretórios.

O CapyFlow utiliza a opção `-p`:

```bash
mkdir -p projeto
```

A opção `-p` permite criar também os diretórios necessários no caminho.

Por exemplo:

```bash
mkdir -p projetos/capyflow/docs
```

pode criar toda a estrutura de diretórios necessária.

Além disso, o comando não considera um diretório já existente como erro quando utilizado com `-p`.

## Exemplo no CapyFlow

```text
▶ Início do Script
    📂 Criar pasta [meu_projeto]
    📁 Ir para [meu_projeto]
    📢 Escrever [Projeto criado!]
```

Gera:

```bash
#!/bin/bash

mkdir -p meu_projeto
cd meu_projeto
echo "Projeto criado!"
```

## Entrada

| Campo | Descrição |
|---|---|
| Nome | Nome ou caminho da pasta que será criada |
```

docs/blocos/criar-arquivo.md

```markdown
# 📄 Criar arquivo

O bloco **Criar arquivo** cria um arquivo.

Ele utiliza o comando `touch` do Shell.

## Como usar

No campo **Nome**, coloque o nome do arquivo.

Exemplo:

```text
📄 Criar arquivo [notas.txt]
```

Gera:

```bash
touch notas.txt
```

## Sobre o comando `touch`

`touch` pode ser utilizado para criar um arquivo caso ele ainda não exista.

Exemplo:

```bash
touch exemplo.txt
```

Se `exemplo.txt` não existir, ele será criado.

Se o arquivo já existir, `touch` pode atualizar sua data de modificação em vez de criar outro arquivo.

## Exemplo no CapyFlow

```text
▶ Início do Script
    📂 Criar pasta [projeto]
    📁 Ir para [projeto]
    📄 Criar arquivo [notas.txt]
```

Gera:

```bash
#!/bin/bash

mkdir -p projeto
cd projeto
touch notas.txt
```

## Entrada

| Campo | Descrição |
|---|---|
| Nome | Nome ou caminho do arquivo |
```

```markdown
# 🗑️ Remover

O bloco **Remover** exclui arquivos ou diretórios.

Ele utiliza o comando `rm` com as opções `-rf`.

## Como usar

No campo **Alvo**, coloque o arquivo ou diretório que deseja remover.

Exemplo:

```text
🗑️ Remover [arquivo.txt]
```

Gera:

```bash
rm -rf arquivo.txt
```

## Sobre o comando `rm`

`rm` é utilizado para remover arquivos.

A opção `-r` permite remover diretórios e seu conteúdo de forma recursiva.

A opção `-f` força a remoção sem solicitar confirmação.

Por isso, o CapyFlow gera:

```bash
rm -rf
```

## ⚠️ Cuidado

Esse comando pode apagar arquivos e diretórios de forma destrutiva.

Sempre confira o valor colocado no campo **Alvo** antes de executar o projeto.

Evite testar esse bloco em arquivos importantes.

## Exemplo

```text
▶ Início do Script
    🗑️ Remover [temporario.txt]
```

Gera:

```bash
#!/bin/bash

rm -rf temporario.txt
```

## Entrada

| Campo | Descrição |
|---|---|
| Alvo | Arquivo ou diretório que será removido |
```

docs/blocos/mostrar-arquivo.md

```markdown
# 👁️ Mostrar arquivo

O bloco **Mostrar arquivo** mostra o conteúdo de um arquivo no terminal.

Ele utiliza o comando `cat`.

## Como usar

No campo **Arquivo**, coloque o arquivo que deseja visualizar.

Exemplo:

```text
👁️ Mostrar arquivo [notas.txt]
```

Gera:

```bash
cat notas.txt
```

## Sobre o comando `cat`

`cat` é utilizado para mostrar o conteúdo de arquivos no terminal.

### Exemplo no Shell

```bash
cat notas.txt
```

Se `notas.txt` contiver:

```text
Olá!
Este é um arquivo de teste.
```

esse conteúdo será mostrado no terminal.

## Exemplo no CapyFlow

```text
▶ Início do Script
    📄 Criar arquivo [teste.txt]
    👁️ Mostrar arquivo [teste.txt]
```

O segundo bloco tentará mostrar o conteúdo do arquivo criado.

Como o arquivo acabou de ser criado pelo `touch`, ele estará inicialmente vazio.

## Entrada

| Campo | Descrição |
|---|---|
| Arquivo | Arquivo cujo conteúdo será mostrado |
```

docs/blocos/se.md

```markdown
# ❓ Se

O bloco **Se** permite executar comandos somente quando uma condição for verdadeira.

Ele utiliza a estrutura `if` do Bash.

## Como usar

No campo **Condição**, coloque uma condição válida do Shell.

Por exemplo:

```text
❓ Se [ -f arquivo.txt ]
    📢 Escrever [O arquivo existe!]
```

O conteúdo dentro do bloco será executado somente se a condição for verdadeira.

## Código Shell

O exemplo acima gera:

```bash
if [ -f arquivo.txt ]; then
    echo "O arquivo existe!"
fi
```

## Sobre o comando `if`

`if` permite tomar decisões em scripts.

Sua estrutura básica é:

```bash
if condição; then
    comandos
fi
```

O Shell executa os comandos dentro do `if` somente quando a condição for verdadeira.

## Verificando arquivos

Uma condição bastante útil é:

```bash
[ -f arquivo.txt ]
```

Ela verifica se `arquivo.txt` é um arquivo regular.

Outro exemplo:

```bash
[ -d documentos ]
```

verifica se `documentos` é um diretório.

## Blocos dentro do Se

O bloco **Se** possui uma área interna onde outros blocos podem ser colocados.

Exemplo:

```text
❓ Se [ -f arquivo.txt ]
    👁️ Mostrar arquivo [arquivo.txt]
```

Isso fará com que o arquivo seja mostrado somente se ele existir.

## Entrada

| Campo | Descrição |
|---|---|
| Condição | Condição Shell que será avaliada |
```

```markdown
# 🔁 Para cada

O bloco **Para cada** repete uma sequência de comandos para cada item de uma lista.

Ele utiliza o comando `for` do Bash.

## Como usar

O bloco possui dois campos:

- **Variável** — nome da variável que receberá cada item.
- **Lista** — valores que serão percorridos.

Exemplo:

```text
🔁 Para cada [i] [1 2 3]
    📢 Escrever [$i]
```

Isso executará o bloco **Escrever** três vezes.

## Código Shell

```bash
for i in 1 2 3; do
    echo "$i"
done
```

Resultado:

```text
1
2
3
```

## Sobre o comando `for`

A estrutura básica é:

```bash
for variável in lista; do
    comandos
done
```

A variável recebe um item da lista a cada repetição.

## Exemplo com arquivos

```bash
for arquivo in *.txt; do
    echo "$arquivo"
done
```

Nesse caso, o Shell percorrerá os arquivos `.txt` encontrados.

## Usando no CapyFlow

```text
▶ Início do Script
    🔁 Para cada [numero] [1 2 3 4 5]
        📢 Escrever [Número: $numero]
```

Gera:

```bash
#!/bin/bash

for numero in 1 2 3 4 5; do
    echo "Número: $numero"
done
```

## Entrada

| Campo | Descrição |
|---|---|
| Variável | Nome da variável que receberá cada item |
| Lista | Itens que serão percorridos |
```

docs/blocos/enquanto.md

```markdown
# ♻️ Enquanto

O bloco **Enquanto** repete comandos enquanto uma condição for verdadeira.

Ele utiliza o comando `while` do Bash.

## Como usar

No campo **Condição**, coloque uma condição válida do Shell.

Os blocos colocados dentro do **Enquanto** serão executados repetidamente enquanto essa condição for verdadeira.

Exemplo:

```text
♻️ Enquanto [ "$i" -lt 10 ]
    📢 Escrever [$i]
```

Gera:

```bash
while [ "$i" -lt 10 ]; do
    echo "$i"
done
```

## Sobre o comando `while`

A estrutura básica é:

```bash
while condição; do
    comandos
done
```

A condição é verificada antes de cada repetição.

Se for verdadeira, os comandos são executados.

Quando a condição se tornar falsa, o loop termina.

## ⚠️ Cuidado

É importante que a condição possa eventualmente se tornar falsa.

Caso contrário, o loop poderá continuar executando indefinidamente.

Por exemplo, este loop nunca termina:

```bash
while true; do
    echo "Executando..."
done
```

## Entrada

| Campo | Descrição |
|---|---|
| Condição | Condição Shell que será verificada a cada repetição |
```

```markdown
# 🔍 Testar

O bloco **Testar** executa uma verificação utilizando o comando `test` do Shell.

## Como usar

No campo **Expressão**, coloque a expressão que deseja testar.

Exemplo:

```text
🔍 Testar [-e arquivo.txt]
```

Gera:

```bash
test -e arquivo.txt
```

## Sobre o comando `test`

O comando `test` verifica uma condição e indica o resultado através do código de saída do comando.

Por exemplo:

```bash
test -e arquivo.txt
```

verifica se `arquivo.txt` existe.

O comando não precisa mostrar uma mensagem no terminal para indicar o resultado.

Ele utiliza o **status de saída**:

- `0` — condição verdadeira.
- outro valor — condição falsa.

## Exemplos

Verificar se um arquivo existe:

```bash
test -e arquivo.txt
```

Verificar se um arquivo é regular:

```bash
test -f arquivo.txt
```

Verificar se um diretório existe:

```bash
test -d documentos
```

## Usando diretamente no Shell

É possível combinar `test` com estruturas de controle:

```bash
if test -f arquivo.txt; then
    echo "O arquivo existe!"
fi
```

No CapyFlow, o bloco **Se** possui seu próprio campo de condição. Portanto, você pode colocar a expressão diretamente nele quando quiser criar uma condição.

## Entrada

| Campo | Descrição |
|---|---|
| Expressão | Expressão que será verificada pelo comando `test` |
```

```markdown
# ✏️ Definir

O bloco **Definir** cria ou altera uma variável do Shell.

## Como usar

O bloco possui dois campos:

- **Nome** — nome da variável.
- **Valor** — valor que será armazenado.

Exemplo:

```text
✏️ Definir [NOME] [Capy]
```

Gera:

```bash
NOME="Capy"
```

## Sobre variáveis no Shell

Uma variável pode armazenar informações para serem utilizadas posteriormente.

A sintaxe básica é:

```bash
NOME="valor"
```

Para acessar o valor armazenado, utilize `$` antes do nome:

```bash
echo "$NOME"
```

## Exemplo no CapyFlow

```text
▶ Início do Script
    ✏️ Definir [NOME] [Capy]
    📢 Escrever [Olá, $NOME!]
```

Gera:

```bash
#!/bin/bash

NOME="Capy"
echo "Olá, $NOME!"
```

Resultado:

```text
Olá, Capy!
```

## Variáveis não exportadas

O bloco cria uma variável normal do Shell.

Ela fica disponível para os comandos executados dentro daquele script, mas não é automaticamente exportada para processos filhos como uma variável de ambiente.

## Entrada

| Campo | Descrição |
|---|---|
| Nome | Nome da variável |
| Valor | Valor armazenado na variável |
```

docs/blocos/ler-entrada.md

```markdown
# ⌨️ Ler entrada

O bloco **Ler entrada** permite receber uma informação digitada pelo usuário no terminal.

Ele utiliza o comando `read` do Bash.

## Como usar

No campo **Variável**, coloque o nome da variável que receberá a informação.

Exemplo:

```text
⌨️ Ler entrada [NOME]
```

Gera:

```bash
read NOME
```

Quando o script chegar nesse comando, ele aguardará uma entrada no terminal.

## Exemplo no CapyFlow

```text
▶ Início do Script
    📢 Escrever [Qual é o seu nome?]
    ⌨️ Ler entrada [NOME]
    📢 Escrever [Olá, $NOME!]
```

Gera:

```bash
#!/bin/bash

echo "Qual é o seu nome?"
read NOME
echo "Olá, $NOME!"
```

O usuário poderá digitar seu nome e pressionar Enter.

## Sobre o comando `read`

`read` lê uma linha de entrada do terminal e armazena o resultado em uma variável.

Exemplo:

```bash
read RESPOSTA
```

Depois disso, o conteúdo pode ser utilizado com:

```bash
echo "$RESPOSTA"
```

## Observação

O bloco não cria automaticamente uma mensagem perguntando o que deve ser digitado.

Se quiser mostrar uma pergunta, use um bloco **Escrever** antes dele.

## Entrada

| Campo | Descrição |
|---|---|
| Variável | Nome da variável onde a entrada será armazenada |
```
