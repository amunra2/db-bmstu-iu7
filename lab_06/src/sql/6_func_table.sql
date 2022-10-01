-- табличные функции
-- вернуть все сервера, запущенные в определенном году

create or replace function get_servers_by_year(year varchar) 
returns table(id integer, name varchar, owner varchar, ip varchar, max_players integer, version varchar, create_date varchar) as
$$
begin
  	return query
	select *
	from Server as S
	where S.create_date like $1 || '%' and S.id < 100;
end;
$$ language plpgsql;


select *
from get_servers_by_year('2019')