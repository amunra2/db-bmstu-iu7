-- Сокращенный путь может не сработать. Тогда необходимо написать полный путь от корня

COPY Player(nickname, password, status, hours_all, email, age, is_admin, friend_id) from '~/data/player_info.csv' delimiter ';';

COPY World(name, type, mode, seed, cheats_allowed) from '~/data/world_info.csv' delimiter ';';

COPY Server(name, owner, ip, max_players, version, create_date) from '~/data/server_info.csv' delimiter ';';

COPY Website(player_id, world_id, server_id, hours) from '~/data/website_info.csv' delimiter ';';