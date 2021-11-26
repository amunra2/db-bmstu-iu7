-- создание временной локальной таблицы
-- никнейм игрока, отсортированные по алфавиту, в новую локальную таблицу

select nickname 
into tmp_table
from Player
order by nickname