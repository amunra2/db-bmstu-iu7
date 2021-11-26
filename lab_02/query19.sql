-- update
-- обновить игроку с id = 1 кол-во на мин по таблице

update Player
set hours_all = (select min(hours_all)
                 from Player)
where id = 1