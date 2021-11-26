-- вставка в новую таблицу
-- вставить первые 15 серверов


insert into server_copy(name, owner, ip, max_players, version, create_date)
select name, owner, ip, max_players, version, create_date
from Server
where id <= 15
order by id;


select *
from server_copy




