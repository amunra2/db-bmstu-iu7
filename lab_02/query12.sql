-- коррелируемый подзапрос
-- никнейм владельца сервера, версия сервера и кол-во часов

select owner, version, hours
from (Website as W join (select id, owner, version
                         from Server
                         where max_players > 50 and version like '1.16.%'
                        ) as S on W.id = S.id) as WS