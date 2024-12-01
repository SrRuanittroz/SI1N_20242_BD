CREATE DATABASE Projeto_Fortes;
USE Projeto_Fortes;


CREATE TABLE EMPRESA (
    id_empresa INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    cnpj VARCHAR(20) NOT NULL,
    endereco VARCHAR(255),
    telefone VARCHAR(20)
);


CREATE TABLE SISTEMA_DE_GESTAO_INTEGRADO (
    id_sistema INT AUTO_INCREMENT PRIMARY KEY,
    nome_sistema VARCHAR(255) NOT NULL,
    descricao TEXT,
    modulo_gestao VARCHAR(255),
    data_implementacao DATE,
    id_empresa INT NOT NULL,
    FOREIGN KEY (id_empresa) REFERENCES EMPRESA(id_empresa)
);


CREATE TABLE GESTAO_DE_PESSOAS (
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    id_empresa INT NOT NULL,
    nome VARCHAR(255) NOT NULL,
    cargo VARCHAR(255),
    departamento VARCHAR(255),
    salario DECIMAL(10, 2),
    email VARCHAR(255),
    telefone VARCHAR(20),
    data_admissao DATE,
    status ENUM('ativo', 'inativo') NOT NULL,
    FOREIGN KEY (id_empresa) REFERENCES EMPRESA(id_empresa)
);


CREATE TABLE PROJETO_SOCIAL (
    id_projeto INT AUTO_INCREMENT PRIMARY KEY,
    id_empresa INT NOT NULL,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT,
    tematica VARCHAR(255),
    impacto_comunidade TEXT,
    status ENUM('ativo', 'inativo') NOT NULL,
    FOREIGN KEY (id_empresa) REFERENCES EMPRESA(id_empresa)
);


CREATE TABLE MONITORAMENTO_EDITAL (
    id_monitoramento INT AUTO_INCREMENT PRIMARY KEY,
    id_projeto INT NOT NULL,
    data_avaliacao DATE,
    descricao_avaliacao TEXT,
    status ENUM('pendente', 'aprovado', 'rejeitado') NOT NULL,
    FOREIGN KEY (id_projeto) REFERENCES PROJETO_SOCIAL(id_projeto)
);


CREATE TABLE DONATARIO (
    id_donatario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    tipo ENUM('pessoa_fisica', 'pessoa_juridica') NOT NULL,
    cnpj VARCHAR(20),
    endereco VARCHAR(255),
    telefone VARCHAR(20),
    status_legal ENUM('regular', 'irregular') NOT NULL
);


CREATE TABLE DOACAO (
    id_doacao INT AUTO_INCREMENT PRIMARY KEY,
    id_projeto INT NOT NULL,
    id_donatario INT NOT NULL,
    tipo ENUM('financeira', 'material') NOT NULL,
    valor DECIMAL(10, 2),
    data DATE NOT NULL,
    FOREIGN KEY (id_projeto) REFERENCES PROJETO_SOCIAL(id_projeto),
    FOREIGN KEY (id_donatario) REFERENCES DONATARIO(id_donatario)
);


CREATE TABLE FORMULARIO_CADASTRO (
    id_formulario INT AUTO_INCREMENT PRIMARY KEY,
    id_donatario INT NOT NULL,
    documentacao_enviada BOOLEAN NOT NULL,
    data_envio DATE NOT NULL,
    status_aprovacao ENUM('pendente', 'aprovado', 'rejeitado') NOT NULL,
    FOREIGN KEY (id_donatario) REFERENCES DONATARIO(id_donatario)
);


CREATE TABLE ADMINISTRADOR (
    id_colaborador INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    cargo VARCHAR(255),
    cpf VARCHAR(20) NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(255)
);


CREATE TABLE DOACOES_ADMINISTRADAS (
    id_doacao INT NOT NULL,
    id_projeto INT NOT NULL,
    PRIMARY KEY (id_doacao, id_projeto),
    FOREIGN KEY (id_doacao) REFERENCES DOACAO(id_doacao),
    FOREIGN KEY (id_projeto) REFERENCES PROJETO_SOCIAL(id_projeto)
);


CREATE TABLE MONITORIA (
    id_projeto INT NOT NULL,
    id_monitoramento INT NOT NULL,
    PRIMARY KEY (id_projeto, id_monitoramento),
    FOREIGN KEY (id_projeto) REFERENCES PROJETO_SOCIAL(id_projeto),
    FOREIGN KEY (id_monitoramento) REFERENCES MONITORAMENTO_EDITAL(id_monitoramento)
);


CREATE TABLE AVALIA (
    id_colaborador INT NOT NULL,
    id_sistema INT NOT NULL,
    PRIMARY KEY (id_colaborador, id_sistema),
    FOREIGN KEY (id_colaborador) REFERENCES ADMINISTRADOR(id_colaborador),
    FOREIGN KEY (id_sistema) REFERENCES SISTEMA_DE_GESTAO_INTEGRADO(id_sistema)
);


CREATE TABLE PERTENCE (
    id_empresa INT NOT NULL,
    id_sistema INT NOT NULL,
    PRIMARY KEY (id_empresa, id_sistema),
    FOREIGN KEY (id_empresa) REFERENCES EMPRESA(id_empresa),
    FOREIGN KEY (id_sistema) REFERENCES SISTEMA_DE_GESTAO_INTEGRADO(id_sistema)
);


CREATE TABLE GERE (
    id_empresa INT NOT NULL,
    id_funcionario INT NOT NULL,
    PRIMARY KEY (id_empresa, id_funcionario),
    FOREIGN KEY (id_empresa) REFERENCES EMPRESA(id_empresa),
    FOREIGN KEY (id_funcionario) REFERENCES GESTAO_DE_PESSOAS(id_funcionario)
);


CREATE TABLE RECEBE (
    id_projeto INT NOT NULL,
    id_donatario INT NOT NULL,
    PRIMARY KEY (id_projeto, id_donatario),
    FOREIGN KEY (id_projeto) REFERENCES PROJETO_SOCIAL(id_projeto),
    FOREIGN KEY (id_donatario) REFERENCES DONATARIO(id_donatario)
);