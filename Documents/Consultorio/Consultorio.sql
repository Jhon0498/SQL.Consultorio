create database consultorio;

use consultorio;

create table pessoas(
	id int not null primary key identity,
	data_nascimento date not null,
	genero varchar(50),
	estado_civil varchar(50),
	rg varchar(14) not null
);

ALTER TABLE pessoas 
ADD nome VARCHAR (100);

SET IDENTITY_INSERT pessoas ON;
DELETE FROM pessoas WHERE id IN (1, 2, 3, 4, 5);
--INSERIR REGISTROS 
INSERT INTO pessoas (ID, data_nascimento, genero,  estado_civil, rg, nome) 
values  
(1, '1998-04-04', 'Masculino', 'solteiro', '39.487.545-5', 'Jhonatan Mendes'),
(2, '2000-04-28', 'Feminino', 'solteiro', '49.887.945-9', 'Eduarda Satana'),
(3, '1982-06-08', 'Não identificado', 'solteiro', '28.545.825-8', 'Renato Montanha'),
(4, '2004-09-08', 'Feminino', 'solteiro', '39.487.545-5', 'Ana banana'),
(5, '2002-06-28', 'Masculino', 'solteiro', '40.457.245-5', 'Mateus Folha');

SELECT * FROM pessoas;

SET IDENTITY_INSERT pessoas OFF;


create table telefones(
	id_pessoa int not null,
	ddd int not null,
	telefone varchar(10) not null,
	primary key (id_pessoa, ddd, telefone),
	foreign key (id_pessoa) references pessoas (id)
);
INSERT INTO telefones (id_pessoa, ddd, telefone)
Values
('1', '11', '5678-5879'),
('2', '11', '91185-3562'),
('3', '11', '2458-6325'),
('4', '11', '5894-6844'),
('5', '21', '94585-9635');

SELECT * FROM telefones 

create table enderecos(
	id int not null identity,
	id_pessoa int not null,
	logradouro varchar(50),
	numero varchar(10) not null,
	cep varchar(9) not null,
	bairro varchar(50),
	cidade varchar(50),
	estado varchar(50),
	primary key (id, id_pessoa),
	foreign key (id_pessoa) references pessoas (id)
);
INSERT INTO enderecos (id_pessoa, logradouro, numero, cep, bairro, cidade, estado)
Values

('1', 'rua', '120', '01213-020', 'Alameda dos Santos', 'Jardim Zelda', 'Alemedão'),
('2', 'rua', '250', '01235-048', 'Eurico Gapar', 'São Paulo', 'São Paulo'),
('3', 'Avenida', '985', '88556-789', 'Montanhosas', 'Montanhas city', 'Montanhão'),
('4', 'Rua', '18', '01223-048', 'Pirituba', 'São Paulo', 'São Paulo'),
('5', 'Rua', '354', '0905-487', 'Pirituba', 'São Paulo', 'São Paulo');

SELECT * FROM enderecos


create table pacientes(
	id_pessoa int not null primary key,
	convenio varchar(50),
	foreign key (id_pessoa) references pessoas (id)
);
INSERT INTO pacientes (id_pessoa, convenio)
Values

('1', 'AMIL'),
('2', 'NOTREDAME'),
('3', 'AMIL'),
('4', 'NOTREDAME'),
('5', 'NOTREDAME');

SELECT * FROM pacientes

create table medicos(
	id_pessoa int not null primary key,
	crm varchar(10),
	foreign key (id_pessoa) references pessoas (id)
);
INSERT INTO Medicos (id_pessoa, crm)
Values

(2, 'CRM123456'),
(5, 'CRM243524'),


SELECT * FROM medicos

create table consultas(
	id int not null primary key identity,
	data datetime not null,
	diagnostico varchar(100),
	id_medico int not null,
	id_paciente int not null,
	foreign key (id_medico) references medicos (id_pessoa),
	foreign key (id_paciente) references pacientes (id_pessoa)
);
INSERT INTO consultas (data, diagnostico, id_medico, id_paciente)
VALUES
('2024-04-14T07:00:00', 'Ser Lindo', 2, 1),
('2024-05-12T08:00:00', 'Ser Cantor', 5, 3),
('2024-06-05T09:00:00', 'Ser chata', 5, 4);


SELECT * FROM consultas;


CREATE TABLE exames (
    id INT NOT NULL PRIMARY KEY IDENTITY,
    id_consulta INT NOT NULL,
    data DATETIME NOT NULL,
    exame VARCHAR(100),
	FOREIGN KEY (id_consulta) REFERENCES consultas (id),
);
INSERT INTO exames (id_consulta, data, exame)
SELECT id, '2024-04-14T07:00:00', 'Psicológico' FROM consultas WHERE id = 1;

INSERT INTO exames (id_consulta, data, exame)
SELECT id, '2024-05-12T08:00:00', 'Exame de cordas vocais' FROM consultas WHERE id = 2;

INSERT INTO exames (id_consulta, data, exame)
SELECT id, '2024-06-05T09:00:00', 'Psicológico' FROM consultas WHERE id = 3;

SELECT * FROM exames;

SELECT pessoas.id, pessoas.data_nascimento, pessoas.genero, pessoas.estado_civil, pessoas.rg, pessoas.nome,
       pacientes.convenio
FROM pessoas
JOIN pacientes ON pessoas.id = pacientes.id_pessoa;

SELECT pessoas.id, pessoas.data_nascimento, pessoas.genero, pessoas.estado_civil, pessoas.rg, pessoas.nome,
       medicos.crm
FROM pessoas
JOIN medicos ON pessoas.id = medicos.id_pessoa;