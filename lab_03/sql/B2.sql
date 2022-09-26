-- рекурсивные хранимые процедуры
-- рекурсивно вывести символы таблицы

drop table if exists Links;

create table if not exists Links
(
    id serial PRIMARY KEY,
    id_on int,
    letter varchar(5)
);

insert into Links(id_on, letter) values
(3, 'a'),
(NULL, 'e'),
(5, 'b'),
(2, 'd'),
(4, 'c');


create or replace procedure recursive_print(id_start integer) as
$$
declare
    next_id integer;
    cur_letter varchar;
begin
    select l.id_on, l.letter
    from Links as l
    where l.id = id_start
    into next_id, cur_letter;
	
	raise notice 'Now letter - %', cur_letter;

    if next_id is NULL then
        raise notice 'End of recursion';
    else
        call recursive_print(next_id);
    end if;
end;
$$ language plpgsql;


call recursive_print(1);

