-- скалярные подзапросы
-- название сервера и его версию, а также количество часов

select name, version,
    (select hours
    from Website
    where Server.id = Website.id)
from Server
