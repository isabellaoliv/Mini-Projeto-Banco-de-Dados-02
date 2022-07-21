-- Criar banco de dados da Resilia
CREATE DATABASE db_resilia;
USE db_resilia;

-- Criar entidade cursos
CREATE TABLE cursos(
id INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR (100),
tipo VARCHAR (100)
);

-- Verificar criação da entidade cursos
SELECT * FROM cursos;

-- Criar entidade turmas  
CREATE TABLE turmas(
id INT PRIMARY KEY AUTO_INCREMENT,
nome_turma VARCHAR (100),
numero INT,
cursos_id INT,
FOREIGN KEY (cursos_id) REFERENCES cursos (id)
);
-- Verificar criação da entidade turmas
SELECT * FROM turmas;

-- Criar entidade alunos
CREATE TABLE alunos(
nome VARCHAR (100),
email TEXT,
data_nascimento date,
CPF VARCHAR (11) PRIMARY KEY,
turmas_id INT,
FOREIGN KEY (turmas_id) REFERENCES turmas (id)
);

-- Verificar criação da entidade alunos
SELECT * FROM alunos;

-- Criar entidade entregas
CREATE TABLE entregas(
link VARCHAR (100),
modulo INT, 
conceito VARCHAR (60),
alunos_cpf VARCHAR (11),
FOREIGN KEY (alunos_cpf) REFERENCES alunos (CPF) 
);

-- Verificar criação da entidade entregas
SELECT * FROM entregas;


INSERT INTO cursos (id, nome, tipo) 
VALUES (001,'Formação WebDev Full Stack','Formação online'),
(002, 'Formação em Data Analytics','Formação online');

INSERT INTO turmas (nome_turma, numero, cursos_id) 
VALUES ('Turma 18',1,001),
('Turma 19',2,002);

INSERT INTO alunos (nome, email, data_nascimento, cpf, turmas_id) 
VALUES ('Isabella', 'visabella303@yahoo.com', '1997-05-14', 11111111111, 1),
 ('Leo', 'leobm@gmail.com', '1994-09-05', 11111111112, 2),
 ('Pedro', 'pedrocdd@gmail.com', '2003-05-28', 11111111113, 1),
 ('Janize', 'janize@yahoo.com', '1990-03-15', 11111111114, 2),
 ('Kathelen', 'kathelen@uol.com', '1995-04-21', 11111111115, 1);
 
 INSERT INTO entregas (link, modulo, conceito, alunos_cpf) 
 VALUES ('https://github.com/isabella/repoProjetoFinal1', 1, 'mais que pronto', 11111111111),
 ('https://github.com/leo/repoProjetoFinal1', 1, 'pronto', 11111111112),
 ('https://github.com/pedro/repoProjetoFinal1', 1, 'ainda não esta pronto', 11111111113),
 ('https://github.com/janize/repoProjetoFinal1', 1, 'chegando lá', 11111111114),
 ('https://github.com/kathelen/repoProjetoFinal1', 1, 'pronto', 11111111115);
 
 -- Alunos que entregaram o projeto do módulo 1 e estão com o conceito em “Pronto” ou “Mais que pronto”
 SELECT * 
 FROM entregas 
 WHERE modulo =1  AND conceito = 'pronto' OR 'mais que pronto';
 
 -- Quantos alunos tem cada turma?
 SELECT turmas_id, COUNT(turmas_id) AS `quantidade de alunos`
 FROM alunos
 GROUP BY turmas_id;
 
 -- Quantos projetos no total foram entregues com conceito “Ainda não está pronto” e “Chegando lá”?
 SELECT COUNT(conceito) 
 FROM entregas 
 WHERE conceito = 'ainda não esta pronto' OR conceito = 'chegando lá';
 
 -- Qual turma com maior nota 'mais que pronto'?
 SELECT turmas_id, COUNT(conceito) AS maior_nota
 FROM alunos
 INNER JOIN entregas ON alunos.cpf = entregas.alunos_cpf
 WHERE conceito = 'mais que pronto'
 GROUP BY turmas_id
 ORDER BY maior_nota DESC;