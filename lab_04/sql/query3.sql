-- Определяемая пользователем табличная функция
-- Информация об игроках, играющих на определенной версии

create or replace function players_by_version(version varchar)
returns table(nickname varchar, age int, email varchar, version varchar) as
$$
    query = '''
        select WBPS.nickname, WBPS.age, WBPS.email, WBPS.version
        from ((Player as P join Website as WB on P.id = WB.player_id) as WBP
                join Server as S on WBP.server_id = S.id) as WBPS
        where WBPS.version like '%s'
            ''' % (version)

    res = plpy.execute(query)

    res_table = list()

    if res is not None:
        for player in res:
            res_table.append(player)

    return res_table

$$ language plpython3u;


select *
from players_by_version('1.17%')
