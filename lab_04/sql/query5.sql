-- Определяемый пользователем тип данных
-- Новое сообщение при обновлении таблицы World


create or replace function update_world_type() 
returns trigger as
$$
    plpy.notice("Updated mode for table World")

$$ language plpython3u;


create trigger update_trigger_mode after update on World
for row execute procedure update_world_type();


update World
set type = 'default'
where id = 23;

select id, type
from World
where id = 23
