CREATE SCHEMA IF NOT EXISTS personal_trainer DEFAULT CHARACTER SET utf8mb4;

USE personal_trainer;

-- Table usuario
CREATE TABLE IF NOT EXISTS usuario (
    idusuario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
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
    idaluno INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fkusuario INT NOT NULL,
    sexo ENUM('M', 'F', 'OUTRO') NULL DEFAULT NULL,
    data_nascimento DATE NULL DEFAULT NULL,
    celular VARCHAR(20) NULL DEFAULT NULL,
    objetivo TEXT NULL DEFAULT NULL,
    criado_em DATETIME NULL DEFAULT CURRENT_TIMESTAMP(),
    CONSTRAINT fk_aluno_usuario FOREIGN KEY (fkusuario) REFERENCES usuario (idusuario) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table agenda
CREATE TABLE IF NOT EXISTS agenda (
    idagenda INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fkaluno INT NOT NULL,
    inicio DATETIME NOT NULL,
    fim DATETIME NOT NULL,
    status ENUM('AGENDADO', 'REALIZADO', 'CANCELADO') NULL DEFAULT 'AGENDADO',
    observacao TEXT NULL DEFAULT NULL,
    criado_em DATETIME NULL DEFAULT CURRENT_TIMESTAMP(),
    CONSTRAINT fk_agenda_aluno FOREIGN KEY (fkaluno) REFERENCES aluno (idaluno) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table avaliacao
CREATE TABLE IF NOT EXISTS avaliacao (
    idavaliacao INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fkaluno INT NOT NULL,
    data DATE NOT NULL,
    peso DECIMAL(5, 2) NOT NULL,
    altura DECIMAL(3, 2) NOT NULL,
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
    CONSTRAINT fk_avaliacao_aluno FOREIGN KEY (fkaluno) REFERENCES aluno (idaluno) ON DELETE CASCADE
);

-- Table depoimento
CREATE TABLE IF NOT EXISTS depoimento (
    iddepoimento INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fkaluno INT NOT NULL,
    texto TEXT NOT NULL,
    url_foto VARCHAR(255) NULL DEFAULT NULL,
    status TINYINT(1) NULL DEFAULT 0,
    data DATETIME NULL DEFAULT CURRENT_TIMESTAMP(),
    CONSTRAINT fk_depoimento_aluno FOREIGN KEY (fkaluno) REFERENCES aluno (idaluno) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table exercicio
CREATE TABLE IF NOT EXISTS exercicio (
    idexercicio INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT NULL DEFAULT NULL,
    grupo_muscular VARCHAR(50) NULL DEFAULT NULL
);

-- Table mensalidade
CREATE TABLE IF NOT EXISTS mensalidade (
    idmensalidade INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fkaluno INT NOT NULL,
    mes_referencia CHAR(7) NOT NULL,
    valor DECIMAL(10, 2) NOT NULL,
    vencimento DATE NOT NULL,
    pagamento DATE NULL DEFAULT NULL,
    status ENUM('PENDENTE', 'PAGO', 'ATRASADO') NULL DEFAULT 'PENDENTE',
    CONSTRAINT fk_mensalidade_aluno FOREIGN KEY (fkaluno) REFERENCES aluno (idaluno) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table personal
CREATE TABLE IF NOT EXISTS personal (
    idpersonal INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fkusuario INT NOT NULL,
    cref VARCHAR(20) NULL DEFAULT NULL,
    especialidade VARCHAR(100) NULL DEFAULT NULL,
    celular VARCHAR(20) NULL DEFAULT NULL,
    criado_em DATETIME NULL DEFAULT CURRENT_TIMESTAMP(),
    CONSTRAINT fk_personal_usuario FOREIGN KEY (fkusuario) REFERENCES usuario (idusuario) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table servico
CREATE TABLE IF NOT EXISTS servico (
    idusuarioservico INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    descricao TEXT NULL DEFAULT NULL,
    publico VARCHAR(100) NULL DEFAULT NULL,
    objetivo TEXT NULL DEFAULT NULL,
    inclui VARCHAR(100) NULL DEFAULT NULL,
    diferencial VARCHAR(100) NULL DEFAULT NULL
);

-- Table plano_treino
CREATE TABLE IF NOT EXISTS plano_treino (
    idplano_treino INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fkaluno INT NOT NULL,
    descricao TEXT NULL DEFAULT NULL,
    inicio DATE NULL DEFAULT NULL,
    final DATE NULL DEFAULT NULL,
    status ENUM('ATIVO', 'FINALIZADO', 'CANCELADO') NULL DEFAULT 'ATIVO',
    CONSTRAINT fk_plano_treino_aluno FOREIGN KEY (fkaluno) REFERENCES aluno (idaluno) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table treino_sessao
CREATE TABLE IF NOT EXISTS sessao_treino (
    idsessao_treino INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fkplano_treino INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    ordem INT NOT NULL,
    observacoes TEXT NULL DEFAULT NULL,
    CONSTRAINT fk_treino_sessao_plano FOREIGN KEY (fkplano_treino) REFERENCES plano_treino (idplano_treino) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table sessao_exercicio
CREATE TABLE IF NOT EXISTS sessao_exercicio (
    idsessao_exercicio INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fksessao_treino INT NOT NULL,
    fkexercicio INT NOT NULL,
    series INT NOT NULL,
    repeticoes INT NOT NULL,
    carga DECIMAL(6, 2) NULL DEFAULT NULL,
    tempo_descanso INT NULL DEFAULT NULL,
    orientacoes TEXT NULL DEFAULT NULL,
    ordem INT NULL DEFAULT NULL,
    CONSTRAINT fk_sessao_exercicio_exercicio FOREIGN KEY (fkexercicio) REFERENCES exercicio (idexercicio) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_sessao_exercicio_sessao_treino FOREIGN KEY (fksessao_treino) REFERENCES sessao_treino (idsessao_treino) ON DELETE CASCADE ON UPDATE CASCADE
);