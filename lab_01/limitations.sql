ALTER TABLE Server
ALTER COLUMN name SET NOT NULL,
ALTER COLUMN owner SET NOT NULL,
ALTER COLUMN ip SET NOT NULL,
ALTER COLUMN max_players SET NOT NULL,
ALTER COLUMN version SET NOT NULL,
ALTER COLUMN create_date SET NOT NULL,
ADD check (name != ''),
ADD check (owner != ''),
ADD check (max_players >= 10 and max_players <= 10000);


ALTER TABLE World
ALTER COLUMN name SET NOT NULL,
ALTER COLUMN type SET NOT NULL,
ALTER COLUMN mode SET NOT NULL,
ALTER COLUMN seed SET NOT NULL,
ALTER COLUMN cheats_allowed SET NOT NULL,
ADD check (name != '');


ALTER TABLE Player
ALTER COLUMN nickname SET NOT NULL,
ALTER COLUMN password SET NOT NULL,
ALTER COLUMN status SET NOT NULL,
ALTER COLUMN hours_all SET NOT NULL,
ALTER COLUMN email SET NOT NULL,
ALTER COLUMN age SET NOT NULL,
ALTER COLUMN is_admin SET NOT NULL,
ADD FOREIGN KEY (friend_id) REFERENCES Player(id),
ADD check (nickname != ''),
ADD check (email != ''),
ADD check (age >= 10 and age <= 70),
ADD check (hours_all >= 0 and hours_all <= 100);


ALTER TABLE Website
ALTER COLUMN hours SET NOT NULL,
ADD FOREIGN KEY (player_id) REFERENCES Player(id),
ADD FOREIGN KEY (world_id) REFERENCES World(id),
ADD FOREIGN KEY (server_id) REFERENCES Server(id);