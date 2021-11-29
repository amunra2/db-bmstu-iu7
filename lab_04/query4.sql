-- Хранимая процедура
-- Обновить информацию о типе мира по id 


create or replace procedure update_world_type_by_id(id int, type varchar) as 
$$
    prepare = plpy.prepare("update World set type = $1 where id = $2", ["varchar", "int"])

    plpy.execute(plan, [type, id])
$$ language plpython3u;

call update_world_type_by_id(23, 'default');

select *
from World
where id = 23


