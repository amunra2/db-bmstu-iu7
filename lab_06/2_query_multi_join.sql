-- Запрос с несколькими join
-- Сервера, средний возраст игроков которых меньше 15

select WSP.name, avg(WSP.age)
from ((Server as S join Website as W on S.id = W.server_id) 
	  as WS join Player as P on P.id = WS.player_id) as WSP
group by WSP.name
having avg(WSP.age) < 15
order by avg(WSP.age)