-- предикат сравнения
-- никнеймы и часы игроков, которые наиграли менее 5 часов

select nickname, hours
from Player
where hours < 5