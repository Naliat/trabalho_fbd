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


-- Populando a tabela remedio
INSERT INTO remedio (nome, descricao, tipo_remedio, cores_tarjas) VALUES
('Paracetamol', 'Analgésico e antipirético', 'Genérico', 'Branca'),
('Amoxicilina', 'Antibiótico de largo espectro', 'Genérico', 'Branca'),
('Dorflex', 'Analgésico e relaxante muscular', 'De Marca', 'Vermelha'),
('Cataflam', 'Anti-inflamatório', 'De Marca', 'Vermelha'),
('Ibuprofeno', 'Antiinflamatório não esteroidal', 'Genérico', 'Vermelha'),
('Tylenol', 'Analgésico e antipirético', 'De Marca', 'Branca'),
('Losartana', 'Anti-hipertensivo', 'Genérico', 'Branca'),
('Pantoprazol', 'Inibidor da bomba de prótons', 'Genérico', 'Amarela'),
('Omeprazol', 'Inibidor da bomba de prótons', 'De Marca', 'Amarela'),
('Aspirina', 'Analgésico e antipirético', 'De Marca', 'Vermelha');

-- Populando a tabela pedido
INSERT INTO pedido (cod_rastr, status_pedido, data_pedido, qtd_rem_solic) VALUES
('BR1234567890', 'ENTREGUE', '2024-01-15', 100),
('BR0987654321', 'A CAMINHO', '2024-02-20', 200),
('BR1122334455', 'EM PRODUÇÃO', '2024-03-10', 150),
('BR5544332211', 'ENTREGUE', '2024-04-05', 300),
('BR6677889900', 'A CAMINHO', '2024-05-12', 50),
('BR7766554433', 'ENTREGUE', '2024-06-18', 500),
('BR8877665544', 'EM PRODUÇÃO', '2024-07-25', 250),
('BR9988776655', 'A CAMINHO', '2024-08-02', 120),
('BR1112223334', 'ENTREGUE', '2024-08-10', 400),
('BR4445556667', 'EM PRODUÇÃO', '2024-08-16', 180);

-- Populando a tabela fornecedor
INSERT INTO fornecedor (nome_empresa, cnpj, email, endereco_rua, endereco_numero, endereco_bairro, endereco_cidade, endereco_estado) VALUES
('Farmaco Ltda', '12345678000195', 'contato@farmaco.com', 'Rua A', 100, 'Centro', 'São Paulo', 'SP'),
('Medicinal SA', '98765432000112', 'vendas@medicinal.com', 'Rua B', 200, 'Vila Nova', 'Rio de Janeiro', 'RJ'),
('Saude Total', '19283746000129', 'comercial@saudetotal.com', 'Rua C', 300, 'Jardim', 'Belo Horizonte', 'MG'),
('Remedios Brasil', '56473829000145', 'suporte@remediosbrasil.com', 'Rua D', 400, 'Piedade', 'Recife', 'PE'),
('Farmaceutica Alfa', '67584932000167', 'info@alfa.com', 'Rua E', 500, 'Centro', 'Curitiba', 'PR'),
('BioSaude', '78945612000188', 'contato@biosaude.com', 'Rua F', 600, 'Bonsucesso', 'Salvador', 'BA'),
('BemEstar', '31415926000109', 'vendas@bemestar.com', 'Rua G', 700, 'Paulista', 'Fortaleza', 'CE'),
('PharmaLife', '11223344000123', 'comercial@pharmalife.com', 'Rua H', 800, 'Santana', 'Porto Alegre', 'RS'),
('VitalMedic', '99887766000114', 'suporte@vitalmedic.com', 'Rua I', 900, 'Copacabana', 'Rio de Janeiro', 'RJ'),
('Saude Forte', '55667788000136', 'info@saudeforte.com', 'Rua J', 1000, 'Leblon', 'São Paulo', 'SP');

-- Populando a tabela funcionario
INSERT INTO funcionario (nome, cargo, salario) VALUES
('João Silva', 'Farmacêutico', 3500.00),
('Maria Oliveira', 'Atendente', 2000.00),
('Carlos Santos', 'Gerente', 4500.00),
('Ana Paula', 'Caixa', 1800.00),
('Pedro Lima', 'Auxiliar de Farmácia', 2200.00),
('Mariana Souza', 'Farmacêutica', 3600.00),
('Lucas Ferreira', 'Estoquista', 2400.00),
('Juliana Almeida', 'Vendedora', 2500.00),
('Rafael Costa', 'Atendente', 2100.00),
('Fernanda Silva', 'Caixa', 1850.00);

-- Populando a tabela estoque
INSERT INTO estoque (data_entrega_stq, qtd_stq, data_vali_stq, unidade_medida) VALUES
('2024-01-10', 1000, '2024-12-31', 'Caixas'),
('2024-02-15', 800, '2024-11-30', 'Frascos'),
('2024-03-20', 600, '2024-10-31', 'Caixas'),
('2024-04-25', 1200, '2024-09-30', 'Unidades'),
('2024-05-30', 900, '2024-08-31', 'Cartelas'),
('2024-06-05', 500, '2024-07-31', 'Frascos'),
('2024-07-10', 400, '2024-06-30', 'Caixas'),
('2024-08-15', 1100, '2024-05-31', 'Unidades'),
('2024-09-20', 1300, '2024-04-30', 'Cartelas'),
('2024-10-25', 1400, '2024-03-31', 'Frascos');

-- Populando a tabela cliente
INSERT INTO cliente (nome_cliente, cpf, endereco_rua, endereco_numero, endereco_bairro, endereco_cidade) VALUES
('Luiz Carvalho', '12345678901', 'Av. Paulista', 1000, 'Bela Vista', 'São Paulo'),
('Roberta Lima', '98765432109', 'Rua das Flores', 200, 'Jardim Botânico', 'Rio de Janeiro'),
('Fernanda Pereira', '45678912301', 'Av. dos Andradas', 300, 'Centro', 'Belo Horizonte'),
('Gabriel Souza', '65432198701', 'Rua 15 de Novembro', 400, 'Centro', 'Curitiba'),
('Mariana Oliveira', '78912345601', 'Av. Paralela', 500, 'Imbuí', 'Salvador'),
('Paulo Henrique', '32165498701', 'Rua Marechal Deodoro', 600, 'Centro', 'Porto Alegre'),
('Juliana Santos', '15975325801', 'Av. Beira Mar', 700, 'Centro', 'Recife'),
('Ricardo Alves', '25815975301', 'Rua do Lazer', 800, 'Ponta Verde', 'Maceió'),
('Ana Clara', '75315925801', 'Av. Brasil', 900, 'Copacabana', 'Rio de Janeiro'),
('Lucas Menezes', '98732165401', 'Rua da Paz', 1000, 'Centro', 'Fortaleza');

-- Populando a tabela telefone
INSERT INTO telefone (id_cliente, numero_telefone) VALUES
(1, '(11) 91234-5678'),
(2, '(21) 99876-5432'),
(3, '(31) 98765-4321'),
(4, '(41) 97654-3210'),
(5, '(71) 96543-2109'),
(6, '(51) 95432-1098'),
(7, '(81) 94321-0987'),
(8, '(82) 93210-9876'),
(9, '(21) 92109-8765'),
(10, '(85) 91098-7654');

-- Populando a tabela historico_compra
INSERT INTO historico_compra (receitas, ult_compra, id_cliente) VALUES
('Receita A', '2024-01-10', 1),
('Receita B', '2024-02-15', 2),
('Receita C', '2024-03-20', 3),
('Receita D', '2024-04-25', 4),
('Receita E', '2024-05-30', 5),
('Receita F', '2024-06-05', 6),
('Receita G', '2024-07-10', 7),
('Receita H', '2024-08-15', 8),
('Receita I', '2024-09-20', 9),
('Receita J', '2024-10-25', 10);
