-- Скалярный запрос
-- Количество игроков, которые наиграли более 10 часов 


select count(id)
from Player
where hours_all < 10
