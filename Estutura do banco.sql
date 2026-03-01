/* ============================================================
   CRIAÇÃO DO BANCO DE DADOS (DATABASE/SCHEMA)
   ============================================================ */

-- Cria o banco de dados se ele ainda não existir, definindo o padrão de letras (acentuação)
CREATE SCHEMA personal_trainer DEFAULT CHARACTER SET utf8mb4;

-- Indica ao sistema que vamos usar este banco de dados para as próximas tabelas
USE personal_trainer;

/* ============================================================
   TABELA: USUÁRIO (O coração do sistema, onde todos se cadastram)
   ============================================================ */

CREATE TABLE usuario (
    idusuario INT NOT NULL AUTO_INCREMENT PRIMARY KEY, -- Número único do usuário, cresce sozinho (1, 2, 3...)
    username VARCHAR(40) NOT NULL,                        -- Nome de usuário, aceita até 40 letras, obrigatório, usado para logar no sistema.
    email VARCHAR(100) NOT NULL,                       -- Endereço de e-mail, obrigatório
    senha VARCHAR(255) NOT NULL,                       -- Senha criptografada, obrigatória
    tipo_usuario ENUM('ALUNO', 'PERSONAL', 'ADMIN') NOT NULL, -- Só permite escolher uma das 3 opções de papel
    ativo TINYINT(1) NULL DEFAULT 1,                   -- Indica se o usuário está ligado (1) ou desligado (0)
    UNIQUE INDEX email (email ASC)                     -- Garante que não existam dois usuários com o mesmo e-mail
);

/* ============================================================
   TABELA: ALUNO (Informações específicas de quem vai treinar)
   ============================================================ */

CREATE TABLE aluno (
    idaluno INT NOT NULL AUTO_INCREMENT PRIMARY KEY,   -- Identificador único para cada aluno
    fkusuario INT NOT NULL,                            -- Conexão com a tabela de usuário (Chave Estrangeira)
    nome VARCHAR(100) NOT NULL,                        -- Nome completo, aceita até 100 letras, obrigatório
    sexo ENUM('M', 'F', 'OUTRO') NULL ,                -- Opção de sexo (Masculino, Feminino ou Outro)
    nascimento DATE NULL ,                        -- Data de nascimento (Ano-Mês-Dia)
    celular VARCHAR(20) NULL ,                         -- Número de telefone para contato
    logradouro VARCHAR(100) NULL ,                     -- Nome da rua/avenida onde mora
    bairro VARCHAR(100) NULL ,                        -- Bairro do aluno
    cidade VARCHAR(100) NULL ,                         -- Cidade do aluno
    estado VARCHAR(2) NULL ,                           -- Sigla do estado (Ex: SP, RJ, RO)
    cep VARCHAR(9) NULL ,                              -- Código postal (CEP)
    objetivo TEXT NULL ,                               -- Texto livre descrevendo o que o aluno quer (ex: emagrecer)
    -- Vincula o aluno ao usuário: Se apagar o usuário, apaga o aluno automaticamente (CASCADE)
    CONSTRAINT fk_aluno_usuario FOREIGN KEY (fkusuario) REFERENCES usuario (idusuario) ON DELETE CASCADE ON UPDATE CASCADE
);

/* ============================================================
   TABELA: AGENDA (Controle de horários de treino)
   ============================================================ */

CREATE TABLE agenda (
    idagenda INT NOT NULL AUTO_INCREMENT PRIMARY KEY,  -- Identificador único do agendamento
    fkaluno INT NOT NULL,                              -- Indica qual aluno marcou o horário
    inicio DATETIME NOT NULL,                          -- Data e hora que o treino começa
    fim DATETIME NOT NULL,                             -- Data e hora que o treino termina
    status ENUM('AGENDADO', 'REALIZADO', 'CANCELADO') NULL DEFAULT 'AGENDADO', -- Situação do treino
    observacao TEXT NULL ,                             -- Espaço para anotações extras sobre o treino
    CONSTRAINT fk_agenda_aluno FOREIGN KEY (fkaluno) REFERENCES aluno (idaluno) ON DELETE CASCADE ON UPDATE CASCADE
);

/* ============================================================
   TABELA: AVALIAÇÃO (Medidas corporais e progresso do aluno)
   ============================================================ */

CREATE TABLE avaliacao (
    idavaliacao INT NOT NULL AUTO_INCREMENT PRIMARY KEY, -- Identificador da avaliação física
    fkaluno INT NOT NULL,                                -- Indica de qual aluno é esta avaliação
    data DATE NOT NULL,                                  -- Data em que as medidas foram tiradas
    peso DECIMAL(5, 2) NOT NULL,                         -- Peso do aluno (Ex: 000,00)
    altura DECIMAL(3, 2) NOT NULL,                       -- Altura do aluno (Ex: 0,00)
    percentual_gordura DECIMAL(5, 2) NULL ,              -- Porcentagem de gordura no corpo
    massa_magra DECIMAL(5, 2) NULL ,                     -- Peso dos músculos em quilos
    circ_peitoral DECIMAL(5, 2) NULL ,                   -- Medida do tórax/peito
    circ_cintura DECIMAL(5, 2) NULL ,                    -- Medida da cintura
    circ_abdominal DECIMAL(5, 2) NULL ,                  -- Medida da barriga
    circ_quadril DECIMAL(5, 2) NULL ,                    -- Medida do quadril
    circ_braco_direito DECIMAL(5, 2) NULL ,              -- Medida do braço direito
    circ_braco_esquerdo DECIMAL(5, 2) NULL ,             -- Medida do braço esquerdo
    circ_coxa_direita DECIMAL(5, 2) NULL ,               -- Medida da coxa direita
    circ_coxa_esquerda DECIMAL(5, 2) NULL ,              -- Medida da coxa esquerda
    observacoes TEXT NULL ,                              -- Notas do professor sobre a avaliação
    -- Conecta a avaliação ao aluno correspondente
    CONSTRAINT fk_avaliacao_aluno FOREIGN KEY (fkaluno) REFERENCES aluno (idaluno) ON DELETE CASCADE
);

/* ============================================================
   TABELA: EXERCÍCIO (Biblioteca de exercícios disponíveis)
   ============================================================ */

CREATE TABLE exercicio (
    idexercicio INT NOT NULL AUTO_INCREMENT PRIMARY KEY, -- Identificador do exercício
    nome VARCHAR(100) NOT NULL,                         -- Nome do exercício (Ex: Supino Reto)
    descricao TEXT NULL ,                                -- Explicação de como fazer o exercício
    grupo_muscular VARCHAR(50) NULL                      -- Qual parte do corpo ele treina (Ex: Peito)
);

/* ============================================================
   TABELA: MENSALIDADE (Controle financeiro)
   ============================================================ */

CREATE TABLE mensalidade (
    idmensalidade INT NOT NULL AUTO_INCREMENT PRIMARY KEY, -- Identificador do pagamento
    fkaluno INT NOT NULL,                                  -- Qual aluno deve pagar
    mes_referencia CHAR(7) NOT NULL,                       -- Mês e ano da cobrança (Ex: 2024-05)
    valor DECIMAL(10, 2) NOT NULL,                         -- Quanto o aluno deve pagar
    vencimento DATE NOT NULL,                              -- Último dia para pagar sem atraso
    pagamento DATE NULL ,                                  -- Dia em que o aluno realmente pagou
    status ENUM('PENDENTE', 'PAGO', 'ATRASADO') NULL DEFAULT 'PENDENTE', -- Situação do pagamento
    -- Liga a mensalidade ao aluno
    CONSTRAINT fk_mensalidade_aluno FOREIGN KEY (fkaluno) REFERENCES aluno (idaluno) ON DELETE CASCADE ON UPDATE CASCADE
);

/* ============================================================
   TABELA: PERSONAL (Informações do treinador)
   ============================================================ */

CREATE TABLE personal (
    idpersonal INT NOT NULL AUTO_INCREMENT PRIMARY KEY,    -- Identificador único do professor
    fkusuario INT NOT NULL,                                -- Conexão com a conta de usuário dele
    nome VARCHAR(100) NOT NULL,                        -- Nome completo, aceita até 100 letras, obrigatório
    cref VARCHAR(20) NULL ,                                -- Registro profissional de educação física
    especialidade VARCHAR(100) NULL ,                      -- O que ele ensina melhor (Ex: Musculação, Yoga)
    celular VARCHAR(20) NULL ,                             -- Telefone do professor
    -- Liga o cadastro de professor à conta de usuário
    CONSTRAINT fk_personal_usuario FOREIGN KEY (fkusuario) REFERENCES usuario (idusuario) ON DELETE CASCADE ON UPDATE CASCADE
);

/* ============================================================
   TABELA: SERVIÇO (O que o Personal oferece para venda)
   ============================================================ */

CREATE TABLE servico (
    idusuarioservico INT NOT NULL AUTO_INCREMENT PRIMARY KEY, -- ID do serviço oferecido
    titulo VARCHAR(100) NOT NULL,                            -- Nome do plano (Ex: Treino em Casa)
    descricao TEXT NULL ,                                     -- Detalhes sobre o serviço
    publico VARCHAR(100) NULL ,                              -- Para quem serve (Ex: Idosos, Atletas)
    objetivo TEXT NULL ,                                      -- O que o serviço promete alcançar
    inclui VARCHAR(100) NULL ,                               -- Itens inclusos (Ex: Dieta, Acompanhamento)
    diferencial VARCHAR(100) NULL                             -- Por que este serviço é especial
);

/* ============================================================
   TABELA: PLANO DE TREINO (A "Ficha" de treinos do aluno)
   ============================================================ */

CREATE TABLE plano_treino (
    idplano_treino INT NOT NULL AUTO_INCREMENT PRIMARY KEY, -- ID da ficha de treinos
    fkaluno INT NOT NULL,                                   -- De qual aluno é este plano
    descricao TEXT NULL ,                                   -- Nome da fase de treino (Ex: Adaptação)
    inicio DATE NULL ,                                      -- Quando o aluno deve começar esta ficha
    final DATE NULL ,                                       -- Quando o aluno deve trocar de ficha
    status ENUM('ATIVO', 'FINALIZADO', 'CANCELADO') NULL DEFAULT 'ATIVO', -- Situação atual da ficha
    -- Liga a ficha de treino ao aluno
    CONSTRAINT fk_plano_treino_aluno FOREIGN KEY (fkaluno) REFERENCES aluno (idaluno) ON DELETE CASCADE ON UPDATE CASCADE
);

/* ============================================================
   TABELA: SESSÃO DE TREINO (Ex: Treino A, Treino B, Treino C)
   ============================================================ */

CREATE TABLE sessao_treino (
    idsessao_treino INT NOT NULL AUTO_INCREMENT PRIMARY KEY, -- ID da parte do treino
    fkplano_treino INT NOT NULL,                             -- De qual ficha este treino faz parte
    nome VARCHAR(100) NOT NULL,                              -- Nome da sessão (Ex: Treino A - Superiores)
    ordem INT NOT NULL,                                      -- Ordem em que deve ser feito (1º, 2º...)
    observacoes TEXT NULL ,                                  -- Notas gerais sobre este dia de treino
    -- Conecta a sessão à ficha principal
    CONSTRAINT fk_treino_sessao_plano FOREIGN KEY (fkplano_treino) REFERENCES plano_treino (idplano_treino) ON DELETE CASCADE ON UPDATE CASCADE
);

/* ============================================================
   TABELA: SESSÃO EXERCÍCIO (Quais exercícios estão em cada treino)
   ============================================================ */

CREATE TABLE sessao_exercicio (
    idsessao_exercicio INT NOT NULL AUTO_INCREMENT PRIMARY KEY, -- ID desta linha da ficha
    fksessao_treino INT NOT NULL,                               -- Indica em qual treino (A, B ou C) ele está
    fkexercicio INT NOT NULL,                                   -- Qual o exercício que será feito
    series INT NOT NULL,                                        -- Quantas vezes repetir o bloco (Ex: 3)
    repeticoes INT NOT NULL,                                    -- Quantas vezes fazer o movimento (Ex: 12)
    carga DECIMAL(6, 2) NULL ,                                  -- Quanto peso usar (em quilos)
    tempo_descanso INT NULL ,                                   -- Segundos para descansar entre séries
    orientacoes TEXT NULL ,                                     -- Dica do professor para este exercício
    ordem INT NULL ,                                            -- Qual exercício fazer primeiro, segundo...
    -- Liga esta linha ao exercício da biblioteca
    CONSTRAINT fk_sessao_exercicio_exercicio FOREIGN KEY (fkexercicio) REFERENCES exercicio (idexercicio) ON DELETE CASCADE ON UPDATE CASCADE,
    -- Liga esta linha à sessão de treino (Treino A, B, C)
    CONSTRAINT fk_sessao_exercicio_sessao_treino FOREIGN KEY (fksessao_treino) REFERENCES sessao_treino (idsessao_treino) ON DELETE CASCADE ON UPDATE CASCADE
);