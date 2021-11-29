-- Агрегатная функция
-- Кол-во игроков, играющих на мирах определнного типа


create or replace function players_by_type(type varchar)
returns int as
$$
    query = '''
        select *
        from ((Player as P join Website as WB on P.id = WB.player_id) as WBP
                join World as W on WBP.world_id = W.id) as WBPW
        where WBPW.type = '%s'
            ''' % (type)

    res = plpy.execute(query)

    playres = 0

    if res is not None:
        for player in res:
            playres += 1

    return playres

$$ language plpython3u;


select type, players_by_type(type)
from World
group by type