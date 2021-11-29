drop table Florist, Bouquet, Customer, CF;


create table if not exists Florist
(
	id serial primary key,
	FIO varchar(50) not null,
	pasp_num int not null,
	tel_number varchar(15) not null
);


create table if not exists Bouquet
(
	id serial primary key,
	author int,
	foreign key (author) references Florist(id),
	name varchar(50) not null
);


create table if not exists Customer
(
	id serial primary key,
	FIO varchar(50) not null,
	birth_date varchar(50) not null,
	city varchar(50) not null,
	tel_number varchar(15) not null
);


create table if not exists CF
(
	id serial primary key,
	customer_id serial,
	foreign key (customer_id) references Customer(id),
	florist_id serial,
	foreign key (florist_id) references Florist(id)
);


insert into Florist(FIO, pasp_num, tel_number) values
('Cvetkov', '354545', '8-800-555-35-35'),
('Khamzina', '123456', '8-900-444-35-25'),
('Maslova', '343431', '8-750-123-15-25'),
('Kishov', '454313', '8-999-999-99-99'),
('Kovalets', '678245', '8-777-555-33-11'),
('Volkov', '890123', '8-555-111-33-55'),
('Krikov', '555555', '8-123-321-56-25'),
('Mironov', '555456', '8-975-444-35-55'),
('Degtyrev', '123479', '8-675-233-35-25'),
('Filipenkov', '111111', '8-111-111-11-11');


insert into Bouquet(author, name) values
('1', 'pioni'),
('2', 'rosi'),
('3', 'tulpani'),
('4', 'acacii'),
('5', 'romashki'),
('6', 'maki'),
('7', 'gerberi'),
('8', 'oduvanchiki'),
('9', 'khrisantemi'),
('10', 'podsolnuhi');


insert into Customer(FIO, birth_date, city, tel_number) values
('Zaborovskaya', '2001-12-23', 'Moscow', '8-999-555-35-35'),
('Artemyev', '2001-11-23', 'Berlin', '8-900-333-35-25'),
('Frolova', '2001-10-23', 'Moscow', '8-999-123-15-33'),
('Baryshnikova', '2001-9-23', 'Moscow', '8-777-777-77-78'),
('Nedoluzhko', '2001-8-23', 'Moscow', '8-123-234-33-11'),
('Zaytceva', '2001-1-26', 'Moscow', '8-123-555-23-55'),
('Kozlova', '2001-7-22', 'Moscow', '8-123-555-56-25'),
('Saburov', '2001-5-23', 'Moscow', '8-567-444-35-45'),
('Diordyev', '2001-5-23', 'Washington', '8-675-233-35-25'),
('Minakova', '2001-4-24', 'Moscow', '8-555-444-11-11');


insert into CF(customer_id, florist_id) values
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


-- select * 
-- from ((Florist as f join cf on f.id = cf.florist_id) as fcf 
-- 		join Customer as c on fcf.customer_id = c.id) as fcfc;
		
-- простой case
-- перевести города

-- select FIO, city,
-- 	case city
-- 		when 'Moscow' then 'Москва'
-- 		when 'Berlin' then 'Берлин'
-- 		else 'Неизвестный город'
-- 	end as transexual
-- from Customer;


-- update + запрос
-- 

-- update Customer
-- set city = (select city
-- 		   from Customer
-- 		   where birth_date like '%26')
-- where id = 9;

-- select *
-- from Customer
-- where id = 9;


-- -- group by + having

-- select city, birth_date
-- from Customer
-- group by city, birth_date
-- having birth_date like '2001%'


-- -- коррелируемый в from

-- select name, FIO
-- from Bouquet as b join (select id, FIO
-- 					   from Florist
-- 					   ) as F on b.author = f.id;



