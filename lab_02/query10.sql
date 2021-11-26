-- case (поисковой)
-- никнейм игрока и его статус

select nickname,
    case
        when hours_all < 50 then 'обычный игрок'
        else 'игроман'
    end as addiction
from Player