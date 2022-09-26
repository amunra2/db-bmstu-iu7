-- оконные функции
-- ник, статус и возраст игроков, у которых 
-- посчитано среднее кол-во часов для опред возраста

select nickname, status, age, avg(hours_all) over (partition by age) as avg_hours
from Player