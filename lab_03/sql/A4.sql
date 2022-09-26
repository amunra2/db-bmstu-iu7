-- рекурсивные табличные функции
-- рекурсивно вывести символы таблицы

create or replace function get_recursive_print(id_start integer) 
returns table(id integer, id_on integer, letter varchar) as
$$
begin
    drop table if exists Links;

    create table if not exists Links
    (
        id serial PRIMARY KEY,
        id_on int,
        letter varchar(5)
    );

    insert into Links(id_on, letter) values
    (3, 'a'),
    (6, 'e'),
    (5, 'b'),
    (2, 'd'),
    (4, 'c');
	
	return query

    with recursive RecursiveLetters(id, id_on, letter) as
    (
        select l.id, l.id_on, l.letter
        from Links as l
        where l.id = $1
        union all
        select l.id, l.id_on, l.letter
        from Links as l join RecursiveLetters as rec_l on l.id = rec_l.id_on
    )
	
    select *
    from RecursiveLetters;
end;
$$ language plpgsql;


select *
from get_recursive_print(1)

