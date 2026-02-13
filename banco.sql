-- 1. CRIAÇÃO DO BANCO E DEFINIÇÕES INICIAIS
CREATE DATABASE IF NOT EXISTS personal_trainer;
USE personal_trainer;

-- 2. TABELA: usuario (Base para Alunos e Personais)
DROP TABLE IF EXISTS usuario;
CREATE TABLE usuario (
  pk_usuario int(11) NOT NULL AUTO_INCREMENT,
  nome varchar(100) NOT NULL,
  email varchar(100) NOT NULL,
  senha varchar(255) NOT NULL,
  tipo_usuario enum('ALUNO','PERSONAL','ADMIN') NOT NULL,
  ativo tinyint(1) DEFAULT 1,
  criado_em datetime DEFAULT current_timestamp(),
  PRIMARY KEY (pk_usuario),
  UNIQUE KEY email (email),
  KEY idx_usuario_tipo (tipo_usuario)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 3. TABELA: personal
DROP TABLE IF EXISTS personal;
CREATE TABLE personal (
  pk_personal int(11) NOT NULL AUTO_INCREMENT,
  fk_usuario int(11) DEFAULT NULL,
  cref varchar(20) DEFAULT NULL,
  especialidade varchar(100) DEFAULT NULL,
  telefone varchar(20) DEFAULT NULL,
  criado_em datetime DEFAULT current_timestamp(),
  PRIMARY KEY (pk_personal),
  UNIQUE KEY fk_usuario (fk_usuario),
  CONSTRAINT fk_personal_usuario FOREIGN KEY (fk_usuario) REFERENCES usuario (pk_usuario) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 4. TABELA: aluno
DROP TABLE IF EXISTS aluno;
CREATE TABLE aluno (
  pk_aluno int(11) NOT NULL AUTO_INCREMENT,
  fk_usuario int(11) DEFAULT NULL,
  sexo enum('M','F') DEFAULT NULL,
  data_nascimento date DEFAULT NULL,
  telefone varchar(20) DEFAULT NULL,
  objetivo text DEFAULT NULL,
  criado_em datetime DEFAULT current_timestamp(),
  PRIMARY KEY (pk_aluno),
  UNIQUE KEY fk_usuario (fk_usuario),
  CONSTRAINT fk_aluno_usuario FOREIGN KEY (fk_usuario) REFERENCES usuario (pk_usuario) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 5. TABELA: agenda
DROP TABLE IF EXISTS agenda;
CREATE TABLE agenda (
  pk_agenda int(11) NOT NULL AUTO_INCREMENT,
  fk_aluno int(11) NOT NULL,
  fk_personal int(11) NOT NULL,
  inicio_agendamento datetime NOT NULL,
  fim_agendamento datetime NOT NULL,
  status enum('AGENDADO','REALIZADO','CANCELADO') DEFAULT 'AGENDADO',
  observacao text DEFAULT NULL,
  PRIMARY KEY (pk_agenda),
  KEY fk_agenda_aluno (fk_aluno),
  KEY fk_agenda_personal (fk_personal),
  CONSTRAINT fk_agenda_aluno FOREIGN KEY (fk_aluno) REFERENCES aluno (pk_aluno) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_agenda_personal FOREIGN KEY (fk_personal) REFERENCES personal (pk_personal) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 6. TABELA: avaliacao (Com campo IMC para automação)
DROP TABLE IF EXISTS avaliacao;
CREATE TABLE avaliacao (
  id_avaliacao int(11) NOT NULL AUTO_INCREMENT,
  fk_aluno int(11) NOT NULL,
  fk_personal int(11) DEFAULT NULL,
  data_avaliacao date NOT NULL,
  peso decimal(5,2) NOT NULL,
  altura decimal(3,2) NOT NULL,
  imc decimal(5,2) DEFAULT NULL,
  percentual_gordura decimal(5,2) DEFAULT NULL,
  massa_magra decimal(5,2) DEFAULT NULL,
  circ_peitoral decimal(5,2) DEFAULT NULL,
  circ_cintura decimal(5,2) DEFAULT NULL,
  circ_abdominal decimal(5,2) DEFAULT NULL,
  circ_quadril decimal(5,2) DEFAULT NULL,
  circ_braco_direito decimal(5,2) DEFAULT NULL,
  circ_braco_esquerdo decimal(5,2) DEFAULT NULL,
  circ_coxa_direita decimal(5,2) DEFAULT NULL,
  circ_coxa_esquerda decimal(5,2) DEFAULT NULL,
  observacoes text DEFAULT NULL,
  PRIMARY KEY (id_avaliacao),
  CONSTRAINT fk_avaliacao_aluno FOREIGN KEY (fk_aluno) REFERENCES aluno (pk_aluno) ON DELETE CASCADE,
  CONSTRAINT fk_avaliacao_personal FOREIGN KEY (fk_personal) REFERENCES personal (pk_personal) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 7. TABELA: exercicio
DROP TABLE IF EXISTS exercicio;
CREATE TABLE exercicio (
  pk_exercicio int(11) NOT NULL AUTO_INCREMENT,
  nome varchar(100) NOT NULL,
  descricao text DEFAULT NULL,
  grupo_muscular varchar(50) DEFAULT NULL,
  criado_em datetime DEFAULT current_timestamp(),
  PRIMARY KEY (pk_exercicio)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 8. TABELA: treino e treino_exercicio (Relacionamento N:N)
DROP TABLE IF EXISTS treino;
CREATE TABLE treino (
  pk_treino int(11) NOT NULL AUTO_INCREMENT,
  fk_aluno int(11) NOT NULL,
  fk_personal int(11) NOT NULL,
  descricao text NOT NULL,
  data_inicio date NOT NULL,
  data_fim date DEFAULT NULL,
  PRIMARY KEY (pk_treino),
  CONSTRAINT fk_treino_aluno FOREIGN KEY (fk_aluno) REFERENCES aluno (pk_aluno) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_treino_personal FOREIGN KEY (fk_personal) REFERENCES personal (pk_personal) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS treino_exercicio;
CREATE TABLE treino_exercicio (
  pk_treino_exercicio int(11) NOT NULL AUTO_INCREMENT,
  fk_treino int(11) NOT NULL,
  fk_exercicio int(11) NOT NULL,
  series int(11) NOT NULL,
  repeticoes int(11) NOT NULL,
  carga decimal(6,2) DEFAULT NULL,
  descanso_segundos int(11) DEFAULT NULL,
  PRIMARY KEY (pk_treino_exercicio),
  CONSTRAINT fk_te_exercicio FOREIGN KEY (fk_exercicio) REFERENCES exercicio (pk_exercicio) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_te_treino FOREIGN KEY (fk_treino) REFERENCES treino (pk_treino) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 9. TABELA: mensalidade (Financeiro)
DROP TABLE IF EXISTS mensalidade;
CREATE TABLE mensalidade (
  pk_mensalidade int(11) NOT NULL AUTO_INCREMENT,
  fk_aluno int(11) NOT NULL,
  mes_referencia char(7) NOT NULL,
  valor decimal(10,2) NOT NULL,
  data_vencimento date NOT NULL,
  data_pagamento date DEFAULT NULL,
  status enum('PENDENTE','PAGO','ATRASADO') DEFAULT 'PENDENTE',
  PRIMARY KEY (pk_mensalidade),
  CONSTRAINT fk_mensalidade_aluno FOREIGN KEY (fk_aluno) REFERENCES aluno (pk_aluno) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 10. TABELA: depoimentos (Site/Social)
DROP TABLE IF EXISTS depoimentos;
CREATE TABLE depoimentos (
  id_depoimento int(11) NOT NULL AUTO_INCREMENT,
  fk_aluno int(11) NOT NULL,
  texto_depoimento text NOT NULL,
  url_foto varchar(255) DEFAULT NULL,
  status_exibicao tinyint(1) DEFAULT 0,
  data_postagem datetime DEFAULT current_timestamp(),
  PRIMARY KEY (id_depoimento),
  CONSTRAINT fk_depoimento_aluno FOREIGN KEY (fk_aluno) REFERENCES aluno (pk_aluno) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 11. AUTOMATIZAÇÃO: Trigger para IMC
DELIMITER //
CREATE TRIGGER tr_calcula_imc_insert
BEFORE INSERT ON avaliacao
FOR EACH ROW
BEGIN
    IF NEW.peso > 0 AND NEW.altura > 0 THEN
        SET NEW.imc = NEW.peso / (NEW.altura * NEW.altura);
    END IF;
END;
//
DELIMITER ;

SET FOREIGN_KEY_CHECKS = 1;