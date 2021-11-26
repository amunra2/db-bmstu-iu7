-- рекурсивный запрос
-- вывести буквы в алфавитном порядке

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

select *
from Links;


with recursive RecursiveLetters(id, id_on, letter) as
(
    select id, id_on, letter
    from Links as l
    where l.id = 1
    union all
    select l.id, l.id_on, l.letter
    from Links as l join RecursiveLetters as rec_l on l.id = rec_l.id_on
)

select *
from RecursiveLetters
