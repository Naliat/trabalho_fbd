-- Tabela Remédio
INSERT INTO remedio (nome, descricao) VALUES
('Paracetamol', 'Analgésico e antipirético'),
('Ibuprofeno', 'Anti-inflamatório e analgésico'),
('Amoxicilina', 'Antibiótico de amplo espectro'),
('Dipirona', 'Analgésico e antipirético'),
('Loratadina', 'Antialérgico'),
('Omeprazol', 'Inibidor de ácido gástrico'),
('Simeticona', 'Antiflatulento'),
('Clonazepam', 'Ansiolítico'),
('Metformina', 'Antidiabético oral'),
('Losartana', 'Antihipertensivo');

-- Tabela Genéricos
INSERT INTO genericos (id_remedio) VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10);

-- Tabela Tarjas
INSERT INTO tarjas (id_remedio, cores_tarjas) VALUES
(1, 'Vermelha'),
(2, 'Vermelha'),
(3, 'Vermelha'),
(4, 'Vermelha'),
(5, 'Amarela'),
(6, 'Vermelha'),
(7, 'Amarela'),
(8, 'Preta'),
(9, 'Amarela'),
(10, 'Vermelha');

-- Tabela de Marcas
INSERT INTO de_marcas (id_remedio) VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10);

-- Tabela Pedidos
INSERT INTO pedido (cod_rastr, status_pedido, data_pedido, qtd_rem_solic) VALUES
('RAST123456', 'EM PRODUÇÃO', '2024-08-01', 100),
('RAST123457', 'A CAMINHO', '2024-08-02', 200),
('RAST123458', 'ENTREGUE', '2024-08-03', 150),
('RAST123459', 'ENTREGUE', '2024-08-04', 120),
('RAST123460', 'A CAMINHO', '2024-08-05', 300),
('RAST123461', 'EM PRODUÇÃO', '2024-08-06', 90),
('RAST123462', 'A CAMINHO', '2024-08-07', 80),
('RAST123463', 'ENTREGUE', '2024-08-08', 250),
('RAST123464', 'EM PRODUÇÃO', '2024-08-09', 130),
('RAST123465', 'ENTREGUE', '2024-08-10', 110);

-- Tabela Relacional entre Remédio e Pedido
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

-- Tabela Fornecedor
INSERT INTO fornecedor (nome_empresa, cnpj, email, endereco_rua, endereco_numero, endereco_bairro, endereco_cidade, endereco_estado) VALUES
('Fornecedor A', '12345678000101', 'fornecedorA@example.com', 'Rua A', 100, 'Centro', 'São Paulo', 'SP'),
('Fornecedor B', '12345678000201', 'fornecedorB@example.com', 'Rua B', 200, 'Centro', 'Rio de Janeiro', 'RJ'),
('Fornecedor C', '12345678000301', 'fornecedorC@example.com', 'Rua C', 300, 'Centro', 'Belo Horizonte', 'MG'),
('Fornecedor D', '12345678000401', 'fornecedorD@example.com', 'Rua D', 400, 'Centro', 'Curitiba', 'PR'),
('Fornecedor E', '12345678000501', 'fornecedorE@example.com', 'Rua E', 500, 'Centro', 'Porto Alegre', 'RS'),
('Fornecedor F', '12345678000601', 'fornecedorF@example.com', 'Rua F', 600, 'Centro', 'Salvador', 'BA'),
('Fornecedor G', '12345678000701', 'fornecedorG@example.com', 'Rua G', 700, 'Centro', 'Fortaleza', 'CE'),
('Fornecedor H', '12345678000801', 'fornecedorH@example.com', 'Rua H', 800, 'Centro', 'Recife', 'PE'),
('Fornecedor I', '12345678000901', 'fornecedorI@example.com', 'Rua I', 900, 'Centro', 'Manaus', 'AM'),
('Fornecedor J', '12345678001001', 'fornecedorJ@example.com', 'Rua J', 1000, 'Centro', 'Brasília', 'DF');

-- Tabela Relacional entre Pedido e Fornecedor
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

-- Tabela Funcionário
INSERT INTO funcionario (nome, cargo, salario) VALUES
('João Silva', 'Farmacêutico', 3000.00),
('Maria Santos', 'Atendente', 2000.00),
('Pedro Oliveira', 'Caixa', 1800.00),
('Ana Pereira', 'Estoquista', 2500.00),
('Lucas Souza', 'Gerente', 4000.00),
('Fernanda Lima', 'Auxiliar', 1500.00),
('Ricardo Almeida', 'Técnico', 3200.00),
('Carla Ferreira', 'Atendente', 2000.00),
('Bruno Costa', 'Auxiliar', 1500.00),
('Juliana Cardoso', 'Farmacêutica', 3000.00);

-- Tabela Relacional entre Funcionário e Pedido
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

-- Tabela Estoque
INSERT INTO estoque (data_entrega_stq, qtd_stq, data_vali_stq, medida_frascos, medida_caixas, medida_cartelas, medida_unidade) VALUES
('2024-08-15', 500, '2025-08-15', 100, 50, 25, 325),
('2024-08-16', 600, '2025-08-16', 150, 60, 30, 360),
('2024-08-17', 700, '2025-08-17', 200, 70, 35, 395),
('2024-08-18', 800, '2025-08-18', 250, 80, 40, 430),
('2024-08-19', 900, '2025-08-19', 300, 90, 45, 465),
('2024-08-20', 1000, '2025-08-20', 350, 100, 50, 500),
('2024-08-21', 1100, '2025-08-21', 400, 110, 55, 535),
('2024-08-22', 1200, '2025-08-22', 450, 120, 60, 570),
('2024-08-23', 1300, '2025-08-23', 500, 130, 65, 605),
('2024-08-24', 1400, '2025-08-24', 550, 140, 70, 640);

-- Tabela Relacional entre Estoque e Remédio
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

-- Tabela Cliente
INSERT INTO cliente (nome_cliente, cpf, endereco_rua, endereco_numero, endereco_bairro, endereco_cidade) VALUES
('José Almeida', '12345678901', 'Rua A', 101, 'Centro', 'São Paulo'),
('Mariana Costa', '98765432101', 'Rua B', 102, 'Centro', 'Rio de Janeiro'),
('Carlos Pereira', '45678912301', 'Rua C', 103, 'Centro', 'Belo Horizonte'),
('Ana Lima', '78912345601', 'Rua D', 104, 'Centro', 'Curitiba'),
('Lucas Ferreira', '32165498701', 'Rua E', 105, 'Centro', 'Porto Alegre'),
('Juliana Souza', '65498732101', 'Rua F', 106, 'Centro', 'Salvador'),
('Fernando Oliveira', '98732165401', 'Rua G', 107, 'Centro', 'Fortaleza'),
('Patrícia Mendes', '65432178901', 'Rua H', 108, 'Centro', 'Recife'),
('Rodrigo Cardoso', '12378945601', 'Rua I', 109, 'Centro', 'Manaus'),
('Amanda Silva', '78965412301', 'Rua J', 110, 'Centro', 'Brasília');

-- Tabela Telefone
INSERT INTO telefone (id_cliente, numero_telefone) VALUES
(1, '11987654321'),
(2, '21987654321'),
(3, '31987654321'),
(4, '41987654321'),
(5, '51987654321'),
(6, '61987654321'),
(7, '71987654321'),
(8, '81987654321'),
(9, '91987654321'),
(10, '11987654322');

-- Tabela Histórico de Compra
INSERT INTO historico_compra (receitas, ult_compra, id_cliente) VALUES
('Receita para Paracetamol', '2024-08-10', 1),
('Receita para Ibuprofeno', '2024-08-11', 2),
('Receita para Amoxicilina', '2024-08-12', 3),
('Receita para Dipirona', '2024-08-13', 4),
('Receita para Loratadina', '2024-08-14', 5),
('Receita para Omeprazol', '2024-08-15', 6),
('Receita para Simeticona', '2024-08-16', 7),
('Receita para Clonazepam', '2024-08-17', 8),
('Receita para Metformina', '2024-08-18', 9),
('Receita para Losartana', '2024-08-19', 10);

-- Tabela Relacional entre Histórico de Compra e Remédio
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

-- Tabela Relacional entre Histórico de Compra e Cliente
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