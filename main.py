from flask import Flask, request, jsonify, send_from_directory, render_template
import subprocess
import tempfile
import os
import threading
import webview


app = Flask(__name__)


@app.route('/')
def index():
    return render_template("index.html")


@app.route('/executar', methods=['POST'])
def executar():
    data = request.get_json(silent=True) or {}
    code = data.get('code', '')

    if not code.strip():
        return jsonify(
            stdout='',
            stderr='Nenhum código recebido.',
            returncode=-1
        ), 400

    # Escreve o shellscript num arquivo temporário
    tmp = tempfile.NamedTemporaryFile(
        mode='w',
        suffix='.sh',
        delete=False,
        encoding='utf-8'
    )
    tmp.write(code)
    tmp.close()
    os.chmod(tmp.name, 0o755)

    try:
        proc = subprocess.run(
            ['bash', tmp.name],
            capture_output=True,
            text=True,
            timeout=10
        )
        return jsonify(
            stdout=proc.stdout,
            stderr=proc.stderr,
            returncode=proc.returncode
        )

    except subprocess.TimeoutExpired:
        return jsonify(
            stdout='',
            stderr='Tempo esgotado (10 segundos).',
            returncode=-1
        )

    except Exception as e:
        return jsonify(
            stdout='',
            stderr=f'Erro interno: {e}',
            returncode=-1
        ), 500

    finally:
        try:
            os.unlink(tmp.name)
        except OSError:
            pass


def start_flask():
    app.run(host="127.0.0.1", port=6060, debug=False, use_reloader=False)


if __name__ == '__main__':
    # Inicia o Flask em uma thread separada
    flask_thread = threading.Thread(target=start_flask, daemon=True)
    flask_thread.start()

    # Abre a janela do pywebview apontando para o Flask
    webview.create_window(
        title="CapyFlow",
        url="http://127.0.0.1:6060",
        width=1000,
        height=700
    )
    webview.start()
