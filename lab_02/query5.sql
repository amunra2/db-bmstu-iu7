-- предикат exists + вложенный запрос
-- название и тип мира, на которых данный игрок на данном сервере сыграл менее 10 часов

select name, type
from World
where exists (select hours
 			 from Website
 			 where World.id = Website.world_id and hours < 10)
