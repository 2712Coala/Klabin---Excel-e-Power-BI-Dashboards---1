USE ecommerce;

-- 🧍 CLIENTES
INSERT INTO clients (Fname, Minit, Lname, CPF, address) 
VALUES
('Maria','M','Silva','12346789011','Rua Silva de Prata 29, Carangola - Cidade das Flores'),
('Matheus','O','Pimentel','98765432100','Rua Alameda 289, Centro - Cidade das Flores'),
('Ricardo','F','Silva','45678913000','Avenida Alameda Vinha 1009, Centro - Cidade das Flores'),
('Julia','S','França','78912345600','Rua Laranjeiras 861, Centro - Cidade das Flores'),
('Roberta','G','Assis','98745631000','Avenida Koller 19, Centro - Cidade das Flores'),
('Isabela','M','Cruz','65478912300','Rua Alameda das Flores 28, Centro - Cidade das Flores');

SELECT * FROM clients;

-- 📦 PRODUTOS
INSERT INTO product (Pname, Classification_kids, Category, avaliacao, size)
VALUES
('Fone de ouvido', FALSE, 'Eletronico', 4.0, NULL),
('Barbie Elsa', TRUE, 'Brinquedos', 3.0, NULL),
('Body Carters', TRUE, 'Roupas', 5.0, NULL),
('Microfone Youtuber', FALSE, 'Eletronico', 4.0, NULL),
('Sofá retrátil', FALSE, 'Moveis', 3.0, '3x57x80'),
('Farinha de arroz', FALSE, 'Alimentos', 2.0, NULL),
('Fire Stick Amazon', FALSE, 'Eletronico', 3.0, NULL);

SELECT * FROM product;

-- 🧾 PEDIDOS (PROPOSALS)
INSERT INTO proposal (idProposal, idProposalClient, ProposalStatus, ProposalDescription,  totalValue,paymentMethod)
values
(1, 'Em andamento', 'Compra via aplicativo', NULL, TRUE),
(2, 'Em andamento', 'Compra via aplicativo', 50, FALSE),
(3, 'Confirmado', 'Compra via web site', NULL, TRUE),
(4, 'Confirmado', 'Compra via aplicativo', 150, FALSE);

SELECT * FROM proposal;

-- 🔗 PRODUTO ↔️ PEDIDO
INSERT INTO productProposal (idPOproduct, idPOproposal, poQuantity, poStatus)
VALUES
(1, 1, 2, 'Disponível'),
(2, 1, 1, 'Disponível'),
(3, 2, 1, 'Disponível');

SELECT * FROM productProposal;

-- 🏬 ESTOQUE
INSERT INTO storage (StorageLocation, quantity)
VALUES 
('Rio de Janeiro', 1000),
('Rio de Janeiro', 500),
('São Paulo', 10),
('São Paulo', 100),
('São Paulo', 10),
('Brasília', 60);

SELECT * FROM storage;

-- 🔗 PRODUTO ↔️ LOCAL DE ESTOQUE
INSERT INTO storageLocation (idLproduct, idLstorage, location)
VALUES
(1, 2, 'RJ'),
(2, 6, 'GO');

SELECT * FROM storageLocation;

-- 🧑‍💼 FORNECEDORES
INSERT INTO supplier (SocialName, CNPJ, contact)
VALUES 
('Almeida e Filhos', '12345678000199', '21985474747'),
('Eletrônicos Silva', '85451964000188', '21985484848'),
('Eletrônicos Valma', '93456789000177', '21975474747');

SELECT * FROM supplier;

-- 🔗 PRODUTO ↔️ FORNECEDOR
INSERT INTO productSupplier (idPsSupplier, idPsProduct, quantity)
VALUES
(1, 1, 500),
(1, 2, 400),
(2, 4, 633),
(3, 3, 5),
(2, 5, 10);

SELECT * FROM productSupplier;

-- 🧑‍💻 VENDEDORES
INSERT INTO seller (SocialName, AbstName, CNPJ, CPF, location, contact)
VALUES 
('Tech Eletronics', NULL, '12345678000155', NULL, 'Rio de Janeiro', '21994628700'),
('Boutique Durgas', NULL, NULL, '12345678300', 'Rio de Janeiro', '21956789500'),
('Kids World', NULL, '45678912000133', NULL, 'São Paulo', '11986574844');

SELECT * FROM seller;

-- 🔗 PRODUTO ↔️ VENDEDOR
INSERT INTO productSeller (idPseller, Socia, prodQuantity)
VALUES 
(1, 6, 80),
(2, 7, 10);

SELECT * FROM productSeller;

-- 🧮 CONSULTAS ÚTEIS

-- Total de clientes
SELECT COUNT(*) AS total_clients FROM clients;

-- Clientes e seus pedidos
SELECT c.Fname, c.Lname, p.idProposal AS Pedido, p.ProposalStatus AS Status
FROM clients c
JOIN proposal p ON c.idClient = p.idProposalClient;

-- Total de pedidos por cliente
SELECT c.idClient, CONCAT(Fname,' ',Lname) AS Cliente, COUNT(p.idProposal) AS Total_Pedidos
FROM clients c
JOIN proposal p ON c.idClient = p.idProposalClient
GROUP BY c.idClient;

-- Recuperar pedido com produtos associados
SELECT c.Fname, c.Lname, p.idProposal, pp.idPOproduct, pr.Pname, pp.poQuantity
FROM clients c
JOIN proposal p ON c.idClient = p.idProposalClient
JOIN productProposal pp ON pp.idPOproposal = p.idProposal
JOIN product pr ON pr.idProduct = pp.idPOproduct;
