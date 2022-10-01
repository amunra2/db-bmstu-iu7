-- Создать таблицу с данными json + заполнить ее 
-- с помощью insert

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
('{"id": 5, "name": "Regina", "age": 20, "game": {"game_name": "shararam", "hours": 9009, "playing_from": 2001}}'),
('{"id": 6, "name": "Gadzhi", "age": 20, "game": {"game_name": "dota2", "hours": 1000, "playing_from": 2019}}');


select *
from player_json