-- Действия над json

-- 1) Извлечь фрагмент json документа


-- Из task3.sql
drop table if exists player_json;

create temp table player_json
(
    info jsonb
);


insert into player_json(info) values
('{"id": 1, "name": "Vanya", "age": 20, "game": {"game_name": "minecraft", "hours": 500, "playing_from": 2010}}'),
('{"id": 2, "name": "Misha", "age": 20, "game": {"game_name": "warcraft", "hours": 1000, "playing_from": 2011}}'),
('{"id": 3, "name": "Kirill", "age": 19, "game": {"game_name": "fifa", "hours": 300, "playing_from": 2015}}'),
('{"id": 4, "name": "Marina", "age": 20, "game": {"game_name": "naruto", "hours": 1111, "playing_from": 2017}}'),
('{"id": 5, "name": "Regina", "age": 20, "game": {"game_name": "sims", "hours": 5000, "playing_from": 2001}}'),
('{"id": 6, "name": "Gadzhi", "age": 20, "game": {"game_name": "dota2", "hours": 1000, "playing_from": 2019}}');



select info->'name' as name, info->'game' as game
from player_json


-- 2) Извлечь значения конкретных узлов

select info->'name' as name, info->'game'->'game_name' as game_name, info->'game'->'hours' as hours
from player_json


-- 3) Проверить, существует ли узел или атрибут

create or replace function is_key_exists(info jsonb, key varchar) returns bool as
$$
begin
    return (info->key) is not null;
end;
$$ language plpgsql;


select is_key_exists(player_json.info, 'name')
from player_json;


-- 4) Изменить json документ

update player_json
set info = info || '{"age": 23}'::jsonb
where (info->>id)::int = 1;


-- 5) Разделить json документ на несколько строк по узлам

drop table if exists player_json;

create temp table player_json
(
    info jsonb
);


insert into player_json(info) values
('[
    {"id": 1, "name": "Vanya", "age": 20, "game": {"game_name": "minecraft", "hours": 500, "playing_from": 2010}},
    {"id": 2, "name": "Misha", "age": 20, "game": {"game_name": "warcraft", "hours": 1000, "playing_from": 2011}},
    {"id": 3, "name": "Kirill", "age": 19, "game": {"game_name": "fifa", "hours": 300, "playing_from": 2015}},
    {"id": 4, "name": "Marina", "age": 20, "game": {"game_name": "naruto", "hours": 1111, "playing_from": 2017}},
    {"id": 5, "name": "Regina", "age": 20, "game": {"game_name": "shararam", "hours": 99 123, "playing_from": 2001}},
    {"id": 6, "name": "Gadzhi", "age": 20, "game": {"game_name": "dota2", "hours": 1000, "playing_from": 2019}}
]');


select *
from player_json;


select jsonb_array_elements(info::jsonb)
from player_json