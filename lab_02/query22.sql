-- обобщенные табличные выражения
-- получить набор

with cte
as (select *
    from World)

select *
from cte