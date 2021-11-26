-- предикат between
-- название сервера и версия игры, которые были открыты в первой половине 2019 года

select name, version
from Server
where create_date between '2019-01-01' and '2019-06-01'