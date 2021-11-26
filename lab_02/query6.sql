-- предикат сравнения с ALL
-- ники и макс кол-во игроков

select name, owner, max_players
from Server
where max_players > ALL (select max_players
						 from Server
						 where create_date like '2019%') 