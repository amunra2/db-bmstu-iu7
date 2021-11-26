-- оконная функция + cte
-- удалить дубли из таблицы

with cte as
(
    select *
    from Player
    union all
    select *
    from Player
),

delete_double as
(
    select *, row_number() over (partition by id) as row_id
    from cte
)


select *
from delete_double
where row_id = 1 and id < 10