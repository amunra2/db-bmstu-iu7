-- многооператорные табличные функции
-- получить по id игрока сервера, на которых он играл и сколько часов (используя временную таблицу)

create or replace function get_player_info(id_player integer)
returns table(id integer, nickname varchar, status varchar, email varchar, server_name varchar, hours_this_server int) as
$$
begin
    drop table player_info;

    create temp table player_info
    (
        id int,
        nickname varchar,
        status varchar,
        email varchar,
        server_name varchar,
        hours_this_server int
    );

    insert into player_info(id, nickname, status, email, server_name, hours_this_server)
        select WSP.player_id, WSP.nickname, WSP.status, WSP.email, WSP.name, WSP.hours_all
        from ((Player as P join Website as W on P.id = W.player_id) as WP join Server as S on WP.server_id = S.id) as WSP
        where WSP.player_id = id_player;


    return query
    
    select *
    from player_info;
end;
$$ language plpgsql;


select *
from get_player_info(15)

