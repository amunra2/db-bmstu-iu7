-- из 3 лабы любую переделать в CLR и вывод в json

drop table if exists tmp_server;


CREATE TABLE if not exists tmp_server
(
    id          serial PRIMARY KEY,
    name        varchar,
    owner       varchar,
    ip          varchar,
    max_players serial,
    version     varchar,
    create_date varchar
);


create or replace function get_servers_by_players(players int)
returns table
(
    id          serial,
    name        varchar,
    owner       varchar,
    ip          varchar,
    max_players serial,
    version     varchar,
    create_date varchar
) 
as $$
    query = '''
        select *
        FROM Server;
            '''

    res = plpy.execute(query)
    
    res_arr = list()

    if res is not None:
        for server in res:
            if server["max_players"] == players:
                res_arr.append(server);

        return res_arr

$$ language plpython3u;

insert into tmp_server
(
    id          serial,
    name        varchar,
    owner       varchar,
    ip          varchar,
    max_players serial,
    version     varchar,
    create_date varchar
)
select *
from get_servers_by_players(10);


-- В psql
\t
\a

\o temp_server.json
select row_to_json(s) from tmp_server as s;



