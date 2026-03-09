/* POPULAÇÃO DO BANCO DE DADOS Sistema: Personal Trainer */

USE personal_trainer;

/* USUÁRIOS */

INSERT INTO usuario (username, email, senha, tipo_usuario) VALUES
('carlos.personal', 'carlos@pt.com', '123456', 'PERSONAL'),
('ana.silva', 'ana@email.com', '123456', 'ALUNO'),
('bruno.lima', 'bruno@email.com', '123456', 'ALUNO'),
('carla.mendes', 'carla@email.com', '123456', 'ALUNO'),
('daniel.rocha', 'daniel@email.com', '123456', 'ALUNO'),
('erika.santos', 'erika@email.com', '123456', 'ALUNO'),
('felipe.alves', 'felipe@email.com', '123456', 'ALUNO');

/* PERSONAL */

INSERT INTO personal (fkusuario, nome, cref, especialidade, celular)
VALUES (1, 'Carlos Eduardo', 'CREF12345', 'Musculação e Emagrecimento', '69999999999');

/* ALUNOS */

INSERT INTO aluno 
(fkusuario, nome, sexo, nascimento, celular, cidade, estado, objetivo)
VALUES
(2, 'Ana Silva', 'F', '1998-05-10', '69911111111', 'Porto Velho', 'RO', 'Emagrecimento'),
(3, 'Bruno Lima', 'M', '1995-03-20', '69922222222', 'Porto Velho', 'RO', 'Hipertrofia'),
(4, 'Carla Mendes', 'F', '2000-07-15', '69933333333', 'Porto Velho', 'RO', 'Condicionamento'),
(5, 'Daniel Rocha', 'M', '1992-11-02', '69944444444', 'Porto Velho', 'RO', 'Definição'),
(6, 'Erika Santos', 'F', '1999-01-30', '69955555555', 'Porto Velho', 'RO', 'Hipertrofia'),
(7, 'Felipe Alves', 'M', '1997-09-18', '69966666666', 'Porto Velho', 'RO', 'Emagrecimento');

/* EXERCÍCIOS */

INSERT INTO exercicio (nome, grupo_muscular) VALUES
('Supino Reto', 'Peito'),
('Puxada Frontal', 'Costas'),
('Agachamento Livre', 'Pernas'),
('Rosca Direta', 'Bíceps'),
('Tríceps Corda', 'Tríceps');

/* PLANOS DE TREINO */

INSERT INTO plano_treino (fkaluno, descricao, inicio)
VALUES
(1, 'Fase de Adaptação', '2026-02-01'),
(2, 'Hipertrofia Inicial', '2026-02-01');

/* SESSÕES DE TREINO */

INSERT INTO sessao_treino (fkplano_treino, nome, ordem)
VALUES
(1, 'Treino A - Superiores', 1),
(1, 'Treino B - Inferiores', 2),
(2, 'Treino A - Peito e Costas', 1);

/* SESSÃO EXERCÍCIO */

INSERT INTO sessao_exercicio 
(fksessao_treino, fkexercicio, series, repeticoes, carga, tempo_descanso, ordem)
VALUES
(1, 1, 3, 12, 20, 60, 1),
(1, 2, 3, 12, 25, 60, 2),
(2, 3, 4, 10, 40, 90, 1),
(3, 1, 4, 8, 30, 90, 1);

/* AVALIAÇÕES */

INSERT INTO avaliacao (fkaluno, data, peso, altura, percentual_gordura)
VALUES
(1, '2026-02-01', 70, 1.65, 28),
(2, '2026-02-01', 85, 1.80, 20),
(3, '2026-02-01', 60, 1.60, 30);

/* MENSALIDADES */

INSERT INTO mensalidade (fkaluno, mes_referencia, valor, vencimento, status)
VALUES
(1, '2026-02', 150.00, '2026-02-10', 'PAGO'),
(2, '2026-02', 150.00, '2026-02-10', 'PENDENTE'),
(3, '2026-02', 150.00, '2026-02-10', 'ATRASADO');

