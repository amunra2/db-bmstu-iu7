-- group by
-- сгруппировать миры по паре мод - тип

select mode, type
from World
group by mode, type
