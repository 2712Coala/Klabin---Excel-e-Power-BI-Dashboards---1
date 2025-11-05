-- 🚀 Desafio: Criação do Banco de Dados para o cenário de E-commerce --

CREATE DATABASE ecommerce;
USE ecommerce;

-- 🧍‍♀️ Tabela de Clientes --
CREATE TABLE clients (
  idClient INT AUTO_INCREMENT PRIMARY KEY,
  Fname VARCHAR(10),
  Minit CHAR(3),
  Lname VARCHAR(20),
  CPF CHAR(11) NOT NULL,
  address VARCHAR(30),
  CONSTRAINT unique_cpf_client UNIQUE (CPF)
);

-- 📦 Tabela de Produtos --
CREATE TABLE product (
  idProduct INT AUTO_INCREMENT PRIMARY KEY,
  Pname VARCHAR(50),
  Classification_kids BOOLEAN DEFAULT FALSE,
  Category ENUM('Eletronico','Roupas','Brinquedos','Alimentos','Moveis') NOT NULL,
  avaliacao FLOAT DEFAULT 0,
  size VARCHAR(10)
);

-- 💳 Tabela de Pagamentos --
CREATE TABLE payments (
  idPayment INT AUTO_INCREMENT PRIMARY KEY,
  idClient INT NOT NULL,
  cash DECIMAL(10,2) NOT NULL,
  paymentDate DATETIME DEFAULT NOW(),
  paymentMethod VARCHAR(50),
  paymentStatus VARCHAR(30) DEFAULT 'pending',
  FOREIGN KEY (idClient) REFERENCES clients(idClient)
);

-- 📑 Tabela de Pedidos --
CREATE TABLE proposal (
  idProposal INT AUTO_INCREMENT PRIMARY KEY,
  idProposalClient INT,
  ProposalStatus ENUM('Cancelado','Confirmado','Em andamento') NOT NULL,
  ProposalDescription VARCHAR(255),
  totalValue FLOAT DEFAULT 0,
  paymentMethod BOOLEAN DEFAULT FALSE,
  CONSTRAINT fk_proposal_client FOREIGN KEY (idProposalClient) REFERENCES clients(idClient)
);

-- 🏬 Tabela de Estoque --
CREATE TABLE storage (
  idProdStorage INT AUTO_INCREMENT PRIMARY KEY,
  StorageLocation VARCHAR(255),
  quantity INT DEFAULT 0
);

-- 🧾 Tabela de Fornecedores --
CREATE TABLE supplier (
  idSupplier INT AUTO_INCREMENT PRIMARY KEY,
  SocialName VARCHAR(255) NOT NULL,
  CNPJ CHAR(14) NOT NULL,
  contact CHAR(11) NOT NULL,
  CONSTRAINT unique_supplier UNIQUE (CNPJ)
);

-- 🛍️ Tabela de Vendedores --
CREATE TABLE seller (
  idSeller INT AUTO_INCREMENT PRIMARY KEY,
  SocialName VARCHAR(255) NOT NULL,
  AbstName VARCHAR(255),
  CNPJ CHAR(14) NOT NULL,
  CPF CHAR(11),
  location VARCHAR(255),
  contact CHAR(11) NOT NULL,
  CONSTRAINT unique_cnpj_seller UNIQUE (CNPJ),
  CONSTRAINT unique_cpf_seller UNIQUE (CPF)
);

-- 🔗 Relacionamento Produto ↔️ Vendedor --
CREATE TABLE productSeller (
  idPseller INT,
  idPproduct INT,
  prodQuantity INT DEFAULT 1,
  PRIMARY KEY (idPseller, idPproduct),
  CONSTRAINT fk_product_seller FOREIGN KEY (idPseller) REFERENCES seller(idSeller),
  CONSTRAINT fk_product_product FOREIGN KEY (idPproduct) REFERENCES product(idProduct)
);

-- 🔗 Relacionamento Produto ↔️ Pedido --
CREATE TABLE productProposal (
  idPOproduct INT,
  idPOproposal INT,
  poQuantity INT DEFAULT 1,
  poStatus ENUM('Disponível', 'Sem estoque') DEFAULT 'Disponível',
  PRIMARY KEY (idPOproduct, idPOproposal),
  CONSTRAINT fk_product_proposal_product FOREIGN KEY (idPOproduct) REFERENCES product(idProduct),
  CONSTRAINT fk_product_proposal_proposal FOREIGN KEY (idPOproposal) REFERENCES proposal(idProposal)
);

-- 🔗 Relacionamento Produto ↔️ Estoque --
CREATE TABLE storageLocation (
  idLproduct INT,
  idLstorage INT,
  location VARCHAR(255) NOT NULL,
  PRIMARY KEY (idLproduct, idLstorage),
  CONSTRAINT fk_storage_location_product FOREIGN KEY (idLproduct) REFERENCES product(idProduct),
  CONSTRAINT fk_storage_location_storage FOREIGN KEY (idLstorage) REFERENCES storage(idProdStorage)
);

-- 🔗 Relacionamento Produto ↔️ Fornecedor --
CREATE TABLE productSupplier (
  idPsSupplier INT,
  idPsProduct INT,
  quantity INT NOT NULL,
  PRIMARY KEY (idPsSupplier, idPsProduct),
  CONSTRAINT fk_product_supplier_supplier FOREIGN KEY (idPsSupplier) REFERENCES supplier(idSupplier),
  CONSTRAINT fk_product_supplier_product FOREIGN KEY (idPsProduct) REFERENCES product(idProduct)
);

-- ✅ Mostrar resultado final --
SHOW TABLES;
