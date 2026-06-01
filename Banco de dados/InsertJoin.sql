USE personal_trainer3a;

-- USUÁRIOS

INSERT INTO usuario (username,email,senha,tipo_usuario) VALUES
('ana.silva','ana@email.com','123','ALUNO'),
('bruno.costa','bruno@email.com','123','ALUNO'),
('carla.mendes','carla@email.com','123','ALUNO'),
('diego.rocha','diego@email.com','123','ALUNO'),
('elisa.pereira','elisa@email.com','123','ALUNO'),
('felipe.santos','felipe@email.com','123','ALUNO'),
('gabriela.lima','gabi@email.com','123','ALUNO'),
('henrique.alves','henrique@email.com','123','ALUNO'),
('isabela.ferraz','isa@email.com','123','ALUNO'),
('joao.torres','joao@email.com','123','ALUNO'),
('karen.duarte','karen@email.com','123','ALUNO'),
('lucas.faria','lucas@email.com','123','ALUNO'),

('pedro.gomes','pedro@email.com','123','PERSONAL'),
('julia.trainer','julia@email.com','123','PERSONAL'),
('ricardo.coach','ricardo@email.com','123','PERSONAL'),

('admin.sistema','admin@email.com','123','ADMIN');


-- ALUNOS

INSERT INTO aluno (fkusuario,nome,sexo,nascimento,cidade,estado,logradouro,bairro,celular) VALUES

(1,'Ana Silva','F','1995-03-10','Cacoal','RO','Rua Rio Branco','Centro','69992110001'),
(2,'Bruno Costa','M','1992-07-21','Cacoal','RO','Rua Paraná','Jardim Clodoaldo','69992110002'),
(3,'Carla Mendes','F','1998-01-05','Cacoal','RO','Av Belo Horizonte','Centro','69992110003'),
(4,'Diego Rocha','M','1990-11-30','Cacoal','RO','Rua Amazonas','Floresta','69992110004'),
(5,'Elisa Pereira','F','1997-09-15','Cacoal','RO','Rua Guaporé','Princesa Isabel','69992110005'),
(6,'Felipe Santos','M','1993-04-02','Cacoal','RO','Rua Ji-Paraná','Centro','69992110006'),
(7,'Gabriela Lima','F','1996-08-18','Cacoal','RO','Av Castelo Branco','Centro','69992110007'),
(8,'Henrique Alves','M','1991-06-12','Cacoal','RO','Rua das Flores','Vista Alegre','69992110008'),
(9,'Isabela Ferraz','F','1999-02-14','Espigão D''Oeste','RO','Rua Paraná','Centro','69992110014'),
(10,'João Torres','M','1994-05-09','Espigão D''Oeste','RO','Rua Paraná','Centro','69992110015'),
(11,'Karen Duarte','F','1996-12-20','Pimenta Bueno','RO','Rua Rondônia','Centro','69992110011'),
(12,'Lucas Faria','M','1993-03-11','Pimenta Bueno','RO','Rua Paraná','Industrial','69992110012');

-- PERSONAL TRAINERS

INSERT INTO personal (fkusuario,nome,cref,especialidade,celular) VALUES
(13,'Júlia da Silva Benicio','CREF12345','Hipertrofia','69999220001'),
(14,'Andre Mello Souza','CREF54321','Emagrecimento','69999220002'),
(15,'Joana Silva','CREF98765','Treinamento Funcional','69999220003');


-- AVALIAÇÕES

INSERT INTO avaliacao (fkaluno,data,peso,altura,percentual_gordura) VALUES
(1,'2025-02-09',65,1.65,22),
(2,'2026-03-09',82,1.78,18),
(3,'2026-03-10',70,1.70,24),
(4,'2026-03-10',90,1.80,20),
(5,'2026-03-11',58,1.60,25),
(6,'2025-08-11',85,1.75,19),
(6,'2026-02-02',82,1.75,23),
(8,'2026-03-12',88,1.82,21),
(9,'2026-03-13',55,1.58,26),
(1,'2026-03-13',68,1.65,12),
(2,'2026-03-14',85,1.78,10),
(3,'2026-03-14',80,1.70,04);

-- AGENDA

INSERT INTO agenda (fkaluno,inicio,fim,status) VALUES
(1,'2026-03-02 08:00','2026-03-02 09:00','REALIZADO'),
(2,'2026-03-03 09:00','2026-03-03 10:00','REALIZADO'),
(3,'2026-03-04 08:00','2026-03-04 09:00','REALIZADO'),
(4,'2026-03-05 09:00','2026-03-05 10:00','CANCELADO'),
(5,'2026-03-06 08:00','2026-03-06 09:00','REALIZADO'),
(6,'2026-03-07 09:00','2026-03-07 10:00','REALIZADO'),

(1,'2026-03-10 08:00','2026-03-10 09:00','AGENDADO'),
(2,'2026-03-10 09:00','2026-03-10 10:00','AGENDADO'),
(3,'2026-03-11 08:00','2026-03-11 09:00','AGENDADO'),
(4,'2026-03-11 09:00','2026-03-11 10:00','AGENDADO'),
(5,'2026-03-12 08:00','2026-03-12 09:00','AGENDADO'),
(6,'2026-03-12 09:00','2026-03-12 10:00','AGENDADO'),
(8,'2026-03-13 09:00','2026-03-13 10:00','AGENDADO'),
(9,'2026-03-14 08:00','2026-03-14 09:00','AGENDADO'),
(10,'2026-03-14 09:00','2026-03-14 10:00','AGENDADO');


-- EXERCÍCIOS

INSERT INTO exercicio (nome,descricao,grupo_muscular) VALUES
('Supino Reto','Empurrar barra no banco reto','Peito'),
('Supino Inclinado','Empurrar barra em banco inclinado','Peito'),
('Crucifixo','Abertura de braços com halteres','Peito'),
('Puxada Frente','Puxar barra na polia alta','Costas'),
('Remada Baixa','Puxar triângulo na polia','Costas'),
('Agachamento Livre','Agachar com barra nas costas','Pernas'),
('Leg Press','Empurrar plataforma com as pernas','Pernas'),
('Afundo','Passada com halteres','Pernas'),
('Rosca Direta','Flexão de cotovelo com barra','Bíceps'),
('Rosca Martelo','Flexão de cotovelo com halteres','Bíceps'),
('Prancha','Isometria abdominal','Core'),
('Burpee','Exercício funcional completo','Cardio'),
('Kettlebell Swing','Movimento explosivo com kettlebell','Posterior de Coxa');


-- PLANO TREINO

INSERT INTO plano_treino (fkaluno,descricao,inicio,final,status) VALUES
(1,'Adaptação Inicial','2025-10-01','2026-01-31','FINALIZADO'),
(1,'Hipertrofia Iniciante','2026-02-01',NULL,'ATIVO'),
(2,'Hipertrofia Iniciante','2026-03-01',NULL,'ATIVO'),
(3,'Treino Funcional','2026-03-01','2026-04-01','FINALIZADO'),
(4,'Adaptação Inicial','2025-12-01','2026-02-28','FINALIZADO'),
(4,'Condicionamento Geral','2026-03-01',NULL,'ATIVO'),
(5,'Hipertrofia Peito','2026-03-01',NULL,'ATIVO'),
(6,'Treino Força','2026-03-01','2026-04-01','ATIVO');


-- SESSÃO TREINO
INSERT INTO sessao_treino (fkplano_treino,nome,ordem) VALUES
(1,'Treino A - Corpo Inteiro',1),
(1,'Treino B - Corpo Inteiro',2),

(2,'Treino A - Peito e Tríceps',1),
(2,'Treino B - Costas e Ombro',2),
(2,'Treino C - Pernas',3),

(3,'Treino A - Peito',1),
(3,'Treino B - Costas',2),
(3,'Treino C - Pernas',3),

(4,'Treino A - Funcional',1),
(4,'Treino B - Core',2),

(5,'Treino A - Corpo Inteiro',1),
(5,'Treino B - Corpo Inteiro',2),

(6,'Treino A - Superiores',1),
(6,'Treino B - Inferiores',2),
(6,'Treino C - Core',3),

(7,'Treino A - Peito',1),
(7,'Treino B - Costas',2),
(7,'Treino C - Pernas',3),
(7,'Treino D - Ombro e Braço',4),

(8,'Treino A - Força Inferior',1),
(8,'Treino B - Força Superior',2),
(8,'Treino C - Core',3);

INSERT INTO sessao_exercicio
(fksessao_treino,fkexercicio,series,repeticoes,carga,tempo_descanso,orientacoes,ordem)
VALUES

-- Treino 1
(1,1,3,12,20,60,'Movimento controlado',1),
(1,2,3,12,20,60,'Foco no posterior',2),
(1,7,3,15,NULL,45,'Contração abdominal',3),

-- Treino 2
(2,4,3,10,12,60,'Controle na descida',1),
(2,3,3,12,8,60,'Elevação até linha do ombro',2),
(2,8,3,15,NULL,45,'Subir pernas controlado',3),

-- Treino 3
(3,4,4,10,14,90,'Empurrar totalmente os halteres',1),
(3,5,3,12,20,60,'Extensão completa',2),
(3,7,3,15,NULL,45,'Controle abdominal',3),

-- Treino 4
(4,10,4,10,30,90,'Manter coluna neutra',1),
(4,3,3,12,8,60,'Evitar balanço',2),
(4,7,3,15,NULL,45,'Respiração controlada',3),

-- Treino 5
(5,1,4,10,30,90,'Controle do movimento',1),
(5,2,4,10,30,90,'Foco posterior',2),
(5,9,4,15,20,60,'Segurar no topo',3),

-- Treino 6
(6,7,3,15,NULL,45,'Contração abdominal',1),
(6,8,3,15,NULL,45,'Subir pernas controlado',2),
(6,3,3,12,6,45,'Sem balanço',3),

-- Treino 7
(7,10,4,10,32,90,'Remada controlada',1),
(7,3,3,12,8,60,'Elevação controlada',2),
(7,7,3,15,NULL,45,'Contração abdominal',3),

-- Treino 8
(8,1,4,10,32,90,'Execução completa',1),
(8,2,4,10,32,90,'Controle movimento',2),
(8,9,4,15,20,60,'Panturrilha completa',3),

-- Treino 9
(9,7,3,15,NULL,45,'Abdômen firme',1),
(9,8,3,15,NULL,45,'Movimento controlado',2),
(9,3,3,12,6,45,'Elevação controlada',3);
-- SERVIÇOS

INSERT INTO servico (titulo,descricao,publico,objetivo,inclui,diferencial) VALUES
('Treino Personalizado','Treino individual','Iniciantes','Condicionamento físico','Avaliação física','Acompanhamento semanal'),
('Emagrecimento','Treino para perda de peso','Adultos','Redução de gordura','Treino + dieta','Resultados rápidos'),
('Treino Funcional','Treino com movimentos naturais','Todos','Melhorar mobilidade','Circuito funcional','Alta intensidade');


-- =====================================================
-- MENSALIDADES
-- =====================================================

INSERT INTO mensalidade
(fkaluno, mes_referencia, valor, vencimento, pagamento, status)
VALUES
(4,'2026-03',150,'2026-03-10','2026-03-08','PAGO'),
(5,'2026-03',150,'2026-03-10',NULL,'PENDENTE'),
(6,'2026-03',150,'2026-03-10',NULL,'ATRASADO'),
(7,'2026-03',150,'2026-03-10','2026-03-09','PAGO'),
(8,'2026-03',150,'2026-03-10',NULL,'PENDENTE'),
(9,'2026-03',150,'2026-03-10',NULL,'ATRASADO'),
(10,'2026-03',150,'2026-03-10','2026-03-07','PAGO');