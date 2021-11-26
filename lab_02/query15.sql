-- group by + having
-- сгруппировать сервера, на которых кол-во
-- игроков больше 500 и посчитать кол-во
-- серверов с определенным кол-вом игроков
-- (отсортировано по возрастанию)

select max_players, count(max_players)
from Server
group by max_players
having max_players > 500
order by count(max_players)
