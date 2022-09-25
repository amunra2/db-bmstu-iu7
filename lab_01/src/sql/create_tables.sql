CREATE TABLE if not exists Server
(
    id          serial PRIMARY KEY,
    name        varchar(255),
    owner       varchar(255),
    ip          varchar(16),
    max_players serial,
    version     varchar(8),
    create_date varchar(16)
);


CREATE TABLE if not exists World 
(
    id                serial PRIMARY KEY,
    name              varchar(255),
    type              varchar(30),
    mode              varchar(30),
    seed              varchar(100) UNIQUE,
    cheats_allowed    bool
);


CREATE TABLE if not exists Player 
(
    id        serial PRIMARY KEY,
    nickname  varchar(255),
    password  varchar(25),
    status    varchar(20),
    hours_all serial,
    email     varchar(100) UNIQUE,
    age       int,
    is_admin  bool,
    friend_id serial
);


CREATE TABLE if not exists Website
(
    id            serial PRIMARY KEY,
    player_id     serial,
    world_id      serial,
    server_id     serial,
    hours         int
);
