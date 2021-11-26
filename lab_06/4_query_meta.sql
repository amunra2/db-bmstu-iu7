-- запрос к метаданным
-- получить список таблиц 


select *
from information_schema.tables
where table_schema like 'public'