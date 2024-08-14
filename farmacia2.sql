
CREATE SCHEMA farmacia;
SET SCHEMA 'farmacia';

--Tabela remédio

CREATE TABLE remedio (
    id_remedio SERIAL,
    nome VARCHAR(255) NOT NULL,
    descricao VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_remedio)
);

--Tabela genéricos, ela importa atributos da Tabela remédio

CREATE TABLE genericos (
    id_generico SERIAL,
    PRIMARY KEY (id_generico)
) INHERITS (remedio);

--Tabela tarjas, assim como "genéricos", importa atributos de "remédio"

CREATE TABLE tarjas (
    id_tarjas SERIAL,
    cores_tarjas VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_tarjas)
) INHERITS (remedio);

--Tabela de_marcas, também importa atributos da tabela remédio

CREATE TABLE de_marcas (
    id_marcas SERIAL,
    PRIMARY KEY (id_marcas)
) INHERITS (remedio);

--Tabela pedidos, marca o registro de pedidos realizados a farmácia ou ao fornecedor

CREATE TABLE pedido (
    id_pedido SERIAL,
    cod_rastr VARCHAR(50) UNIQUE,
    status_pedido VARCHAR(50) NOT NULL CHECK (status_pedido IN ('EM PRODUÇÃO', 'A CAMINHO', 'ENTREGUE')),
    data_pedido DATE,
    qtd_rem_solic INTEGER,
    PRIMARY KEY (id_pedido)
);

--Tabela relacional entre remédio e pedido

CREATE TABLE esta_incluido (
    id_remedio INTEGER NOT NULL,
    id_pedido INTEGER NOT NULL,
    PRIMARY KEY (id_remedio, id_pedido),
    FOREIGN KEY (id_remedio) REFERENCES remedio (id_remedio),
    FOREIGN KEY (id_pedido) REFERENCES pedido (id_pedido)
);

--Tabela fornecedor, possui um atributo composto 'endereço'

CREATE TABLE fornecedor (
    id_fornecedor SERIAL,
    nome_empresa VARCHAR(255) UNIQUE NOT NULL,
    cnpj VARCHAR(14) UNIQUE NOT NULL,
    email VARCHAR(255),
    endereco_numero INTEGER,
    endereco_rua VARCHAR(255),
    endereco_bairro VARCHAR(255),
    endereco_cidade VARCHAR(255),
    endereco_estado CHAR(2),
    PRIMARY KEY (id_fornecedor)
);

--Tabela relacional entre pedido e fornecedor

CREATE TABLE solicitacao (
    id_pedido INTEGER NOT NULL,
    id_fornecedor INTEGER NOT NULL,
    PRIMARY KEY (id_pedido, id_fornecedor),
    FOREIGN KEY (id_pedido) REFERENCES pedido (id_pedido),
    FOREIGN KEY (id_fornecedor) REFERENCES fornecedor (id_fornecedor)
);

--Tabela funcionário

CREATE TABLE funcionario (
    id_funcionario SERIAL,
    salario NUMERIC(10, 2),
    cargo VARCHAR(255),
    nome VARCHAR(255),
    PRIMARY KEY (id_funcionario)
);

--Tabela que relaciona funcionário e pedido

CREATE TABLE realiza (
    id_funcionario INTEGER NOT NULL,
    id_pedido INTEGER NOT NULL,
    PRIMARY KEY (id_funcionario, id_pedido),
    FOREIGN KEY (id_funcionario) REFERENCES funcionario (id_funcionario),
    FOREIGN KEY (id_pedido) REFERENCES pedido (id_pedido)
);

--Tabela estoque, também possui um atributo composto 'medida'

CREATE TABLE estoque (
    id_estoque SERIAL,
    data_entrega_stq DATE,
    qtd_stq INTEGER,
    data_vali_stq DATE,
    medida_frascos INTEGER,
    medida_caixas INTEGER,
    medida_cartelas INTEGER,
    medida_unidade INTEGER,
    PRIMARY KEY (id_estoque)
);

--Tabela relacional entre estoque e remedio

CREATE TABLE possui (
    id_estoque INTEGER NOT NULL,
    id_remedio INTEGER NOT NULL,
    PRIMARY KEY (id_estoque, id_remedio),
    FOREIGN KEY (id_estoque) REFERENCES estoque (id_estoque),
    FOREIGN KEY (id_remedio) REFERENCES remedio (id_remedio)
);

--Tabela cliente, possui um atributo composto 'endereço'

CREATE TABLE cliente (
    id_cliente SERIAL,
    nome_cliente VARCHAR(255),
    cpf CHAR(11) CHECK (char_length(cpf) = 11) NOT NULL,
    endereco_cliente_numero INTEGER,
    endereco_cliente_rua VARCHAR(255),
    endereco_cliente_bairro VARCHAR(255),
    endereco_cliente_cidade VARCHAR(255),
    PRIMARY KEY (id_cliente)
);

--Tabela telefone está relacionada a um atributo multivalorado de cliente

CREATE TABLE telefone (
    id_telefone SERIAL,
    id_cliente INTEGER NOT NULL,
    numero_telefone VARCHAR(20) UNIQUE,
    PRIMARY KEY (id_telefone),
    FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente)
);

--Tabela histórico de compra

CREATE TABLE historico_compra (
    id_historico SERIAL,
    receitas VARCHAR(255),
    ult_compra VARCHAR(255),
    PRIMARY KEY (id_historico)
);

--Tabela relacional entre histórico e remédio

CREATE TABLE faz_parte (
    id_historico INTEGER NOT NULL,
    id_remedio INTEGER NOT NULL,
    PRIMARY KEY (id_historico, id_remedio),
    FOREIGN KEY (id_historico) REFERENCES historico_compra (id_historico),
    FOREIGN KEY (id_remedio) REFERENCES remedio (id_remedio)
);

-- Tabela relacional entre histórico e cliente.

CREATE TABLE tem (
    id_historico INTEGER NOT NULL,
    id_cliente INTEGER NOT NULL,
    PRIMARY KEY (id_historico, id_cliente),
    FOREIGN KEY (id_historico) REFERENCES historico_compra (id_historico),
    FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente)
);