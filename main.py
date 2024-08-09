from flask import Flask, jsonify, request
import psycopg2
from psycopg2 import OperationalError
import pandas as pd

app = Flask(__name__)

# Função para conectar ao banco de dados
def get_db_connection():
    try:
        conn = psycopg2.connect(
            dbname="Gerenciamento_Remedios",
            user="postgres",
            password="1412",
            host="localhost",
            port="5432"
        )
        return conn
    except OperationalError as e:
        print(f"Erro ao conectar ao banco de dados: {e}")
        return None

# Função para obter dados da tabela
def obter_dados(query, params=None):
    conn = get_db_connection()
    if conn is None:
        return None, {"error": "Não foi possível conectar ao banco de dados"}, 500
    
    try:
        df = pd.read_sql_query(query, conn, params=params)
    except Exception as e:
        return None, {"error": str(e)}, 500
    finally:
        conn.close()

    # Convertendo DataFrame para JSON
    return df.to_dict(orient='records'), None, None

# Função para executar uma query de modificação (INSERT, UPDATE, DELETE)
def executar_modificacao(query, params):
    conn = get_db_connection()
    if conn is None:
        return {"error": "Não foi possível conectar ao banco de dados"}, 500
    
    try:
        with conn.cursor() as cursor:
            cursor.execute(query, params)
            conn.commit()
        return {"message": "Operação bem-sucedida!"}, None, None
    except Exception as e:
        return {"error": str(e)}, 500
    finally:
        conn.close()

# Rota para testar a conexão com o banco de dados
@app.route('/teste_conexao', methods=['GET'])
def teste_conexao():
    conn = get_db_connection()
    if conn:
        conn.close()
        return jsonify({"status": "Conexão com o banco de dados bem-sucedida!"})
    else:
        return jsonify({"status": "Falha na conexão com o banco de dados."}), 500

# CRUD para tabela remedio
@app.route('/remedio', methods=['GET'])
def listar_remedios():
    query = "SELECT * FROM farmacia.remedio"
    dados, erro, status = obter_dados(query)
    if erro:
        return jsonify(erro), status
    return jsonify(dados)

@app.route('/remedio/<int:id>', methods=['GET'])
def obter_remedio(id):
    query = "SELECT * FROM farmacia.remedio WHERE id_remedio = %s"
    dados, erro, status = obter_dados(query, (id,))
    if erro:
        return jsonify(erro), status
    if not dados:
        return jsonify({"error": "Remédio não encontrado"}), 404
    return jsonify(dados[0])

@app.route('/remedio', methods=['POST'])
def adicionar_remedio():
    data = request.json
    query = """
        INSERT INTO farmacia.remedio (nome, descricao)
        VALUES (%s, %s)
    """
    params = (data.get('nome'), data.get('descricao'))
    mensagem, erro, status = executar_modificacao(query, params)
    if erro:
        return jsonify(erro), status
    return jsonify(mensagem), 201

@app.route('/remedio/<int:id>', methods=['PUT'])
def atualizar_remedio(id):
    data = request.json
    query = """
        UPDATE farmacia.remedio
        SET nome = %s, descricao = %s
        WHERE id_remedio = %s
    """
    params = (data.get('nome'), data.get('descricao'), id)
    mensagem, erro, status = executar_modificacao(query, params)
    if erro:
        return jsonify(erro), status
    return jsonify(mensagem)

@app.route('/remedio/<int:id>', methods=['DELETE'])
def excluir_remedio(id):
    query = "DELETE FROM farmacia.remedio WHERE id_remedio = %s"
    params = (id,)
    mensagem, erro, status = executar_modificacao(query, params)
    if erro:
        return jsonify(erro), status
    return jsonify(mensagem)

# CRUD para tabela genericos
@app.route('/genericos', methods=['GET'])
def listar_genericos():
    query = "SELECT * FROM farmacia.genericos"
    dados, erro, status = obter_dados(query)
    if erro:
        return jsonify(erro), status
    return jsonify(dados)

@app.route('/genericos/<int:id>', methods=['GET'])
def obter_generico(id):
    query = "SELECT * FROM farmacia.genericos WHERE id_generico = %s"
    dados, erro, status = obter_dados(query, (id,))
    if erro:
        return jsonify(erro), status
    if not dados:
        return jsonify({"error": "Genérico não encontrado"}), 404
    return jsonify(dados[0])

@app.route('/genericos', methods=['POST'])
def adicionar_generico():
    data = request.json
    query = """
        INSERT INTO farmacia.genericos (id_remedio)
        VALUES (%s)
    """
    params = (data.get('id_remedio'),)
    mensagem, erro, status = executar_modificacao(query, params)
    if erro:
        return jsonify(erro), status
    return jsonify(mensagem), 201

@app.route('/genericos/<int:id>', methods=['PUT'])
def atualizar_generico(id):
    data = request.json
    query = """
        UPDATE farmacia.genericos
        SET id_remedio = %s
        WHERE id_generico = %s
    """
    params = (data.get('id_remedio'), id)
    mensagem, erro, status = executar_modificacao(query, params)
    if erro:
        return jsonify(erro), status
    return jsonify(mensagem)

@app.route('/genericos/<int:id>', methods=['DELETE'])
def excluir_generico(id):
    query = "DELETE FROM farmacia.genericos WHERE id_generico = %s"
    params = (id,)
    mensagem, erro, status = executar_modificacao(query, params)
    if erro:
        return jsonify(erro), status
    return jsonify(mensagem)

# CRUD para tabela tarjas
@app.route('/tarjas', methods=['GET'])
def listar_tarjas():
    query = "SELECT * FROM farmacia.tarjas"
    dados, erro, status = obter_dados(query)
    if erro:
        return jsonify(erro), status
    return jsonify(dados)

@app.route('/tarjas/<int:id>', methods=['GET'])
def obter_tarjas(id):
    query = "SELECT * FROM farmacia.tarjas WHERE id_tarjas = %s"
    dados, erro, status = obter_dados(query, (id,))
    if erro:
        return jsonify(erro), status
    if not dados:
        return jsonify({"error": "Tarja não encontrada"}), 404
    return jsonify(dados[0])

@app.route('/tarjas', methods=['POST'])
def adicionar_tarjas():
    data = request.json
    query = """
        INSERT INTO farmacia.tarjas (id_remedio, cores_tarjas)
        VALUES (%s, %s)
    """
    params = (data.get('id_remedio'), data.get('cores_tarjas'))
    mensagem, erro, status = executar_modificacao(query, params)
    if erro:
        return jsonify(erro), status
    return jsonify(mensagem), 201

@app.route('/tarjas/<int:id>', methods=['PUT'])
def atualizar_tarjas(id):
    data = request.json
    query = """
        UPDATE farmacia.tarjas
        SET id_remedio = %s, cores_tarjas = %s
        WHERE id_tarjas = %s
    """
    params = (data.get('id_remedio'), data.get('cores_tarjas'), id)
    mensagem, erro, status = executar_modificacao(query, params)
    if erro:
        return jsonify(erro), status
    return jsonify(mensagem)

@app.route('/tarjas/<int:id>', methods=['DELETE'])
def excluir_tarjas(id):
    query = "DELETE FROM farmacia.tarjas WHERE id_tarjas = %s"
    params = (id,)
    mensagem, erro, status = executar_modificacao(query, params)
    if erro:
        return jsonify(erro), status
    return jsonify(mensagem)

# CRUD para tabela de_marcas
@app.route('/de_marcas', methods=['GET'])
def listar_de_marcas():
    query = "SELECT * FROM farmacia.de_marcas"
    dados, erro, status = obter_dados(query)
    if erro:
        return jsonify(erro), status
    return jsonify(dados)

@app.route('/de_marcas/<int:id>', methods=['GET'])
def obter_de_marcas(id):
    query = "SELECT * FROM farmacia.de_marcas WHERE id_marcas = %s"
    dados, erro, status = obter_dados(query, (id,))
    if erro:
        return jsonify(erro), status
    if not dados:
        return jsonify({"error": "Marca não encontrada"}), 404
    return jsonify(dados[0])

@app.route('/de_marcas', methods=['POST'])
def adicionar_de_marcas():
    data = request.json
    query = """
        INSERT INTO farmacia.de_marcas (id_remedio)
        VALUES (%s)
    """
    params = (data.get('id_remedio'),)
    mensagem, erro, status = executar_modificacao(query, params)
    if erro:
        return jsonify(erro), status
    return jsonify(mensagem), 201

@app.route('/de_marcas/<int:id>', methods=['PUT'])
def atualizar_de_marcas(id):
    data = request.json
    query = """
        UPDATE farmacia.de_marcas
        SET id_remedio = %s
        WHERE id_marcas = %s
    """
    params = (data.get('id_remedio'), id)
    mensagem, erro, status = executar_modificacao(query, params)
    if erro:
        return jsonify(erro), status
    return jsonify(mensagem)

@app.route('/de_marcas/<int:id>', methods=['DELETE'])
def excluir_de_marcas(id):
    query = "DELETE FROM farmacia.de_marcas WHERE id_marcas = %s"
    params = (id,)
    mensagem, erro, status = executar_modificacao(query, params)
    if erro:
        return jsonify(erro), status
    return jsonify(mensagem)

# CRUD para tabela pedido
@app.route('/pedido', methods=['GET'])
def listar_pedidos():
    query = "SELECT * FROM farmacia.pedido"
    dados, erro, status = obter_dados(query)
    if erro:
        return jsonify(erro), status
    return jsonify(dados)

@app.route('/pedido/<int:id>', methods=['GET'])
def obter_pedido(id):
    query = "SELECT * FROM farmacia.pedido WHERE id_pedido = %s"
    dados, erro, status = obter_dados(query, (id,))
    if erro:
        return jsonify(erro), status
    if not dados:
        return jsonify({"error": "Pedido não encontrado"}), 404
    return jsonify(dados[0])

@app.route('/pedido', methods=['POST'])
def adicionar_pedido():
    data = request.json
    query = """
        INSERT INTO farmacia.pedido (id_remedio, data_pedido)
        VALUES (%s, %s)
    """
    params = (data.get('id_remedio'), data.get('data_pedido'))
    mensagem, erro, status = executar_modificacao(query, params)
    if erro:
        return jsonify(erro), status
    return jsonify(mensagem), 201

@app.route('/pedido/<int:id>', methods=['PUT'])
def atualizar_pedido(id):
    data = request.json
    query = """
        UPDATE farmacia.pedido
        SET id_remedio = %s, data_pedido = %s
        WHERE id_pedido = %s
    """
    params = (data.get('id_remedio'), data.get('data_pedido'), id)
    mensagem, erro, status = executar_modificacao(query, params)
    if erro:
        return jsonify(erro), status
    return jsonify(mensagem)

@app.route('/pedido/<int:id>', methods=['DELETE'])
def excluir_pedido(id):
    query = "DELETE FROM farmacia.pedido WHERE id_pedido = %s"
    params = (id,)
    mensagem, erro, status = executar_modificacao(query, params)
    if erro:
        return jsonify(erro), status
    return jsonify(mensagem)

# CRUD para tabela esta_incluido
@app.route('/esta_incluido', methods=['GET'])
def listar_esta_incluido():
    query = "SELECT * FROM farmacia.esta_incluido"
    dados, erro, status = obter_dados(query)
    if erro:
        return jsonify(erro), status
    return jsonify(dados)

@app.route('/esta_incluido/<int:id>', methods=['GET'])
def obter_esta_incluido(id):
    query = "SELECT * FROM farmacia.esta_incluido WHERE id_pedido = %s"
    dados, erro, status = obter_dados(query, (id,))
    if erro:
        return jsonify(erro), status
    if not dados:
        return jsonify({"error": "Registro não encontrado"}), 404
    return jsonify(dados[0])

@app.route('/esta_incluido', methods=['POST'])
def adicionar_esta_incluido():
    data = request.json
    query = """
        INSERT INTO farmacia.esta_incluido (id_pedido, id_remedio)
        VALUES (%s, %s)
    """
    params = (data.get('id_pedido'), data.get('id_remedio'))
    mensagem, erro, status = executar_modificacao(query, params)
    if erro:
        return jsonify(erro), status
    return jsonify(mensagem), 201

@app.route('/esta_incluido/<int:id>', methods=['PUT'])
def atualizar_esta_incluido(id):
    data = request.json
    query = """
        UPDATE farmacia.esta_incluido
        SET id_pedido = %s, id_remedio = %s
        WHERE id_pedido = %s
    """
    params = (data.get('id_pedido'), data.get('id_remedio'), id)
    mensagem, erro, status = executar_modificacao(query, params)
    if erro:
        return jsonify(erro), status
    return jsonify(mensagem)

@app.route('/esta_incluido/<int:id>', methods=['DELETE'])
def excluir_esta_incluido(id):
    query = "DELETE FROM farmacia.esta_incluido WHERE id_pedido = %s"
    params = (id,)
    mensagem, erro, status = executar_modificacao(query, params)
    if erro:
        return jsonify(erro), status
    return jsonify(mensagem)

# CRUD para tabela fornecedor
@app.route('/fornecedor', methods=['GET'])
def listar_fornecedores():
    query = "SELECT * FROM farmacia.fornecedor"
    dados, erro, status = obter_dados(query)
    if erro:
        return jsonify(erro), status
    return jsonify(dados)

@app.route('/fornecedor/<int:id>', methods=['GET'])
def obter_fornecedor(id):
    query = "SELECT * FROM farmacia.fornecedor WHERE id_fornecedor = %s"
    dados, erro, status = obter_dados(query, (id,))
    if erro:
        return jsonify(erro), status
    if not dados:
        return jsonify({"error": "Fornecedor não encontrado"}), 404
    return jsonify(dados[0])

@app.route('/fornecedor', methods=['POST'])
def adicionar_fornecedor():
    data = request.json
    query = """
        INSERT INTO farmacia.fornecedor (nome, endereco, telefone)
        VALUES (%s, %s, %s)
    """
    params = (data.get('nome'), data.get('endereco'), data.get('telefone'))
    mensagem, erro, status = executar_modificacao(query, params)
    if erro:
        return jsonify(erro), status
    return jsonify(mensagem), 201

@app.route('/fornecedor/<int:id>', methods=['PUT'])
def atualizar_fornecedor(id):
    data = request.json
    query = """
        UPDATE farmacia.fornecedor
        SET nome = %s, endereco = %s, telefone = %s
        WHERE id_fornecedor = %s
    """
    params = (data.get('nome'), data.get('endereco'), data.get('telefone'), id)
    mensagem, erro, status = executar_modificacao(query, params)
    if erro:
        return jsonify(erro), status
    return jsonify(mensagem)

@app.route('/fornecedor/<int:id>', methods=['DELETE'])
def excluir_fornecedor(id):
    query = "DELETE FROM farmacia.fornecedor WHERE id_fornecedor = %s"
    params = (id,)
    mensagem, erro, status = executar_modificacao(query, params)
    if erro:
        return jsonify(erro), status
    return jsonify(mensagem)

# CRUD para tabela solicitacao
@app.route('/solicitacao', methods=['GET'])
def listar_solicitacoes():
    query = "SELECT * FROM farmacia.solicitacao"
    dados, erro, status = obter_dados(query)
    if erro:
        return jsonify(erro), status
    return jsonify(dados)

@app.route('/solicitacao/<int:id>', methods=['GET'])
def obter_solicitacao(id):
    query = "SELECT * FROM farmacia.solicitacao WHERE id_solicitacao = %s"
    dados, erro, status = obter_dados(query, (id,))
    if erro:
        return jsonify(erro), status
    if not dados:
        return jsonify({"error": "Solicitação não encontrada"}), 404
    return jsonify(dados[0])

@app.route('/solicitacao', methods=['POST'])
def adicionar_solicitacao():
    data = request.json
    query = """
        INSERT INTO farmacia.solicitacao (id_remedio, id_fornecedor, data_solicitacao)
        VALUES (%s, %s, %s)
    """
    params = (data.get('id_remedio'), data.get('id_fornecedor'), data.get('data_solicitacao'))
    mensagem, erro, status = executar_modificacao(query, params)
    if erro:
        return jsonify(erro), status
    return jsonify(mensagem), 201

@app.route('/solicitacao/<int:id>', methods=['PUT'])
def atualizar_solicitacao(id):
    data = request.json
    query = """
        UPDATE farmacia.solicitacao
        SET id_remedio = %s, id_fornecedor = %s, data_solicitacao = %s
        WHERE id_solicitacao = %s
    """
    params = (data.get('id_remedio'), data.get('id_fornecedor'), data.get('data_solicitacao'), id)
    mensagem, erro, status = executar_modificacao(query, params)
    if erro:
        return jsonify(erro), status
    return jsonify(mensagem)

@app.route('/solicitacao/<int:id>', methods=['DELETE'])
def excluir_solicitacao(id):
    query = "DELETE FROM farmacia.solicitacao WHERE id_solicitacao = %s"
    params = (id,)
    mensagem, erro, status = executar_modificacao(query, params)
    if erro:
        return jsonify(erro), status
    return jsonify(mensagem)

if __name__ == '__main__':
    app.run(debug=True)
