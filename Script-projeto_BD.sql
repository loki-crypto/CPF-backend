-- CRIAR O BANCO DE DADOS
CREATE DATABASE db_biblioteca_sistema;
USE db_biblioteca_sistema;

-- CRIAR AS TABELAS
CREATE TABLE leitores (
    leitor_id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    data_cadastro DATE NOT NULL,
    telefone VARCHAR(20)
);

CREATE TABLE livros (
    livro_id SERIAL PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    autor VARCHAR(100) NOT NULL
);

CREATE TABLE emprestimos (
    emprestimo_id SERIAL PRIMARY KEY,
    leitor_id INTEGER REFERENCES leitores(leitor_id),
    livro_id INTEGER REFERENCES livros(livro_id),
    data_emprestimo DATE NOT NULL,
    data_devolucao DATE,
    dias_atraso INTEGER DEFAULT 0,
    multa DECIMAL(8,2) DEFAULT 0.00
);

-- INSERIR OS DADOS
INSERT INTO leitores (nome, data_cadastro, telefone) VALUES
('Ana Carolina Silva', '2023-03-10', '83-99876-5432'),
('Roberto Machado', '2023-05-22', '83-98765-4321'),
('Fernanda Costa', '2023-07-15', '83-97654-3210'),
('Carlos Eduardo', '2023-09-30', '83-96543-2109');

INSERT INTO livros (titulo, categoria, autor) VALUES
('1984', 'Ficção', 'George Orwell'),
('Sapiens', 'História', 'Yuval Noah Harari'),
('Clean Code', 'Tecnologia', 'Robert C. Martin'),
('O Hobbit', 'Fantasia', 'J.R.R. Tolkien');

INSERT INTO emprestimos VALUES
(1, 1, 1, '2024-01-10', '2024-01-24', 0, 0.00),
(2, 2, 3, '2024-01-12', '2024-01-26', 0, 0.00),
(3, 3, 2, '2024-01-15', NULL, 5, 7.50),
(4, 1, 4, '2024-02-01', NULL, 0, 0.00);

-- CRIANDO AS VIEWS COM JOIN E SUBQUERIES
CREATE VIEW vw_emprestimos_detalhados AS
SELECT 
    e.emprestimo_id,
    l.nome AS leitor_nome,
    l.telefone,
    li.titulo AS livro_titulo,
    li.categoria,
    li.autor,
    e.data_emprestimo,
    e.data_devolucao,
    e.dias_atraso,
    e.multa
FROM emprestimos e
JOIN leitores l ON e.leitor_id = l.leitor_id
JOIN livros li ON e.livro_id = li.livro_id;

-- CONSULTAS
-- USANDO JOIN - Ver todos os empréstimos com detalhes
SELECT * FROM vw_emprestimos_detalhados;

-- USANDO SUBQUERY - Leitores que têm livros em atraso
SELECT nome 
FROM leitores 
WHERE leitor_id IN (
    SELECT leitor_id 
    FROM emprestimos 
    WHERE dias_atraso > 0
);

-- CONSULTA EXTRA - Livros emprestados e ainda não devolvidos
SELECT titulo, categoria 
FROM livros 
WHERE livro_id IN (
    SELECT livro_id 
    FROM emprestimos 
    WHERE data_devolucao IS NULL
);
