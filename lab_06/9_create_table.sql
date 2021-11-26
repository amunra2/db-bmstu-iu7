-- создать новую сущность
-- копия таблицы серверов


create temp table if not exists server_copy
(
    id          serial PRIMARY KEY,
    name        varchar(255),
    owner       varchar(255),
    ip          varchar(16),
    max_players serial,
    version     varchar(8),
    create_date varchar(16)
);


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
