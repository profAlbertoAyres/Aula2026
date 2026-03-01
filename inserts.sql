USE personal_trainer;

-- 1. USUÁRIOS
INSERT INTO usuario (username, email, senha, tipo_usuario, ativo) VALUES 
('admin_cacoal', 'admin@cacoalfitness.com.br', 'root123', 'ADMIN', 1),
('roberto_coach', 'roberto_manso@fit.com', 'roberto2024', 'PERSONAL', 1),
('amanda_fit', 'amanda.souza@gmail.com', 'amanda123', 'ALUNO', 1),
('bruno_monstro', 'bruno.lima@hotmail.com', 'bruno99', 'ALUNO', 1),
('bia_silva', 'beatriz.barboza@gmail.com', '123456', 'ALUNO', 1),
('ricardo_santos', 'ricardo.santos@outlook.com', 'ric123', 'ALUNO', 1),
('nandacosta', 'fernanda.costa@gmail.com', 'nanda10', 'ALUNO', 1);

-- 2. PERSONAIS
INSERT INTO personal (fkusuario, nome, cref, especialidade, celular) VALUES 
(2, 'Roberto Silva Manso', '654321-G/RO', 'Treinamento Funcional e Crossfit', '(69) 99200-1122');

-- 3. ALUNOS (Dados completos de Cacoal - RO)
INSERT INTO aluno (fkusuario, nome, sexo, nascimento, celular, logradouro, bairro, cidade, estado, cep, objetivo) VALUES 
(3, 'Amanda Souza Ferreira', 'F', '1998-03-15', '(69) 99344-5566', 'Av. Sete de Setembro, 1234', 'Centro', 'Cacoal', 'RO', '76960-000', 'Emagrecimento e Definição'),
(4, 'Bruno Lima de Oliveira', 'M', '1985-07-22', '(69) 99211-2233', 'Rua Anísio Serrão, 550', 'Centro', 'Cacoal', 'RO', '76960-000', 'Ganho de Massa Muscular'),
(5, 'Beatriz Silva Barboza', 'F', '2001-11-02', '(69) 98400-9988', 'Av. Castelo Branco, 2100', 'Princesa Isabel', 'Cacoal', 'RO', '76962-000', 'Melhorar Condicionamento'),
(6, 'Ricardo Santos Magalhães', 'M', '1992-05-30', '(69) 99988-7766', 'Rua Afonso Pena, 88', 'Jardim Clodoaldo', 'Cacoal', 'RO', '76963-000', 'Saúde e Longevidade'),
(7, 'Fernanda Costa e Silva', 'F', '1994-08-12', '(69) 98122-3344', 'Av. Guaporé, 305', 'Incra', 'Cacoal', 'RO', '76964-000', 'Hipertrofia Muscular');

-- 4. AVALIAÇÃO FÍSICA (Exemplo de dados para cada aluno)
INSERT INTO avaliacao (fkaluno, data, peso, altura, percentual_gordura, massa_magra, circ_abdominal, observacoes) VALUES 
(1, '2024-05-01', 65.50, 1.65, 22.5, 50.2, 75.0, 'Início do plano de emagrecimento.'),
(2, '2024-05-02', 88.20, 1.80, 18.0, 72.0, 88.5, 'Foco em ganho de força.'),
(3, '2024-05-05', 58.00, 1.60, 25.0, 42.0, 72.0, 'Melhorar resistência aeróbica.'),
(4, '2024-05-10', 80.00, 1.75, 20.0, 64.0, 90.0, 'Sedentário há 2 anos.'),
(5, '2024-05-12', 72.40, 1.70, 15.5, 61.0, 78.0, 'Atleta de vôlei local.');

-- 5. MENSALIDADES
INSERT INTO mensalidade (fkaluno, mes_referencia, valor, vencimento, pagamento, status) VALUES 
(1, '2024-05', 130.00, '2024-05-10', '2024-05-08', 'PAGO'),
(2, '2024-05', 130.00, '2024-05-10', NULL, 'PENDENTE'),
(3, '2024-05', 130.00, '2024-05-10', '2024-05-10', 'PAGO'),
(4, '2024-05', 130.00, '2024-05-10', NULL, 'ATRASADO'),
(5, '2024-05', 130.00, '2024-05-10', NULL, 'PENDENTE');

-- 6. EXERCÍCIOS
INSERT INTO exercicio (nome, descricao, grupo_muscular) VALUES 
('Agachamento com Barra', 'Agachamento livre com barra nas costas', 'Pernas'),
('Leg Press 45', 'Empurre a plataforma com as pernas em 45 graus', 'Pernas'),
('Supino Reto', 'Deitado no banco, empurre a barra para cima', 'Peitoral'),
('Puxada Frontal', 'Puxar a barra no pulley em direção ao peito', 'Costas'),
('Rosca Direta', 'Flexão de braços com barra em pé', 'Bíceps'),
('Prancha Abdominal', 'Sustentar o corpo com antebraços no chão', 'Core');