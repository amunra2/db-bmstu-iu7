-- предикат in + вложенный запрос
-- количество часов 1 игрок на 1 сервере на мире, максимальное количество игроков на котором меньше 100

select hours
from Website
where server_id in (select id
				  from Server
				  where max_players < 100)
                  