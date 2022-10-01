-- Вариант 3

-- Задание 1

drop table Teacher, Subject, Department, TS

create table if not exists Department
(
	id serial primary key,
	name varchar(50),
	description varchar(150)
);


create table if not exists Teacher
(
	id serial primary key,
	FIO varchar(50) not null,
	grade varchar(50) not null,
	position varchar(50) not null,
	department int,
	foreign key (department) references Department(id)
);


create table if not exists Subject
(
	id serial primary key,
	name varchar(50) not null,
	hours int,
	semester int,
	rate int
);


create table if not exists TS
(
	id serial primary key,
	teacher_id serial,
	foreign key (teacher_id) references Teacher(id),
	subject_id serial,
	foreign key (subject_id) references Subject(id)
);



insert into Department(name, description) values
('Dep 1', 'Good department 1'),
('Dep 2', 'Good department 2'),
('Dep 3', 'Good department 3'),
('Dep 4', 'Good department 4'),
('Dep 5', 'Good department 5'),
('Dep 6', 'Good department 6'),
('Dep 7', 'Good department 7'),
('Dep 8', 'Good department 8'),
('Dep 9', 'Good department 9'),
('Dep 10', 'Good department 10');


insert into Teacher(FIO, grade, position, department) values
('FIO1', 'Grade 1', 'Teacher', 1),
('FIO2', 'Grade 2', 'Teacher', 2),
('FIO3', 'Grade 3', 'Director', 3),
('FIO4', 'Grade 4', 'Teacher', 4),
('FIO5', 'Grade 5', 'Teacher', 5),
('FIO6', 'Grade 6', 'Laborant', 6),
('FIO7', 'Grade 7', 'Laborant', 7),
('FIO8', 'Grade 8', 'Laborant', 8),
('FIO9', 'Grade 9', 'Teacher', 9),
('FIO10', 'Grade 10', 'Teacher', 10);


insert into Subject(name, hours, semester, rate) values
('Subject 1', 10,  1, 10),
('Subject 2', 20,  1, 9),
('Subject 3', 30,  2, 8),
('Subject 4', 40,  2, 7),
('Subject 5', 50,  3, 6),
('Subject 6', 60,  3, 5),
('Subject 7', 70,  4, 4),
('Subject 8', 80,  5, 3),
('Subject 9', 90,  6, 2),
('Subject 10', 100,  7, 1);


insert into TS(teacher_id, subject_id) values
('1', '10'),
('2', '9'),
('3', '8'),
('4', '7'),
('5', '6'),
('6', '1'),
('7', '4'),
('8', '3'),
('9', '2'),
('10', '5');


-- Задание 2

-- 1) Инструкция SELECT, использующая предикат сравнения с квантором

-- Получить предметы, кол-во часов у которых больше,
-- чем кол-во часов у всех предметов в 3ем семестре


select *
from Subject
where hours > ALL (select hours
				  from Subject
				  where semester = 3);
				  
				  
-- 2) Инструкция SELECT, использующая агрегатные функции в
-- выражениях столбцов

-- Общее количество часов, которое будет потрачено
-- на все предметы в семестрах после второго

select sum(hours)
from Subject
where semester > 2;


-- 3) Создание новой временной локальной таблицы из результирующего
-- набора данных инструкции SELECT

-- Временная таблица, где семестры больше 3

select * into tmp_table
from Subject
where semester > 3



-- Задание 3

-- Создать хранимую процедуру с входным параметром – «имя таблицы»,
-- которая удаляет дубликаты записей из указанной таблицы в текущей базе
-- данных. Созданную хранимую процедуру протестировать.

drop table tmp_dup;

create table if not exists tmp_dup
(
	id int,
	str varchar(50)
);


insert into tmp_dup(id, str) values
(1, 'a'),
(2, 'b'),
(1, 'a'),
(3, 'd');

select * -- до удаления
from tmp_dup;


create or replace procedure del_duplic(name_table varchar)
as
$$
declare 
	query text;
begin
	query =  'delete from ' || quote_ident(name_table)
        || ' where ctid not in (select min(ctid) from ' || quote_ident(name_table)
        || ' group by '|| quote_ident(name_table) || '.*)';
		
	execute query;
end;
$$ language plpgsql;


call del_duplic('tmp_dup')


select * -- после удаления
from tmp_dup;



