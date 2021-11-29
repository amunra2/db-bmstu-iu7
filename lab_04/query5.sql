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




-- create or replace function update_world_type(id int, type varchar) 
-- returns trigger as
-- $$
--     types = ["default", "superflat", "single biome", "large biomes", "caves"]

--     if new.type not in types:
--         plpy.notice("Update: type %s unknown" %(type))

--         return null
--     else:
--         plpy.notice("Update: is succesfull")

--         query = '''
--                 update World
--                 set type = new.type
--                 where id = new.id
--                 '''

--         plpy.execute(query)

--         return new

-- $$ language plpython3u;
