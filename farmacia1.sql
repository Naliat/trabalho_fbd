CREATE SCHEMA farmacia;
SET SCHEMA 'farmacia';

-- Tabela Remedio
CREATE TABLE remedio (
    id_remedio SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    descricao VARCHAR(255) NOT NULL
);

-- Tabela Genéricos, herda atributos da tabela Remédio
CREATE TABLE genericos (
    id_generico SERIAL PRIMARY KEY
) INHERITS (remedio);

-- Tabela Tarjas, herda atributos da tabela Remédio
CREATE TABLE tarjas (
    id_tarjas SERIAL PRIMARY KEY,
    cores_tarjas VARCHAR(255) NOT NULL
) INHERITS (remedio);

-- Tabela de Marcas, herda atributos da tabela Remédio
CREATE TABLE de_marcas (
    id_marcas SERIAL PRIMARY KEY
) INHERITS (remedio);

-- Tabela Pedidos
CREATE TABLE pedido (
    id_pedido SERIAL PRIMARY KEY,
    cod_rastr VARCHAR(50) UNIQUE,
    status_pedido VARCHAR(50) NOT NULL CHECK (status_pedido IN ('EM PRODUÇÃO', 'A CAMINHO', 'ENTREGUE')),
    data_pedido DATE,
    qtd_rem_solic INTEGER
);

-- Tabela Relacional entre Remédio e Pedido
CREATE TABLE esta_incluido (
    id_remedio INTEGER NOT NULL REFERENCES remedio (id_remedio),
    id_pedido INTEGER NOT NULL REFERENCES pedido (id_pedido),
    PRIMARY KEY (id_remedio, id_pedido)
);

-- Tabela Fornecedor
CREATE TABLE fornecedor (
    id_fornecedor SERIAL PRIMARY KEY,
    nome_empresa VARCHAR(255) UNIQUE NOT NULL,
    cnpj VARCHAR(14) UNIQUE NOT NULL,
    email VARCHAR(255),
    endereco_numero INTEGER,
    endereco_rua VARCHAR(255),
    endereco_bairro VARCHAR(255),
    endereco_cidade VARCHAR(255),
    endereco_estado CHAR(2)
);

-- Tabela Relacional entre Pedido e Fornecedor
CREATE TABLE solicitacao (
    id_pedido INTEGER NOT NULL REFERENCES pedido (id_pedido),
    id_fornecedor INTEGER NOT NULL REFERENCES fornecedor (id_fornecedor),
    PRIMARY KEY (id_pedido, id_fornecedor)
);

-- Tabela Funcionário
CREATE TABLE funcionario (
    id_funcionario SERIAL PRIMARY KEY,
    salario NUMERIC(10, 2),
    cargo VARCHAR(255),
    nome VARCHAR(255)
);

-- Tabela Relacional entre Funcionário e Pedido
CREATE TABLE realiza (
    id_funcionario INTEGER NOT NULL REFERENCES funcionario (id_funcionario),
    id_pedido INTEGER NOT NULL REFERENCES pedido (id_pedido),
    PRIMARY KEY (id_funcionario, id_pedido)
);

-- Tabela Estoque
CREATE TABLE estoque (
    id_estoque SERIAL PRIMARY KEY,
    data_entrega_stq DATE,
    qtd_stq INTEGER,
    data_vali_stq DATE,
    medida_frascos INTEGER,
    medida_caixas INTEGER,
    medida_cartelas INTEGER,
    medida_unidade INTEGER
);

-- Tabela Relacional entre Estoque e Remédio
CREATE TABLE possui (
    id_estoque INTEGER NOT NULL REFERENCES estoque (id_estoque),
    id_remedio INTEGER NOT NULL REFERENCES remedio (id_remedio),
    PRIMARY KEY (id_estoque, id_remedio)
);

-- Tabela Cliente
CREATE TABLE cliente (
    id_cliente SERIAL PRIMARY KEY,
    nome_cliente VARCHAR(255),
    cpf CHAR(11) CHECK (char_length(cpf) = 11) NOT NULL,
    endereco_cliente_numero INTEGER,
    endereco_cliente_rua VARCHAR(255),
    endereco_cliente_bairro VARCHAR(255),
    endereco_cliente_cidade VARCHAR(255)
);

-- Tabela Telefone, relacionada ao atributo multivalorado de Cliente
CREATE TABLE telefone (
    id_telefone SERIAL PRIMARY KEY,
    id_cliente INTEGER NOT NULL REFERENCES cliente (id_cliente),
    numero_telefone VARCHAR(20) UNIQUE
);

-- Tabela Histórico de Compra
CREATE TABLE historico_compra (
    id_historico SERIAL PRIMARY KEY,
    receitas VARCHAR(255),
    ult_compra VARCHAR(255)
);

-- Tabela Relacional entre Histórico de Compra e Remédio
CREATE TABLE faz_parte (
    id_historico INTEGER NOT NULL REFERENCES historico_compra (id_historico),
    id_remedio INTEGER NOT NULL REFERENCES remedio (id_remedio),
    PRIMARY KEY (id_historico, id_remedio)
);

-- Tabela Relacional entre Histórico de Compra e Cliente
CREATE TABLE tem (
    id_historico INTEGER NOT NULL REFERENCES historico_compra (id_historico),
    id_cliente INTEGER NOT NULL REFERENCES cliente (id_cliente),
    PRIMARY KEY (id_historico, id_cliente)
);



-- Populando a tabela Remédio
INSERT INTO remedio (nome, descricao) VALUES 
('Paracetamol', 'Analgésico e antipirético'),
('Ibuprofeno', 'Anti-inflamatório e analgésico'),
('Amoxicilina', 'Antibiótico de amplo espectro'),
('Dipirona', 'Analgésico e antipirético'),
('Aspirina', 'Anti-inflamatório e antipirético'),
('Losartana', 'Antagonista dos receptores da angiotensina II'),
('Clonazepam', 'Benzodiazepínico usado como anticonvulsivante'),
('Omeprazol', 'Inibidor de bomba de prótons, usado para úlceras gástricas'),
('Simvastatina', 'Inibidor de HMG-CoA redutase, usado para baixar colesterol'),
('Metformina', 'Antidiabético oral, usado no tratamento de diabetes tipo 2');

-- Populando a tabela Genéricos
INSERT INTO genericos (nome, descricao) VALUES 
('Paracetamol Genérico', 'Analgésico e antipirético'),
('Ibuprofeno Genérico', 'Anti-inflamatório e analgésico'),
('Amoxicilina Genérica', 'Antibiótico de amplo espectro'),
('Dipirona Genérica', 'Analgésico e antipirético'),
('Aspirina Genérica', 'Anti-inflamatório e antipirético'),
('Losartana Genérica', 'Antagonista dos receptores da angiotensina II'),
('Clonazepam Genérico', 'Benzodiazepínico usado como anticonvulsivante'),
('Omeprazol Genérico', 'Inibidor de bomba de prótons, usado para úlceras gástricas'),
('Simvastatina Genérica', 'Inibidor de HMG-CoA redutase, usado para baixar colesterol'),
('Metformina Genérica', 'Antidiabético oral, usado no tratamento de diabetes tipo 2');

-- Populando a tabela Tarjas
INSERT INTO tarjas (nome, descricao, cores_tarjas) VALUES 
('Paracetamol', 'Analgésico e antipirético', 'Vermelha'),
('Ibuprofeno', 'Anti-inflamatório e analgésico', 'Vermelha'),
('Amoxicilina', 'Antibiótico de amplo espectro', 'Amarela'),
('Dipirona', 'Analgésico e antipirético', 'Vermelha'),
('Aspirina', 'Anti-inflamatório e antipirético', 'Amarela'),
('Losartana', 'Antagonista dos receptores da angiotensina II', 'Vermelha'),
('Clonazepam', 'Benzodiazepínico usado como anticonvulsivante', 'Preta'),
('Omeprazol', 'Inibidor de bomba de prótons, usado para úlceras gástricas', 'Vermelha'),
('Simvastatina', 'Inibidor de HMG-CoA redutase, usado para baixar colesterol', 'Amarela'),
('Metformina', 'Antidiabético oral, usado no tratamento de diabetes tipo 2', 'Vermelha');

-- Populando a tabela de Marcas
INSERT INTO de_marcas (nome, descricao) VALUES 
('Tylenol', 'Analgésico e antipirético'),
('Advil', 'Anti-inflamatório e analgésico'),
('Amoxil', 'Antibiótico de amplo espectro'),
('Novalgina', 'Analgésico e antipirético'),
('Aspirina Bayer', 'Anti-inflamatório e antipirético'),
('Cozaar', 'Antagonista dos receptores da angiotensina II'),
('Rivotril', 'Benzodiazepínico usado como anticonvulsivante'),
('Losec', 'Inibidor de bomba de prótons, usado para úlceras gástricas'),
('Zocor', 'Inibidor de HMG-CoA redutase, usado para baixar colesterol'),
('Glyciphage', 'Antidiabético oral, usado no tratamento de diabetes tipo 2');

-- Populando a tabela Pedidos
INSERT INTO pedido (cod_rastr, status_pedido, data_pedido, qtd_rem_solic) VALUES 
('RAST001', 'EM PRODUÇÃO', '2024-08-01', 100),
('RAST002', 'A CAMINHO', '2024-08-02', 50),
('RAST003', 'ENTREGUE', '2024-08-03', 150),
('RAST004', 'A CAMINHO', '2024-08-04', 200),
('RAST005', 'EM PRODUÇÃO', '2024-08-05', 80),
('RAST006', 'ENTREGUE', '2024-08-06', 60),
('RAST007', 'A CAMINHO', '2024-08-07', 90),
('RAST008', 'ENTREGUE', '2024-08-08', 70),
('RAST009', 'EM PRODUÇÃO', '2024-08-09', 110),
('RAST010', 'A CAMINHO', '2024-08-10', 120);

-- Populando a tabela Esta Incluído
INSERT INTO esta_incluido (id_remedio, id_pedido) VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

-- Populando a tabela Fornecedor
INSERT INTO fornecedor (nome_empresa, cnpj, email, endereco_numero, endereco_rua, endereco_bairro, endereco_cidade, endereco_estado) VALUES 
('Farmácia São João', '12345678000101', 'contato@saovao.com', 100, 'Rua Principal', 'Centro', 'Porto Alegre', 'RS'),
('Droga Raia', '98765432000109', 'contato@droga.com', 200, 'Avenida Central', 'Cidade Baixa', 'Curitiba', 'PR'),
('Panvel', '11223344000155', 'contato@panvel.com', 300, 'Rua das Flores', 'Jardim', 'São Paulo', 'SP'),
('Pacheco', '99887766000102', 'contato@pacheco.com', 400, 'Avenida Paulista', 'Centro', 'São Paulo', 'SP'),
('Onofre', '55667788000111', 'contato@onofre.com', 500, 'Rua Augusta', 'Centro', 'Rio de Janeiro', 'RJ'),
('ExtraFarma', '44332211000108', 'contato@extra.com', 600, 'Avenida Brasil', 'Vila Mariana', 'Recife', 'PE'),
('Pague Menos', '66778899000144', 'contato@pague.com', 700, 'Rua da Praia', 'Centro', 'Salvador', 'BA'),
('Ultrafarma', '33556677000122', 'contato@ultra.com', 800, 'Avenida Atlântica', 'Copacabana', 'Rio de Janeiro', 'RJ'),
('Drogasil', '77441122000133', 'contato@drogasil.com', 900, 'Rua XV de Novembro', 'Centro', 'Curitiba', 'PR'),
('Venâncio', '22113344000166', 'contato@venancio.com', 1000, 'Rua da Alfândega', 'Centro', 'Porto Alegre', 'RS');

-- Populando a tabela Solicitação
INSERT INTO solicitacao (id_pedido, id_fornecedor) VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

-- Populando a tabela Funcionário
INSERT INTO funcionario (salario, cargo, nome) VALUES 
(3500.00, 'Atendente', 'João Silva'),
(4500.00, 'Farmacêutico', 'Maria Oliveira'),
(5000.00, 'Gerente', 'Carlos Souza'),
(3000.00, 'Caixa', 'Ana Lima'),
(3800.00, 'Atendente', 'Pedro Mendes'),
(4200.00, 'Farmacêutico', 'Luísa Fernandes'),
(5500.00, 'Gerente', 'Clara Costa'),
(2900.00, 'Caixa', 'Bruno Pereira'),
(3700.00, 'Atendente', 'Fernanda Santos'),
(4400.00, 'Farmacêutico', 'Lucas Almeida');

-- Populando a tabela Realiza
INSERT INTO realiza (id_funcionario, id_pedido) VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

-- Populando a tabela Estoque
INSERT INTO estoque (data_entrega_stq, qtd_stq, data_vali_stq, medida_frascos, medida_caixas, medida_cartelas, medida_unidade) VALUES 
('2024-07-01', 100, '2025-07-01', 50, 30, 10, 10),
('2024-07-02', 200, '2025-07-02', 60, 40, 20, 20),
('2024-07-03', 300, '2025-07-03', 70, 50, 30, 30),
('2024-07-04', 400, '2025-07-04', 80, 60, 40, 40),
('2024-07-05', 500, '2025-07-05', 90, 70, 50, 50),
('2024-07-06', 600, '2025-07-06', 100, 80, 60, 60),
('2024-07-07', 700, '2025-07-07', 110, 90, 70, 70),
('2024-07-08', 800, '2025-07-08', 120, 100, 80, 80),
('2024-07-09', 900, '2025-07-09', 130, 110, 90, 90),
('2024-07-10', 1000, '2025-07-10', 140, 120, 100, 100);

-- Populando a tabela Possui
INSERT INTO possui (id_estoque, id_remedio) VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

-- Populando a tabela Cliente
INSERT INTO cliente (nome_cliente, cpf, endereco_cliente_numero, endereco_cliente_rua, endereco_cliente_bairro, endereco_cliente_cidade) VALUES 
('Carlos Almeida', '12345678901', 100, 'Rua A', 'Centro', 'São Paulo'),
('Mariana Santos', '98765432102', 200, 'Rua B', 'Jardim', 'Rio de Janeiro'),
('Roberto Costa', '11122233344', 300, 'Rua C', 'Vila Mariana', 'Salvador'),
('Ana Paula', '55566677788', 400, 'Rua D', 'Copacabana', 'Belo Horizonte'),
('João Pedro', '99988877766', 500, 'Rua E', 'Centro', 'Porto Alegre'),
('Fernanda Lima', '33344455522', 600, 'Rua F', 'Centro', 'Curitiba'),
('Ricardo Oliveira', '77788899900', 700, 'Rua G', 'Cidade Baixa', 'Recife'),
('Patrícia Mendes', '22233344411', 800, 'Rua H', 'Jardim', 'Fortaleza'),
('Lucas Pereira', '66655544433', 900, 'Rua I', 'Centro', 'São Luís'),
('Juliana Fernandes', '88877766655', 1000, 'Rua J', 'Centro', 'Manaus');

-- Populando a tabela Telefone
INSERT INTO telefone (id_cliente, numero_telefone) VALUES 
(1, '(11) 99999-0001'),
(2, '(21) 99999-0002'),
(3, '(71) 99999-0003'),
(4, '(31) 99999-0004'),
(5, '(51) 99999-0005'),
(6, '(41) 99999-0006'),
(7, '(81) 99999-0007'),
(8, '(85) 99999-0008'),
(9, '(98) 99999-0009'),
(10, '(92) 99999-0010');

-- Populando a tabela Histórico de Compra
INSERT INTO historico_compra (receitas, ult_compra) VALUES 
('Receita para antibiótico', '2024-06-15'),
('Receita para anti-inflamatório', '2024-07-01'),
('Receita para analgésico', '2024-07-05'),
('Receita para antiácido', '2024-07-10'),
('Receita para antidiabético', '2024-07-15'),
('Receita para ansiolítico', '2024-07-20'),
('Receita para anti-hipertensivo', '2024-07-25'),
('Receita para antibiótico', '2024-07-30'),
('Receita para antitérmico', '2024-08-05'),
('Receita para hipoglicemiante', '2024-08-10');

-- Populando a tabela Faz Parte
INSERT INTO faz_parte (id_historico, id_remedio) VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

-- Populando a tabela Tem
INSERT INTO tem (id_historico, id_cliente) VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);






