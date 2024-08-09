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
def obter_dados(query):
    conn = get_db_connection()
    if conn is None:
        return jsonify({"error": "Não foi possível conectar ao banco de dados"}), 500
    
    df = pd.read_sql_query(query, conn)
    conn.close()

    # Convertendo DataFrame para JSON
    return jsonify(df.to_dict(orient='records'))

# Rota para testar a conexão com o banco de dados
@app.route('/teste_conexao', methods=['GET'])
def teste_conexao():
    conn = get_db_connection()
    if conn:
        conn.close()
        return jsonify({"status": "Conexão com o banco de dados bem-sucedida!"})
    else:
        return jsonify({"status": "Falha na conexão com o banco de dados."}), 500

# Listar todos os clientes
@app.route('/clientes', methods=['GET'])
def listar_clientes():
    query = "SELECT * FROM farmacia.cliente"
    return obter_dados(query)

# Obter um cliente por ID
@app.route('/cliente/<int:id>', methods=['GET'])
def obter_cliente(id):
    conn = get_db_connection()
    if conn is None:
        return jsonify({"error": "Não foi possível conectar ao banco de dados"}), 500

    try:
        df = pd.read_sql_query(f"SELECT * FROM farmacia.cliente WHERE id_cliente = {id}", conn)
        conn.close()
        if df.empty:
            return jsonify({"error": "Cliente não encontrado"}), 404
        return jsonify(df.to_dict(orient='records')[0])
    except Exception as e:
        conn.close()
        return jsonify({"error": str(e)}), 500

# Adicionar um novo cliente
@app.route('/cliente', methods=['POST'])
def adicionar_cliente():
    conn = get_db_connection()
    if conn is None:
        return jsonify({"error": "Não foi possível conectar ao banco de dados"}), 500

    data = request.json
    nome = data.get('nome_cliente')
    cpf = data.get('cpf')
    endereco_numero = data.get('endereco_cliente_numero')
    endereco_rua = data.get('endereco_cliente_rua')
    endereco_bairro = data.get('endereco_cliente_bairro')
    endereco_cidade = data.get('endereco_cliente_cidade')

    try:
        with conn.cursor() as cursor:
            cursor.execute("""
                INSERT INTO farmacia.cliente (nome_cliente, cpf, endereco_cliente_numero, endereco_cliente_rua, endereco_cliente_bairro, endereco_cliente_cidade)
                VALUES (%s, %s, %s, %s, %s, %s)
            """, (nome, cpf, endereco_numero, endereco_rua, endereco_bairro, endereco_cidade))
            conn.commit()
        conn.close()
        return jsonify({"message": "Cliente adicionado com sucesso!"}), 201
    except Exception as e:
        conn.close()
        return jsonify({"error": str(e)}), 500

# Atualizar um cliente
@app.route('/cliente/<int:id>', methods=['PUT'])
def atualizar_cliente(id):
    conn = get_db_connection()
    if conn is None:
        return jsonify({"error": "Não foi possível conectar ao banco de dados"}), 500

    data = request.json
    nome = data.get('nome_cliente')
    cpf = data.get('cpf')
    endereco_numero = data.get('endereco_cliente_numero')
    endereco_rua = data.get('endereco_cliente_rua')
    endereco_bairro = data.get('endereco_cliente_bairro')
    endereco_cidade = data.get('endereco_cliente_cidade')

    try:
        with conn.cursor() as cursor:
            cursor.execute("""
                UPDATE farmacia.cliente
                SET nome_cliente = %s, cpf = %s, endereco_cliente_numero = %s, endereco_cliente_rua = %s, endereco_cliente_bairro = %s, endereco_cliente_cidade = %s
                WHERE id_cliente = %s
            """, (nome, cpf, endereco_numero, endereco_rua, endereco_bairro, endereco_cidade, id))
            conn.commit()
        conn.close()
        return jsonify({"message": "Cliente atualizado com sucesso!"})
    except Exception as e:
        conn.close()
        return jsonify({"error": str(e)}), 500

# Excluir um cliente
@app.route('/cliente/<int:id>', methods=['DELETE'])
def excluir_cliente(id):
    conn = get_db_connection()
    if conn is None:
        return jsonify({"error": "Não foi possível conectar ao banco de dados"}), 500

    try:
        with conn.cursor() as cursor:
            cursor.execute("DELETE FROM farmacia.cliente WHERE id_cliente = %s", (id,))
            conn.commit()
        conn.close()
        return jsonify({"message": "Cliente excluído com sucesso!"})
    except Exception as e:
        conn.close()
        return jsonify({"error": str(e)}), 500

# Iniciar o servidor Flask
if __name__ == '__main__':
    app.run(debug=True)



# {
#     "cpf": "12345678901",
#     "endereco_cliente_bairro": "Bairro A",
#     "endereco_cliente_cidade": "Cidade A",
#     "endereco_cliente_numero": 10,
#     "endereco_cliente_rua": "Rua A",
#     "id_cliente": 1,
#     "nome_cliente": "Ana Lara"
# }