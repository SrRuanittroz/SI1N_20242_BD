CREATE SCHEMA EC4_SI1N;

USE EC4_SI1N;



CREATE TABLE CLIENTES(
ID_CLIENTE INT PRIMARY KEY,
NOME VARCHAR(100) NOT NULL,
CPF VARCHAR(11) NOT NULL,
DATA_NASCIMENTO DATE NOT NULL,
ENDERECO VARCHAR(200) NOT NULL,
STATUS_FIDELIDADE BOOLEAN NOT NULL,
CONSTRAINT UNIQUE_CPF UNIQUE (CPF)
);

CREATE TABLE FORNECEDORES(
ID_FORNECEDOR INT PRIMARY KEY,
NOME VARCHAR(100) NOT NULL,
CONTATO VARCHAR(50) NOT NULL,
TELEFONE VARCHAR(15) NOT NULL,
CONSTRAINT UNIQUE_TELEFONE UNIQUE (TELEFONE)
);

CREATE TABLE PRODUTOS(
ID_PRODUTO INT PRIMARY KEY,
NOME VARCHAR(100) NOT NULL,
CATEGORIA VARCHAR(50) NOT NULL,
PRECO DECIMAL(10, 2) NOT NULL,
ESTOQUE INT NOT NULL,
ID_FORNECEDOR INT,
FOREIGN KEY (ID_FORNECEDOR) REFERENCES FORNECEDORES(ID_FORNECEDOR)
);

CREATE TABLE VENDAS(
ID_VENDA INT PRIMARY KEY,
ID_CLIENTE INT,
DATA_VENDA DATE NOT NULL,
VALOR_TOTAL DECIMAL(10, 2) NOT NULL,
FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTES(ID_CLIENTE)
);

CREATE TABLE PAGAMENTOS(
ID_PAGAMENTO INT PRIMARY KEY,
ID_VENDA INT,
DATA_PAGAMENTO DATE NOT NULL,
VALOR DECIMAL(10, 2) NOT NULL,
STATUS BOOLEAN NOT NULL,
FOREIGN KEY (ID_VENDA) REFERENCES VENDAS(ID_VENDA)
);
