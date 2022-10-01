-- Определяемый пользователем тип данных
-- На определенной версии получить всех игроков и узнать о них
-- их никнейм, тип мира, на которых они играют, и версию

create type player_info_type as
(
    nickname varchar,
    type varchar,
    version varchar
);


create or replace function players_info_all_by_version(version varchar)
returns setof player_info_type as
$$
    query = '''
        select WBPSW.nickname, WBPSW.type, WBPSW.version
        from (((Player as P join Website as WB on P.id = WB.player_id) as WBP
                join Server as S on WBP.server_id = S.id) as WBPS
                join World as W on WBPS.world_id = W.id) as WBPSW
        where WBPSW.version like '%s'
            ''' % (version)

    res = plpy.execute(query)

    if res is not None:
        return res

$$ language plpython3u;


select *
from players_info_all_by_version('1.17%')