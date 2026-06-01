-- 1. ESTRUTURA (Criação das Tabelas)
CREATE TABLE departamentos (
    id_depto INT PRIMARY KEY,
    nome_depto VARCHAR(50),
    coordenador_setor VARCHAR(50)
);

CREATE TABLE agentes (
    id_agente INT PRIMARY KEY AUTO_INCREMENT,
    nome_usuario VARCHAR(100) NOT NULL,
    chave_acesso VARCHAR(20) UNIQUE,
    id_setor INT,
    FOREIGN KEY (id_setor) REFERENCES departamentos(id_depto)
);

CREATE TABLE sistema_logs (
    id_log INT PRIMARY KEY AUTO_INCREMENT,
    id_agente_responsavel INT,
    descricao_evento VARCHAR(255),
    data_evento DATE,
    kb_trafegados INT,
    ip_origem VARCHAR(15),
    FOREIGN KEY (id_agente_responsavel) REFERENCES agentes(id_agente)
);

-- 2. POPULANDO DEPARTAMENTOS
INSERT INTO departamentos VALUES 
(1, 'Segurança Digital', 'Tenente Malware'),
(2, 'Infraestrutura', 'Eng. Proxy'),
(3, 'Desenvolvimento', 'Sra. Script');

-- 3. POPULANDO AGENTES (Investigados)
INSERT INTO agentes (nome_usuario, chave_acesso, id_setor) VALUES 
('Agente_Alberto', 'IFRO-2026', 1),
('Inv_Silencioso', 'X-99', 1),
('Dev_Junior', 'WEB-10', 3),
('Suporte_Tec', 'SUP-01', 2);

-- 4. CARGA MASSIVA DE LOGS (Volume para 140 min de aula)
INSERT INTO sistema_logs (id_agente_responsavel, descricao_evento, data_evento, kb_trafegados, ip_origem) VALUES 
(1, 'Acesso de rotina', '2026-03-01', 50, '192.168.1.10'),
(2, 'Falha no Login - Tentativa 1', '2026-03-02', 15, '192.168.1.50'),
(2, 'Falha no Login - Tentativa 2', '2026-03-02', 20, '192.168.1.50'),
(2, 'Falha no Login - Tentativa 3', '2026-03-02', 25, '192.168.1.50'),
(1, 'Upload de backup anual', '2026-03-03', 4500, '192.168.1.10'),
(3, 'Consulta de tabela de alunos', '2026-03-04', 200, '172.16.0.5'),
(2, 'Acesso Suspeito Detectado', '2026-03-05', 1500, '192.168.1.50'),
(1, 'Acesso de rotina - Manutenção', '2026-03-06', 45, '192.168.1.12'),
(2, 'Falha na Criptografia de disco', '2026-03-07', 450, '10.0.0.15'),
(3, 'Acesso de rotina sistema acadêmico', '2026-03-08', 30, '172.16.0.5'),
(4, 'Reconfiguração de switch', '2026-03-09', 1200, '10.0.0.1'),
(1, 'Acesso de rotina', '2026-03-09', 55, '192.168.1.10'),
(2, 'Download de Arquivos Críticos (.zip)', '2026-03-10', 8900, '192.168.1.50'),
(3, 'Tentativa de Login Root - Negado', '2026-03-11', 120, '172.16.0.5'),
(4, 'Backup de logs de rede', '2026-03-12', 3000, '10.0.0.1'),
(1, 'Acesso de rotina', '2026-03-12', 60, '192.168.1.10'),
(2, 'Varredura de portas (Port Scan)', '2026-03-13', 3200, '192.168.1.50'),
(3, 'Alteração de privilégios de usuário', '2026-03-14', 1500, '172.16.0.5'),
(2, 'Limpeza de logs de sistema - Wipe', '2026-03-15', 500, '192.168.1.50'),
(1, 'Acesso fora de hora (Sábado)', '2026-03-20', 300, '192.168.1.30'),
(3, 'Ping da morte detectado (ICMP)', '2026-03-25', 50, '172.16.0.10'),
(2, 'Falha crítica no serviço SSH', '2026-03-03', 100, '192.168.1.50'),
(4, 'Acesso autorizado - VPN', '2026-03-05', 800, '10.0.0.1'),
(2, 'Download de DB_PRODUCAO.sql', '2026-03-11', 15400, '192.168.1.50'),
(1, 'Falha técnica no sincronismo', '2026-03-08', 300, '192.168.1.10'),
(2, 'Falha persistente de conexão', '2026-03-14', 80, '192.168.1.50'),
(4, 'Monitoramento de tráfego UDP', '2026-03-15', 2100, '10.0.0.1'),
(3, 'Acesso ao módulo de notas', '2026-03-10', 400, '172.16.0.5');