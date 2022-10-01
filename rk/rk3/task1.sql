-- Drop tables
drop table if exists Employes cascade;
drop table if exists EmplActions cascade;


-- Create tables
create table if not exists Employes 
(
    id int primary key,
    fio varchar,
    birth_date date,
    department varchar
);

create table if not exists EmplActions 
(
    e_id int,
    date_pass date,
    weekday varchar,
    time_pass time,
    inout int,
    foreign key (e_id) references Employes(id)
);


-- Insert data
insert into Employes
values
    (1, 'FIO1', '2001-01-01', 'IT'),
    (2, 'FIO2', '2002-02-01', 'IT'),
    (3, 'FIO3', '2003-03-01', 'IT'),
    (4, 'FIO4', '2004-04-01', 'IT'),
    (5, 'FIO5', '2005-05-01', 'IT');



insert into EmplActions
values
    (1, '2021-12-19', 'Monay', '9:20', 1),
    (1, '2021-12-19', 'Monday', '18:30', 2),
    (1, '2021-12-20', 'Sunday', '8:20', 1),
    (1, '2021-12-20', 'Sunday', '17:30', 2),
    (1, '2021-12-18', 'Friday', '11:00', 1),
    (1, '2021-12-18', 'Friday', '19:30', 2),
    (2, '2021-12-19', 'Saturday', '9:20', 1),
    (2, '2021-12-19', 'Saturday', '17:20', 2),
    (2, '2021-12-20', 'Sunday', '8:50', 1),
    (2, '2021-12-20', 'Sunday', '22:40', 2),
    (2, '2021-12-18', 'Friday', '10:35', 1),
    (2, '2021-12-18', 'Friday', '18:40', 2),
	(2, '2021-12-17', 'Friday', '11:10', 1),
    (2, '2021-12-17', 'Friday', '18:40', 2),
    (3, '2020-12-19', 'Thursday', '12:20', 1),
    (3, '2020-12-19', 'Thursday', '18:20', 2),
    (3, '2020-12-20', 'Sunday', '7:30', 1),
    (3, '2020-12-20', 'Sunday', '18:30', 2),
	(3, '2020-12-18', 'Friday', '9:30', 1),
    (3, '2020-12-18', 'Friday', '13:30', 2),
    (4, '2020-12-20', 'Saturday', '6:15', 1),
    (4, '2020-12-20', 'Saturday', '12:45', 2),
    (4, '2020-12-20', 'Sunday', '10:20', 1),
    (4, '2020-12-20', 'Sunday', '17:30', 2),
    (4, '2020-12-18', 'Friday', '7:20', 1),
    (4, '2020-12-18', 'Friday', '18:30', 2),
    (5, '2020-12-18', 'Friday', '9:20', 1),
    (5, '2020-12-18', 'Friday', '19:30', 2);


-- Function
-- Написать скалярную функцию, возвращающую количество сотрудников в возрасте от 18 до
-- 40, выходивших более 3х раз.

create or replace function get_likes_to_exit() returns int as
$$
begin
    return (select count(*)
            from Employes as e
            where ((extract(year from current_date) - extract(year from e.birth_date)) between 18 and 40) and e.id in
				(select id
                 from (select id, inout, count(*)
					   from EmplActions
					   group by id, inout
					   having inout = 2 and count(*) > 3) as tmp));

end;
$$ language plpgsql;


select get_likes_to_exit() as count_left;

