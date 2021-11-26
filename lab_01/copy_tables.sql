COPY Player(nickname, password, status, hours_all, email, age, is_admin, friend_id) from '/home/amunra23/studying/sem5/bd/db_bmstu/lab_01/player_info.csv' delimiter ';';

COPY World(name, type, mode, seed, cheats_allowed) from '/home/amunra23/studying/sem5/bd/db_bmstu/lab_01/world_info.csv' delimiter ';';

COPY Server(name, owner, ip, max_players, version, create_date) from '/home/amunra23/studying/sem5/bd/db_bmstu/lab_01/server_info.csv' delimiter ';';

COPY Website(player_id, world_id, server_id, hours) from '/home/amunra23/studying/sem5/bd/db_bmstu/lab_01/website_info.csv' delimiter ';';