CREATE SCHEMA IF NOT EXISTS personal_trainer DEFAULT CHARACTER SET utf8mb4;

USE personal_trainer;

-- Table usuario
CREATE TABLE IF NOT EXISTS usuario (
    pk_usuario INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    senha VARCHAR(255) NOT NULL,
    tipo_usuario ENUM('ALUNO', 'PERSONAL', 'ADMIN') NOT NULL,
    ativo TINYINT(1) NULL DEFAULT 1,
    criado_em DATETIME NULL DEFAULT CURRENT_TIMESTAMP(),
    UNIQUE INDEX email (email ASC)
);

-- Table aluno
CREATE TABLE IF NOT EXISTS aluno (
    pk_aluno INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fk_usuario INT(11) NOT NULL,
    sexo ENUM('M', 'F', 'OUTRO') NULL DEFAULT NULL,
    data_nascimento DATE NULL DEFAULT NULL,
    celular VARCHAR(20) NULL DEFAULT NULL,
    objetivo TEXT NULL DEFAULT NULL,
    criado_em DATETIME NULL DEFAULT CURRENT_TIMESTAMP(),
    CONSTRAINT fk_aluno_usuario FOREIGN KEY (fk_usuario) REFERENCES usuario (pk_usuario) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table agenda
CREATE TABLE IF NOT EXISTS agenda (
    pk_agenda INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fk_aluno INT(11) NOT NULL,
    data_inicio DATETIME NOT NULL,
    data_fim DATETIME NOT NULL,
    status ENUM('AGENDADO', 'REALIZADO', 'CANCELADO') NULL DEFAULT 'AGENDADO',
    observacao TEXT NULL DEFAULT NULL,
    criado_em DATETIME NULL DEFAULT CURRENT_TIMESTAMP(),
    CONSTRAINT fk_agenda_aluno FOREIGN KEY (fk_aluno) REFERENCES aluno (pk_aluno) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table avaliacao
CREATE TABLE IF NOT EXISTS avaliacao (
    id_avaliacao INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fk_aluno INT(11) NOT NULL,
    data_avaliacao DATE NOT NULL,
    peso DECIMAL(5, 2) NOT NULL,
    altura DECIMAL(3, 2) NOT NULL,
    imc DECIMAL(5, 2) NULL DEFAULT NULL,
    percentual_gordura DECIMAL(5, 2) NULL DEFAULT NULL,
    massa_magra DECIMAL(5, 2) NULL DEFAULT NULL,
    circ_peitoral DECIMAL(5, 2) NULL DEFAULT NULL,
    circ_cintura DECIMAL(5, 2) NULL DEFAULT NULL,
    circ_abdominal DECIMAL(5, 2) NULL DEFAULT NULL,
    circ_quadril DECIMAL(5, 2) NULL DEFAULT NULL,
    circ_braco_direito DECIMAL(5, 2) NULL DEFAULT NULL,
    circ_braco_esquerdo DECIMAL(5, 2) NULL DEFAULT NULL,
    circ_coxa_direita DECIMAL(5, 2) NULL DEFAULT NULL,
    circ_coxa_esquerda DECIMAL(5, 2) NULL DEFAULT NULL,
    observacoes TEXT NULL DEFAULT NULL,
    CONSTRAINT fk_avaliacao_aluno FOREIGN KEY (fk_aluno) REFERENCES aluno (pk_aluno) ON DELETE CASCADE
);

-- Table depoimento
CREATE TABLE IF NOT EXISTS depoimento (
    id_depoimento INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fk_aluno INT(11) NOT NULL,
    texto_depoimento TEXT NOT NULL,
    url_foto VARCHAR(255) NULL DEFAULT NULL,
    status_exibicao TINYINT(1) NULL DEFAULT 0,
    data_postagem DATETIME NULL DEFAULT CURRENT_TIMESTAMP(),
    CONSTRAINT fk_depoimento_aluno FOREIGN KEY (fk_aluno) REFERENCES aluno (pk_aluno) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table exercicio
CREATE TABLE IF NOT EXISTS exercicio (
    pk_exercicio INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT NULL DEFAULT NULL,
    grupo_muscular VARCHAR(50) NULL DEFAULT NULL,
    criado_em DATETIME NULL DEFAULT CURRENT_TIMESTAMP()
);

-- Table mensalidade
CREATE TABLE IF NOT EXISTS mensalidade (
    pk_mensalidade INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fk_aluno INT(11) NOT NULL,
    mes_referencia CHAR(7) NOT NULL,
    valor DECIMAL(10, 2) NOT NULL,
    data_vencimento DATE NOT NULL,
    data_pagamento DATE NULL DEFAULT NULL,
    status ENUM('PENDENTE', 'PAGO', 'ATRASADO') NULL DEFAULT 'PENDENTE',
    CONSTRAINT fk_mensalidade_aluno FOREIGN KEY (fk_aluno) REFERENCES aluno (pk_aluno) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table personal
CREATE TABLE IF NOT EXISTS personal (
    pk_personal INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fk_usuario INT(11) NOT NULL,
    cref VARCHAR(20) NULL DEFAULT NULL,
    especialidade VARCHAR(100) NULL DEFAULT NULL,
    celular VARCHAR(20) NULL DEFAULT NULL,
    criado_em DATETIME NULL DEFAULT CURRENT_TIMESTAMP(),
    CONSTRAINT fk_personal_usuario FOREIGN KEY (fk_usuario) REFERENCES usuario (pk_usuario) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table servico
CREATE TABLE IF NOT EXISTS servico (
    pk_servico INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    descricao TEXT NULL DEFAULT NULL,
    publico VARCHAR(100) NULL DEFAULT NULL,
    objetivo TEXT NULL DEFAULT NULL,
    inclui VARCHAR(100) NULL DEFAULT NULL,
    diferencial VARCHAR(100) NULL DEFAULT NULL
);

-- Table plano_treino
CREATE TABLE IF NOT EXISTS plano_treino (
    pk_plano_treino INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fk_aluno INT(11) NOT NULL,
    descricao TEXT NULL DEFAULT NULL,
    data_inicio DATE NULL DEFAULT NULL,
    data_final DATE NULL DEFAULT NULL,
    status ENUM('ATIVO', 'FINALIZADO', 'CANCELADO') NULL DEFAULT 'ATIVO',
    criado_em DATETIME NULL DEFAULT CURRENT_TIMESTAMP(),
    CONSTRAINT fk_plano_treino_aluno FOREIGN KEY (fk_aluno) REFERENCES aluno (pk_aluno) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table treino_sessao
CREATE TABLE IF NOT EXISTS treino_sessao (
    pk_treino_sessao INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fk_plano_treino INT(11) NOT NULL,
    nome_sessao VARCHAR(100) NOT NULL,
    ordem INT(11) NOT NULL,
    observacoes TEXT NULL DEFAULT NULL,
    CONSTRAINT fk_treino_sessao_plano FOREIGN KEY (fk_plano_treino) REFERENCES treino (pk_plano_treino) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table sessao_exercicio
CREATE TABLE IF NOT EXISTS sessao_exercicio (
    pk_sessao_exercicio INT(11) NOT NULL AUTO_INCREMENT,
    fk_treino_sessao INT(11) NOT NULL,
    fk_exercicio INT(11) NOT NULL,
    series INT(11) NOT NULL,
    repeticoes INT(11) NOT NULL,
    carga DECIMAL(6, 2) NULL DEFAULT NULL,
    tempo_descanso INT(11) NULL DEFAULT NULL,
    orientacoes TEXT NULL DEFAULT NULL,
    ordem INT(11) NULL DEFAULT NULL,
    PRIMARY KEY (pk_sessao_exercicio),
    CONSTRAINT fk_sessao_exercicio_exercicio FOREIGN KEY (fk_exercicio) REFERENCES exercicio (pk_exercicio) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_treino_sessao FOREIGN KEY (fk_treino_sessao) REFERENCES sessao_treino (pk_sessao_treino) ON DELETE CASCADE ON UPDATE CASCADE
);