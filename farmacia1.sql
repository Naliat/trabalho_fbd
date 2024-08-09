
CREATE SCHEMA farmacia;
SET SCHEMA 'farmacia';

--Tabela remédio

CREATE TABLE remedio (
    id_remedio SERIAL,
    nome VARCHAR(255) NOT NULL,
    descricao VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_remedio)
);

CREATE TABLE genericos (
    id_generico SERIAL,
    id_remedio INTEGER NOT NULL,
    PRIMARY KEY (id_generico),
    FOREIGN KEY (id_remedio) REFERENCES remedio (id_remedio)
);

CREATE TABLE tarjas (
    id_tarjas SERIAL,
    id_remedio INTEGER NOT NULL,
    cores_tarjas VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_tarjas),
    FOREIGN KEY (id_remedio) REFERENCES remedio (id_remedio)
);

CREATE TABLE de_marcas (
    id_marcas SERIAL,
    id_remedio INTEGER NOT NULL,
    PRIMARY KEY (id_marcas),
    FOREIGN KEY (id_remedio) REFERENCES remedio (id_remedio)
);

CREATE TABLE pedido (
    id_pedido SERIAL,
    cod_rastr VARCHAR(50) UNIQUE,
    status_pedido VARCHAR(50) NOT NULL CHECK (status_pedido IN ('EM PRODUÇÃO', 'A CAMINHO', 'ENTREGUE')),
    data_pedido DATE,
    qtd_rem_solic INTEGER,
    PRIMARY KEY (id_pedido)
);

CREATE TABLE esta_incluido (
    id_remedio INTEGER NOT NULL,
    id_pedido INTEGER NOT NULL,
    PRIMARY KEY (id_remedio, id_pedido),
    FOREIGN KEY (id_remedio) REFERENCES remedio (id_remedio),
    FOREIGN KEY (id_pedido) REFERENCES pedido (id_pedido)
);

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

CREATE TABLE solicitacao (
    id_pedido INTEGER NOT NULL,
    id_fornecedor INTEGER NOT NULL,
    PRIMARY KEY (id_pedido, id_fornecedor),
    FOREIGN KEY (id_pedido) REFERENCES pedido (id_pedido),
    FOREIGN KEY (id_fornecedor) REFERENCES fornecedor (id_fornecedor)
);

CREATE TABLE funcionario (
    id_funcionario SERIAL,
    salario NUMERIC(10, 2),
    cargo VARCHAR(255),
    nome VARCHAR(255),
    PRIMARY KEY (id_funcionario)
);

CREATE TABLE realiza (
    id_funcionario INTEGER NOT NULL,
    id_pedido INTEGER NOT NULL,
    PRIMARY KEY (id_funcionario, id_pedido),
    FOREIGN KEY (id_funcionario) REFERENCES funcionario (id_funcionario),
    FOREIGN KEY (id_pedido) REFERENCES pedido (id_pedido)
);

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

CREATE TABLE possui (
    id_estoque INTEGER NOT NULL,
    id_remedio INTEGER NOT NULL,
    PRIMARY KEY (id_estoque, id_remedio),
    FOREIGN KEY (id_estoque) REFERENCES estoque (id_estoque),
    FOREIGN KEY (id_remedio) REFERENCES remedio (id_remedio)
);

CREATE TABLE cliente (
    id_cliente SERIAL,
    nome_cliente VARCHAR(255),
    cpf VARCHAR(11) CHECK (length(cpf) = 11) NOT NULL,
    endereco_cliente_numero INTEGER,
    endereco_cliente_rua VARCHAR(255),
    endereco_cliente_bairro VARCHAR(255),
    endereco_cliente_cidade VARCHAR(255),
    PRIMARY KEY (id_cliente)
);

CREATE TABLE telefone (
    id_telefone SERIAL,
    id_cliente INTEGER NOT NULL,
    numero_telefone VARCHAR(20),
    PRIMARY KEY (id_telefone),
    FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente)
);

CREATE TABLE historico_compra (
    id_historico SERIAL,
    receitas VARCHAR(255),
    ult_compra VARCHAR(255),
    PRIMARY KEY (id_historico)
);

CREATE TABLE faz_parte (
    id_historico INTEGER NOT NULL,
    id_remedio INTEGER NOT NULL,
    PRIMARY KEY (id_historico, id_remedio),
    FOREIGN KEY (id_historico) REFERENCES historico_compra (id_historico),
    FOREIGN KEY (id_remedio) REFERENCES remedio (id_remedio)
);

CREATE TABLE tem (
    id_historico INTEGER NOT NULL,
    id_cliente INTEGER NOT NULL,
    PRIMARY KEY (id_historico, id_cliente),
    FOREIGN KEY (id_historico) REFERENCES historico_compra (id_historico),
    FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente)
);


-- Populando a tabela remedio
INSERT INTO remedio (nome, descricao) VALUES
('Paracetamol', 'Antipirético e analgésico'),
('Ibuprofeno', 'Anti-inflamatório e analgésico'),
('Amoxicilina', 'Antibiótico de amplo espectro'),
('Dipirona', 'Analgésico e antipirético'),
('Cetoconazol', 'Antifúngico'),
('Metformina', 'Antidiabético'),
('Lorazepam', 'Ansiolítico'),
('Cloridrato de Salbutamol', 'Broncodilatador'),
('Prednisona', 'Corticosteroide'),
('Omeprazol', 'Inibidor da bomba de prótons');

-- Populando a tabela genericos
INSERT INTO genericos (id_remedio) VALUES
(1), (2), (3), (4), (5), (6), (7), (8), (9), (10);

-- Populando a tabela tarjas
INSERT INTO tarjas (id_remedio, cores_tarjas) VALUES
(1, 'Verde'),
(2, 'Azul'),
(3, 'Amarela'),
(4, 'Vermelha'),
(5, 'Branca'),
(6, 'Preta'),
(7, 'Cinza'),
(8, 'Rosa'),
(9, 'Laranja'),
(10, 'Marrom');

-- Populando a tabela de_marcas
INSERT INTO de_marcas (id_remedio) VALUES
(1), (2), (3), (4), (5), (6), (7), (8), (9), (10);

-- Populando a tabela pedido
INSERT INTO pedido (cod_rastr, status_pedido, data_pedido, qtd_rem_solic) VALUES
('R001', 'EM PRODUÇÃO', '2024-08-01', 10),
('R002', 'A CAMINHO', '2024-08-02', 5),
('R003', 'ENTREGUE', '2024-08-03', 15),
('R004', 'EM PRODUÇÃO', '2024-08-04', 20),
('R005', 'A CAMINHO', '2024-08-05', 8),
('R006', 'ENTREGUE', '2024-08-06', 12),
('R007', 'EM PRODUÇÃO', '2024-08-07', 6),
('R008', 'A CAMINHO', '2024-08-08', 7),
('R009', 'ENTREGUE', '2024-08-09', 11),
('R010', 'EM PRODUÇÃO', '2024-08-10', 9);

-- Populando a tabela esta_incluido
INSERT INTO esta_incluido (id_remedio, id_pedido) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
(6, 6), (7, 7), (8, 8), (9, 9), (10, 10);

-- Populando a tabela fornecedor
INSERT INTO fornecedor (nome_empresa, cnpj, email, endereco_numero, endereco_rua, endereco_bairro, endereco_cidade, endereco_estado) VALUES
('Farmácia A', '12345678000195', 'contato@farmaciaa.com', 100, 'Rua A', 'Bairro A', 'Cidade A', 'SP'),
('Farmácia B', '12345678000286', 'contato@farmaciab.com', 200, 'Rua B', 'Bairro B', 'Cidade B', 'RJ'),
('Farmácia C', '12345678000357', 'contato@farmaciac.com', 300, 'Rua C', 'Bairro C', 'Cidade C', 'MG'),
('Farmácia D', '12345678000428', 'contato@farmaciad.com', 400, 'Rua D', 'Bairro D', 'Cidade D', 'BA'),
('Farmácia E', '12345678000509', 'contato@farmaciae.com', 500, 'Rua E', 'Bairro E', 'Cidade E', 'PR'),
('Farmácia F', '12345678000670', 'contato@farmaciaf.com', 600, 'Rua F', 'Bairro F', 'Cidade F', 'RS'),
('Farmácia G', '12345678000741', 'contato@farmaciag.com', 700, 'Rua G', 'Bairro G', 'Cidade G', 'SC'),
('Farmácia H', '12345678000812', 'contato@farmaciah.com', 800, 'Rua H', 'Bairro H', 'Cidade H', 'DF'),
('Farmácia I', '12345678000983', 'contato@farmaciai.com', 900, 'Rua I', 'Bairro I', 'Cidade I', 'CE'),
('Farmácia J', '12345678001054', 'contato@farmaciaj.com', 1000, 'Rua J', 'Bairro J', 'Cidade J', 'GO');

-- Populando a tabela solicitacao
INSERT INTO solicitacao (id_pedido, id_fornecedor) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
(6, 6), (7, 7), (8, 8), (9, 9), (10, 10);

-- Populando a tabela funcionario
INSERT INTO funcionario (salario, cargo, nome) VALUES
(2500.00, 'Farmacêutico', 'Ana Lara'),
(2600.00, 'Auxiliar de Farmácia', 'João Silva'),
(2700.00, 'Gerente de Loja', 'Maria Oliveira'),
(2800.00, 'Farmacêutico', 'Carlos Santos'),
(2900.00, 'Auxiliar de Farmácia', 'Patrícia Almeida'),
(3000.00, 'Gerente de Loja', 'Roberto Souza'),
(3100.00, 'Farmacêutico', 'Fernanda Costa'),
(3200.00, 'Auxiliar de Farmácia', 'Ricardo Lima'),
(3300.00, 'Gerente de Loja', 'Juliana Ribeiro'),
(3400.00, 'Farmacêutico', 'Luiz Pereira');

-- Populando a tabela realiza
INSERT INTO realiza (id_funcionario, id_pedido) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
(6, 6), (7, 7), (8, 8), (9, 9), (10, 10);

-- Populando a tabela estoque
INSERT INTO estoque (data_entrega_stq, qtd_stq, data_vali_stq, medida_frascos, medida_caixas, medida_cartelas, medida_unidade) VALUES
('2024-08-01', 100, '2025-08-01', 10, 20, 30, 40),
('2024-08-02', 200, '2025-08-02', 15, 25, 35, 45),
('2024-08-03', 300, '2025-08-03', 20, 30, 40, 50),
('2024-08-04', 400, '2025-08-04', 25, 35, 45, 55),
('2024-08-05', 500, '2025-08-05', 30, 40, 50, 60),
('2024-08-06', 600, '2025-08-06', 35, 45, 55, 65),
('2024-08-07', 700, '2025-08-07', 40, 50, 60, 70),
('2024-08-08', 800, '2025-08-08', 45, 55, 65, 75),
('2024-08-09', 900, '2025-08-09', 50, 60, 70, 80),
('2024-08-10', 1000, '2025-08-10', 55, 65, 75, 85);

-- Populando a tabela possui
INSERT INTO possui (id_estoque, id_remedio) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
(6, 6), (7, 7), (8, 8), (9, 9), (10, 10);

-- Populando a tabela cliente
INSERT INTO cliente (nome_cliente, cpf, endereco_cliente_numero, endereco_cliente_rua, endereco_cliente_bairro, endereco_cliente_cidade) VALUES
('Ana Lara', '12345678901', 10, 'Rua A', 'Bairro A', 'Cidade A'),
('João Silva', '23456789012', 20, 'Rua B', 'Bairro B', 'Cidade B'),
('Maria Oliveira', '34567890123', 30, 'Rua C', 'Bairro C', 'Cidade C'),
('Carlos Santos', '45678901234', 40, 'Rua D', 'Bairro D', 'Cidade D'),
('Patrícia Almeida', '56789012345', 50, 'Rua E', 'Bairro E', 'Cidade E'),
('Roberto Souza', '67890123456', 60, 'Rua F', 'Bairro F', 'Cidade F'),
('Fernanda Costa', '78901234567', 70, 'Rua G', 'Bairro G', 'Cidade G'),
('Ricardo Lima', '89012345678', 80, 'Rua H', 'Bairro H', 'Cidade H'),
('Juliana Ribeiro', '90123456789', 90, 'Rua I', 'Bairro I', 'Cidade I'),
('Luiz Pereira', '01234567890', 100, 'Rua J', 'Bairro J', 'Cidade J');

-- Populando a tabela telefone
INSERT INTO telefone (id_cliente, numero_telefone) VALUES
(1, '123456789'),
(2, '234567890'),
(3, '345678901'),
(4, '456789012'),
(5, '567890123'),
(6, '678901234'),
(7, '789012345'),
(8, '890123456'),
(9, '901234567'),
(10, '012345678');

-- Populando a tabela historico_compra
INSERT INTO historico_compra (receitas, ult_compra) VALUES
('Receita A', 'Compra A'),
('Receita B', 'Compra B'),
('Receita C', 'Compra C'),
('Receita D', 'Compra D'),
('Receita E', 'Compra E'),
('Receita F', 'Compra F'),
('Receita G', 'Compra G'),
('Receita H', 'Compra H'),
('Receita I', 'Compra I'),
('Receita J', 'Compra J');

-- Populando a tabela faz_parte
INSERT INTO faz_parte (id_historico, id_remedio) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
(6, 6), (7, 7), (8, 8), (9, 9), (10, 10);

-- Populando a tabela tem
INSERT INTO tem (id_historico, id_cliente) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
(6, 6), (7, 7), (8, 8), (9, 9), (10, 10);

-- Ver todas tabelas com os dados informados;
-- Exibir dados da tabela remedio
SELECT 'Tabela: remedio' AS tabela, * FROM remedio;

-- Exibir dados da tabela genericos
SELECT 'Tabela: genericos' AS tabela, * FROM genericos;

-- Exibir dados da tabela tarjas
SELECT 'Tabela: tarjas' AS tabela, * FROM tarjas;

-- Exibir dados da tabela de_marcas
SELECT 'Tabela: de_marcas' AS tabela, * FROM de_marcas;

-- Exibir dados da tabela pedido
SELECT 'Tabela: pedido' AS tabela, * FROM pedido;

-- Exibir dados da tabela esta_incluido
SELECT 'Tabela: esta_incluido' AS tabela, * FROM esta_incluido;

-- Exibir dados da tabela fornecedor
SELECT 'Tabela: fornecedor' AS tabela, * FROM fornecedor;

-- Exibir dados da tabela solicitacao
SELECT 'Tabela: solicitacao' AS tabela, * FROM solicitacao;

-- Exibir dados da tabela funcionario
SELECT 'Tabela: funcionario' AS tabela, * FROM funcionario;

-- Exibir dados da tabela realiza
SELECT 'Tabela: realiza' AS tabela, * FROM realiza;

-- Exibir dados da tabela estoque
SELECT 'Tabela: estoque' AS tabela, * FROM estoque;

-- Exibir dados da tabela possui
SELECT 'Tabela: possui' AS tabela, * FROM possui;

-- Exibir dados da tabela cliente
SELECT 'Tabela: cliente' AS tabela, * FROM cliente;

-- Exibir dados da tabela telefone
SELECT 'Tabela: telefone' AS tabela, * FROM telefone;

-- Exibir dados da tabela historico_compra
SELECT 'Tabela: historico_compra' AS tabela, * FROM historico_compra;

-- Exibir dados da tabela faz_parte
SELECT 'Tabela: faz_parte' AS tabela, * FROM faz_parte;

-- Exibir dados da tabela tem
SELECT 'Tabela: tem' AS tabela, * FROM tem;
