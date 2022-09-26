-- определить на каком сервере в среднем наиболее 
-- старшие игроки (средний возраст и отсортирвать)

select WSP.name, avg(WSP.age)
from ((Server as S join Website as W on S.id = W.server_id) 
	  as WS join Player as P on P.id = WS.player_id) as WSP
group by WSP.name
order by avg(WSP.age)