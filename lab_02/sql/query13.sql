-- тройной вложенный подзапрос
-- вывести всю информацию о мирах, 
-- на серверах которых, созданных в 2019 году
-- максимальное кол-во игроков

select *
from World
where id in (select world_id
             from Website
             where server_id in (select id
                                 from Server
                                 where max_players > ALL(select max_players
                                                         from Server
                                                         where create_date like '2019%')))
