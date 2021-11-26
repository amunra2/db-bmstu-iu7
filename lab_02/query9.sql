-- case
-- имя мира и его режим игры с переводом

select name, mode,
    case mode
        when 'survival' then 'выживание'
        when 'creative' then 'креатив'
        when 'hardcore' then 'хардкор'
        when 'spectator' then 'наблюдатель'
        when 'adventure' then 'приключение'
        else 'неопределенный режим игры'
    end as translation
from World
order by mode
