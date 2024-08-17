CREATE SCHEMA farmacia;
SET SCHEMA 'farmacia';

-- Tabela Remédio
CREATE TABLE remedio (
    id_remedio SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    descricao VARCHAR(255) NOT NULL,
    tipo_remedio VARCHAR(50) CHECK (tipo_remedio IN ('Genérico', 'De Marca')),
    cores_tarjas VARCHAR(50)
);

-- Tabela Pedido
CREATE TABLE pedido (
    id_pedido SERIAL PRIMARY KEY,
    cod_rastr VARCHAR(50) UNIQUE,
    status_pedido VARCHAR(50) NOT NULL CHECK (status_pedido IN ('EM PRODUÇÃO', 'A CAMINHO', 'ENTREGUE')),
    data_pedido DATE NOT NULL,
    qtd_rem_solic INTEGER NOT NULL
);

-- Tabela Relacionamento Pedido e Remédio
CREATE TABLE esta_incluido (
    id_remedio INTEGER NOT NULL,
    id_pedido INTEGER NOT NULL,
    PRIMARY KEY (id_remedio, id_pedido),
    FOREIGN KEY (id_remedio) REFERENCES remedio (id_remedio),
    FOREIGN KEY (id_pedido) REFERENCES pedido (id_pedido)
);

-- Tabela Fornecedor
CREATE TABLE fornecedor (
    id_fornecedor SERIAL PRIMARY KEY,
    nome_empresa VARCHAR(255) UNIQUE NOT NULL,
    cnpj VARCHAR(14) UNIQUE NOT NULL,
    email VARCHAR(255),
    endereco_rua VARCHAR(255),
    endereco_numero INTEGER,
    endereco_bairro VARCHAR(255),
    endereco_cidade VARCHAR(255),
    endereco_estado CHAR(2)
);

-- Relacionamento Pedido e Fornecedor
CREATE TABLE solicitacao (
    id_pedido INTEGER NOT NULL,
    id_fornecedor INTEGER NOT NULL,
    PRIMARY KEY (id_pedido, id_fornecedor),
    FOREIGN KEY (id_pedido) REFERENCES pedido (id_pedido),
    FOREIGN KEY (id_fornecedor) REFERENCES fornecedor (id_fornecedor)
);

-- Tabela Funcionario
CREATE TABLE funcionario (
    id_funcionario SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    cargo VARCHAR(255) NOT NULL,
    salario NUMERIC(10, 2) NOT NULL
);

-- Relacionamento Funcionario e Pedido
CREATE TABLE realiza (
    id_funcionario INTEGER NOT NULL,
    id_pedido INTEGER NOT NULL,
    PRIMARY KEY (id_funcionario, id_pedido),
    FOREIGN KEY (id_funcionario) REFERENCES funcionario (id_funcionario),
    FOREIGN KEY (id_pedido) REFERENCES pedido (id_pedido)
);

-- Tabela Estoque
CREATE TABLE estoque (
    id_estoque SERIAL PRIMARY KEY,
    data_entrega_stq DATE,
    qtd_stq INTEGER NOT NULL,
    data_vali_stq DATE NOT NULL,
    unidade_medida VARCHAR(50) NOT NULL
);

-- Relacionamento Estoque e Remédio
CREATE TABLE possui (
    id_estoque INTEGER NOT NULL,
    id_remedio INTEGER NOT NULL,
    PRIMARY KEY (id_estoque, id_remedio),
    FOREIGN KEY (id_estoque) REFERENCES estoque (id_estoque),
    FOREIGN KEY (id_remedio) REFERENCES remedio (id_remedio)
);

-- Tabela Cliente
CREATE TABLE cliente (
    id_cliente SERIAL PRIMARY KEY,
    nome_cliente VARCHAR(255) NOT NULL,
    cpf VARCHAR(11) CHECK (length(cpf) = 11) NOT NULL UNIQUE,
    endereco_rua VARCHAR(255),
    endereco_numero INTEGER,
    endereco_bairro VARCHAR(255),
    endereco_cidade VARCHAR(255)
);

-- Tabela Telefone
CREATE TABLE telefone (
    id_telefone SERIAL PRIMARY KEY,
    id_cliente INTEGER NOT NULL,
    numero_telefone VARCHAR(20),
    FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente)
);

-- Tabela Histórico de Compra
CREATE TABLE historico_compra (
    id_historico SERIAL PRIMARY KEY,
    receitas VARCHAR(255),
    ult_compra VARCHAR(255),
    id_cliente INTEGER NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente)
);

-- Relacionamento Histórico de Compra e Remédio
CREATE TABLE faz_parte (
    id_historico INTEGER NOT NULL,
    id_remedio INTEGER NOT NULL,
    PRIMARY KEY (id_historico, id_remedio),
    FOREIGN KEY (id_historico) REFERENCES historico_compra (id_historico),
    FOREIGN KEY (id_remedio) REFERENCES remedio (id_remedio)
);
