-- агрегатная функция
-- кол-во миров, в которых установлен мод - 'creative'


select count(mode) as creatives
from World
where mode = 'creative'