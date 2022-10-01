-- Загрзуить файл в таблицу


drop table if exists world_json;

create temp table world_json
(

    id                serial PRIMARY KEY,
    name              varchar(255) not null,
    type              varchar(30) not null,
    mode              varchar(30) not null,
    seed              varchar(100) not null,
    cheats_allowed    bool
);


drop table if exists json_table;

create temp table json_table
(
    data jsonb
);


copy json_table from 'data/world.json';


insert into world_json(id, name, type, mode, seed, cheats_allowed)
select (data->>'id')::int, data->'name', data->'type', data->'mode', data->'seed', (data->>'cheats_allowed')::bool
from json_table;


select *
from world_json;




