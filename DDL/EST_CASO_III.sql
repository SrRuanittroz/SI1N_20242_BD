CREATE SCHEMA EC3_SI1N;

USE EC3_SI1N;

CREATE TABLE IF NOT EXISTS CLIENTES(
COD_CLIENTE INT PRIMARY KEY,
CNPJ_CLIENTE INT NOT NULL,
NOME_CLIENTE VARCHAR(45) NOT NULL,
RAZAO_SOCIAL_CLIENTE INT NOT NULL,
RAMO_ATIVIDADE VARCHAR(15) NOT NULL,
DATA_CADASTRAMENTO DATE NOT NULL,
PESSOA_CONTATO VARCHAR(45) NOT NULL
);

CREATE TABLE IF NOT EXISTS EMPREGADOS(
EMPREGADO_MATRICULA INT PRIMARY KEY,
EMPREGADO_NOME VARCHAR(45) NOT NULL,
EMPREGADO_CARGO VARCHAR(15) NOT NULL,
EMPREGADO_SALARIO INT NOT NULL,
EMPREGADO_ADMISSAO DATE NOT NULL,
EMPREGADO_QUALIFICACOES TEXT NOT NULL,
EMPREGADO_ENDERECO INT NOT NULL
);

CREATE TABLE IF NOT EXISTS EMPRESAS(
EMPRESAS_CNPJ INT PRIMARY KEY,
EMPRESAS_RAZAO_SOCIAL INT NOT NULL,
EMPRESAS_PESSOA_CONTATO VARCHAR(45) NOT NULL
);

CREATE TABLE IF NOT EXISTS FORNECEDORES(
FORN_CNPJ INT PRIMARY KEY,
FORN_RAZAO_SOCIAL INT NOT NULL,
FORN_PESSOA_CONTATO VARCHAR(45) NOT NULL
);

CREATE TABLE IF NOT EXISTS TIPO_DE_ENDERECO(
TIP_END_COD INT PRIMARY KEY,
TIP_END_NOME VARCHAR(45) NOT NULL
);

CREATE TABLE IF NOT EXISTS ENDERECOS (
END_NUM INT PRIMARY KEY,
END_LOGRADOURO VARCHAR(150),
END_COMPLEMENTO VARCHAR(50),
END_CEP VARCHAR(10),
END_BAIRRO VARCHAR(50),
END_CIDADE VARCHAR(50),
END_ESTADO VARCHAR(2)
);

CREATE TABLE IF NOT EXISTS ENCOMENDAS(
ENC_NUM INT PRIMARY KEY,
ENC_DATA_INCLUSAO DATE NOT NULL,
ENC_VALOR_TOTAL INT NOT NULL,
ENC_VALOR_DESCONTO INT NOT NULL,
ENC_VALOR_LIQUIDO INT NOT NULL,
ENC_ID_FORMA_PAGAMENTO INT NOT NULL,
ENC_QUANT_PARCELA INT NOT NULL
);

CREATE TABLE IF NOT EXISTS PRODUTOS(
PROD_COD INT PRIMARY KEY,
PROD_NOME VARCHAR(45) NOT NULL,
PROD_COR VARCHAR(30),
PROD_DIM VARCHAR(50),
PROD_PESO DECIMAL(10, 2),
PROD_PRECO DECIMAL(10, 2),
PROD_TEMP_FABRICACAO INT,
PROD_DESENHO TEXT,
HORAS_MAO_OBRA DECIMAL(5, 2)
);

CREATE TABLE IF NOT EXISTS TIPOS_DE_COMPONENTE(
TIP_COMP_COD INT PRIMARY KEY,
TIP_COMP_NOME VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS COMPONENTES(
COMP_COD INT PRIMARY KEY AUTO_INCREMENT,
COMP_NOME VARCHAR(100) NOT NULL,
COMP_QUANTIDADE_ESTOQUE INT NOT NULL,
COMP_PRECO_UNITARIO DECIMAL(10, 2) NOT NULL,
COMP_UNIDADE VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS MAQUINAS(
MAQ_TEMPO_VIDA INT NOT NULL,
MAQ_DATA_COMPRA DATE NOT NULL,
MAQ_DATA_FIM_GARANTIA DATE
);

CREATE TABLE IF NOT EXISTS RE(
RE_QUANTIDADE_NECESSARIA INT NOT NULL,
RE_UNIDADE VARCHAR(50) NOT NULL,
RE_TEMPO_USO INT,
RE_HORAS_MAO_OBRA DECIMAL(5, 2)
);

CREATE TABLE IF NOT EXISTS RM(
RM_DATA DATE NOT NULL,
RM_DESCRICAO VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS RS(
RS_QUANTIDADE INT NOT NULL,
RS_DATA_NECESSIDADE DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS TELEFONE(
TEL_NUM INT PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS PESSOA_CONTATO(
CONTATO_ID INT PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS CLIENTES_ENCOMENDAS(
COD_CLIENTE INT,
ENC_NUM INT,
PRIMARY KEY(COD_CLIENTE, ENC_NUM),
CONSTRAINT FK_CLIENTES_ENCOMENDAS_CLIENTES FOREIGN KEY(COD_CLIENTE) REFERENCES CLIENTES(COD_CLIENTE),
CONSTRAINT FK_CLIENTES_ENCOMENDAS_ENCOMENDAS FOREIGN KEY(ENC_NUM) REFERENCES ENCOMENDAS(ENC_NUM)
);

CREATE TABLE IF NOT EXISTS EMPREGADOS_FORNECEDORES(
EMPREGADO_MATRICULA INT,
FORN_CNPJ INT,
PRIMARY KEY(EMPREGADO_MATRICULA, FORN_CNPJ),
CONSTRAINT FK_EMPREGADOS_FORNECEDORES_EMPREGADOS FOREIGN KEY(EMPREGADO_MATRICULA) REFERENCES EMPREGADOS(EMPREGADO_MATRICULA),
CONSTRAINT FK_EMPREGADOS_FORNECEDORES_FORNECEDORES FOREIGN KEY(FORN_CNPJ) REFERENCES FORNECEDORES(FORN_CNPJ)
);

CREATE TABLE IF NOT EXISTS PRODUTOS_COMPONENTES(
PROD_COD INT,
COMP_COD INT,
PRIMARY KEY(PROD_COD, COMP_COD),
CONSTRAINT FK_PRODUTOS_COMPONENTES_PRODUTOS FOREIGN KEY(PROD_COD) REFERENCES PRODUTOS(PROD_COD),
CONSTRAINT FK_PRODUTOS_COMPONENTES_COMPONENTES FOREIGN KEY(COMP_COD) REFERENCES COMPONENTES(COMP_COD)
);

CREATE TABLE IF NOT EXISTS MAQUINAS_COMPONENTES(
MAQ_ID INT,
COMP_COD INT,
PRIMARY KEY(MAQ_ID, COMP_COD),
CONSTRAINT FK_MAQUINAS_COMPONENTES_MAQUINAS FOREIGN KEY(MAQ_ID) REFERENCES MAQUINAS(MAQ_ID),
CONSTRAINT FK_MAQUINAS_COMPONENTES_COMPONENTES FOREIGN KEY(COMP_COD) REFERENCES COMPONENTES(COMP_COD)
);

CREATE TABLE IF NOT EXISTS ENCOMENDAS_PRODUTOS(
ENC_NUM INT,
PROD_COD INT,
PRIMARY KEY(ENC_NUM, PROD_COD),
CONSTRAINT FK_ENCOMENDAS_PRODUTOS_ENCOMENDAS FOREIGN KEY(ENC_NUM) REFERENCES ENCOMENDAS(ENC_NUM),
CONSTRAINT FK_ENCOMENDAS_PRODUTOS_PRODUTOS FOREIGN KEY(PROD_COD) REFERENCES PRODUTOS(PROD_COD)
);

ALTER TABLE CLIENTES ADD CLIENTE_EMAIL VARCHAR(50);
ALTER TABLE CLIENTES DROP PESSOA_CONTATO;
ALTER TABLE CLIENTES MODIFY NOME_CLIENTE VARCHAR(100) NOT NULL;
ALTER TABLE CLIENTES CHANGE RAZAO_SOCIAL_CLIENTE RAZAO_SOCIAL_CLIENTE_NOVA INT NOT NULL;

ALTER TABLE EMPREGADOS ADD EMPREGADO_EMAIL VARCHAR(50);
ALTER TABLE EMPREGADOS DROP EMPREGADO_ENDERECO;
ALTER TABLE EMPREGADOS MODIFY EMPREGADO_NOME VARCHAR(100) NOT NULL;
ALTER TABLE EMPREGADOS CHANGE EMPREGADO_CARGO EMPREGADO_FUNCAO VARCHAR(15) NOT NULL;

ALTER TABLE FORNECEDORES ADD FORN_EMAIL VARCHAR(50);
ALTER TABLE FORNECEDORES DROP FORN_RAZAO_SOCIAL;
ALTER TABLE FORNECEDORES MODIFY FORN_PESSOA_CONTATO VARCHAR(100) NOT NULL;

ALTER TABLE PRODUTOS ADD PROD_DESCRICAO TEXT;
ALTER TABLE PRODUTOS DROP PROD_COR;
ALTER TABLE PRODUTOS MODIFY PROD_NOME VARCHAR(100) NOT NULL;
ALTER TABLE PRODUTOS CHANGE PROD_PRECO PROD_PRECO_NOVO DECIMAL(10, 2) NOT NULL;

ALTER TABLE COMPONENTES ADD COMP_DESCRICAO TEXT;
ALTER TABLE COMPONENTES DROP COMP_UNIDADE;
ALTER TABLE COMPONENTES MODIFY COMP_QUANTIDADE_ESTOQUE INT NOT NULL;
ALTER TABLE COMPONENTES CHANGE COMP_PRECO_UNITARIO COMP_PRECO_UNITARIO_NOVO DECIMAL(10, 2) NOT NULL;

ALTER TABLE RE ADD RE_HORARIO_USO INT;
ALTER TABLE RE DROP RE_UNIDADE;
ALTER TABLE RE MODIFY RE_QUANTIDADE_NECESSARIA INT NOT NULL;
ALTER TABLE RE CHANGE RE_TEMPO_USO RE_TEMPO_USO_NOVO INT;

ALTER TABLE RM ADD RM_RESPONSAVEL VARCHAR(100);
ALTER TABLE RM DROP RM_DESCRICAO;
ALTER TABLE RM MODIFY RM_DATA DATE NOT NULL;
ALTER TABLE RM CHANGE RM_DESCRICAO RM_DESCRICAO_COMPLETA VARCHAR(200) NOT NULL;

ALTER TABLE RS ADD RS_NOTAS TEXT;
ALTER TABLE RS DROP RS_DATA_NECESSIDADE;
ALTER TABLE RS MODIFY RS_QUANTIDADE INT NOT NULL;

DROP TABLE IF EXISTS CLIENTES_ENCOMENDAS;
