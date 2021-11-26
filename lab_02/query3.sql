-- предикат like
-- название сервера и никнейм владельца сервера, который был открыт на версии 1.16

select name, owner, version
from Server
where version like '1.16%'
