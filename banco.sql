
-- CRIAÇÃO DO BANCO
CREATE DATABASE IF NOT EXISTS personal_trainer;
USE personal_trainer;

SET FOREIGN_KEY_CHECKS = 0;

-- TABELA USUARIO
DROP TABLE IF EXISTS usuario;
CREATE TABLE usuario (
    pk_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    tipo_usuario ENUM('ALUNO','PERSONAL','ADMIN') NOT NULL,
    ativo TINYINT(1) DEFAULT 1,
    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- TABELA PERSONAL
DROP TABLE IF EXISTS personal;
CREATE TABLE personal (
    pk_personal INT AUTO_INCREMENT PRIMARY KEY,
    fk_personal_usuario INT NOT NULL,
    cref VARCHAR(20),
    especialidade VARCHAR(100),
    celular VARCHAR(20),
    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_personal_usuario
        FOREIGN KEY (fk_personal_usuario)
        REFERENCES usuario(pk_usuario)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- TABELA ALUNO
DROP TABLE IF EXISTS aluno;
CREATE TABLE aluno (
    pk_aluno INT AUTO_INCREMENT PRIMARY KEY,
    fk_aluno_usuario INT NOT NULL,
    sexo ENUM('M','F','OUTRO'),
    data_nascimento DATE,
    celular VARCHAR(20),
    objetivo TEXT,
    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_aluno_usuario
        FOREIGN KEY (fk_aluno_usuario)
        REFERENCES usuario(pk_usuario)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- TABELA EXERCICIO
DROP TABLE IF EXISTS exercicio;
CREATE TABLE exercicio (
    pk_exercicio INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    grupo_muscular VARCHAR(50),
    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- TABELA TREINO (Treino do dia)
DROP TABLE IF EXISTS treino;
CREATE TABLE treino (
    pk_treino INT AUTO_INCREMENT PRIMARY KEY,
    fk_treino_aluno INT NOT NULL,
    fk_treino_personal INT NOT NULL,
    descricao TEXT,
    data_inicio DATE,
    data_final DATE,
    status ENUM('ATIVO','FINALIZADO','CANCELADO') DEFAULT 'ATIVO',
    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_treino_aluno
        FOREIGN KEY (fk_treino_aluno)
        REFERENCES aluno(pk_aluno)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_treino_personal
        FOREIGN KEY (fk_treino_personal)
        REFERENCES personal(pk_personal)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- TABELA SESSAO_TREINO (Divisão do treino)
DROP TABLE IF EXISTS sessao_treino;
CREATE TABLE sessao_treino (
    pk_sessao_treino INT AUTO_INCREMENT PRIMARY KEY,
    fk_sessao_treino_treino INT NOT NULL,
    nome_sessao VARCHAR(100) NOT NULL, -- Ex: Costas, Peito, Pernas
    ordem INT NOT NULL,
    observacoes TEXT,
    CONSTRAINT fk_sessao_treino_treino
        FOREIGN KEY (fk_sessao_treino_treino)
        REFERENCES treino(pk_treino)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- TABELA TREINO_EXERCICIO (Exercícios do sessao)
DROP TABLE IF EXISTS treino_exercicio;
CREATE TABLE treino_exercicio (
    pk_treino_exercicio INT AUTO_INCREMENT PRIMARY KEY,
    fk_treino_exercicio_sessao INT NOT NULL,
    fk_treino_exercicio_exercicio INT NOT NULL,
    series INT NOT NULL,
    repeticoes INT NOT NULL,
    carga DECIMAL(6,2),
    tempo_descanso INT,
    orientacoes TEXT,
    ordem INT,
    CONSTRAINT fk_treino_exercicio_sessao
        FOREIGN KEY (fk_treino_exercicio_sessao)
        REFERENCES sessao_treino(pk_sessao_treino)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_treino_exercicio_exercicio
        FOREIGN KEY (fk_treino_exercicio_exercicio)
        REFERENCES exercicio(pk_exercicio)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- TABELA AGENDA
DROP TABLE IF EXISTS agenda;
CREATE TABLE agenda (
    pk_agenda INT AUTO_INCREMENT PRIMARY KEY,
    fk_agenda_aluno INT NOT NULL,
    fk_agenda_personal INT NOT NULL,
    data_inicio DATETIME NOT NULL,
    data_fim DATETIME NOT NULL,
    status ENUM('AGENDADO','REALIZADO','CANCELADO') DEFAULT 'AGENDADO',
    observacao TEXT,
    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_agenda_aluno
        FOREIGN KEY (fk_agenda_aluno)
        REFERENCES aluno(pk_aluno)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_agenda_personal
        FOREIGN KEY (fk_agenda_personal)
        REFERENCES personal(pk_personal)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- TABELA AVALIACAO
DROP TABLE IF EXISTS avaliacao;
CREATE TABLE avaliacao (
    id_avaliacao INT AUTO_INCREMENT PRIMARY KEY,
    fk_avaliacao_aluno INT NOT NULL,
    fk_avaliacao_personal INT DEFAULT NULL,
    data_avaliacao DATE NOT NULL,
    peso DECIMAL(5,2) NOT NULL,
    altura DECIMAL(3,2) NOT NULL,
    imc DECIMAL(5,2),
    percentual_gordura DECIMAL(5,2),
    massa_magra DECIMAL(5,2),
    circ_peitoral DECIMAL(5,2),
    circ_cintura DECIMAL(5,2),
    circ_abdominal DECIMAL(5,2),
    circ_quadril DECIMAL(5,2),
    circ_braco_direito DECIMAL(5,2),
    circ_braco_esquerdo DECIMAL(5,2),
    circ_coxa_direita DECIMAL(5,2),
    circ_coxa_esquerda DECIMAL(5,2),
    observacoes TEXT,
    CONSTRAINT fk_avaliacao_aluno
        FOREIGN KEY (fk_avaliacao_aluno)
        REFERENCES aluno(pk_aluno)
        ON DELETE CASCADE,
    CONSTRAINT fk_avaliacao_personal
        FOREIGN KEY (fk_avaliacao_personal)
        REFERENCES personal(pk_personal)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

-- TABELA MENSALIDADE
DROP TABLE IF EXISTS mensalidade;
CREATE TABLE mensalidade (
    pk_mensalidade INT AUTO_INCREMENT PRIMARY KEY,
    fk_mensalidade_aluno INT NOT NULL,
    mes_referencia CHAR(7) NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    data_vencimento DATE NOT NULL,
    data_pagamento DATE,
    status ENUM('PENDENTE','PAGO','ATRASADO') DEFAULT 'PENDENTE',
    CONSTRAINT fk_mensalidade_aluno
        FOREIGN KEY (fk_mensalidade_aluno)
        REFERENCES aluno(pk_aluno)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- TABELA DEPOIMENTO
DROP TABLE IF EXISTS depoimento;
CREATE TABLE depoimento (
    id_depoimento INT AUTO_INCREMENT PRIMARY KEY,
    fk_depoimento_aluno INT NOT NULL,
    texto_depoimento TEXT NOT NULL,
    url_foto VARCHAR(255),
    status_exibicao TINYINT(1) DEFAULT 0,
    data_postagem DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_depoimento_aluno
        FOREIGN KEY (fk_depoimento_aluno)
        REFERENCES aluno(pk_aluno)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- TABELA SERVICO
DROP TABLE IF EXISTS servico;
CREATE TABLE servico (
    pk_servico INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    descricao TEXT,
    publico VARCHAR(100),
    objetivo TEXT,
    inclui VARCHAR(100),
    diferencial VARCHAR(100)
);

