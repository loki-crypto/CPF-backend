

--CRIAR O BANCO
CREATE DATABASE db_academia_producao;
 db_academia_producao;

-- CRIAR  AS TABELAS
CREATE TABLE alunos (
    aluno_id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE NOT NULL,
    email VARCHAR(100));

CREATE TABLE exercicios (
    exercicio_id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    grupo_muscular VARCHAR(50) NOT NULL);

CREATE TABLE treinos (
    treino_id SERIAL PRIMARY KEY,
    aluno_id INTEGER REFERENCES alunos(aluno_id),
    exercicio_id INTEGER REFERENCES exercicios(exercicio_id),
    data_treino DATE NOT NULL,
    series INTEGER,
    repeticoes INTEGER,
    peso DECIMAL(8,2));

-- INSERIR OS DADOS
INSERT INTO alunos (nome, data_nascimento, email) VALUES
('Luiz Eduardo', '2002-08-17', 'luizao17@email.com'),
('Coroa da BMW', '1969-08-22', 'milfzona69@email.com'),
('Coroa da Mercedes', '1975-06-13', 'milfzona67@email.com'),
('Marcao dos Venenos', '1988-01-02', 'danone666@email.com');

INSERT INTO exercicios (nome, grupo_muscular) VALUES
('Supino Reto', 'Peito'),
('Agachamento', 'Pernas'),
('Rosca Direta', 'Bíceps');

INSERT INTO treinos VALUES
(1, 1, 1, '2024-01-15', 4, 12, 60.0),
(2, 1, 3, '2024-01-15', 3, 15, 12.5),
(3, 2, 2, '2024-01-16', 5, 8, 80.0);

-- CRIANDO AS VIEWS DOS JOIN E SUBQUERIES 
CREATE VIEW vw_treinos_completos AS
SELECT 
    t.treino_id,
    a.nome as aluno_nome,
    e.nome as exercicio_nome,
    e.grupo_muscular,
    t.data_treino,
    t.series,
    t.repeticoes,
    t.peso
FROM treinos t
JOIN alunos a ON t.aluno_id = a.aluno_id
JOIN exercicios e ON t.exercicio_id = e.exercicio_id;

-- CONSULTAS
-- USANDO JOIN
SELECT * FROM vw_treinos_completos;

-- Consulta usando SUBQUERY vendo quem pegou mais de 50kg nos treinos
SELECT nome FROM alunos 
WHERE aluno_id IN (SELECT aluno_id FROM treinos WHERE peso > 50);
