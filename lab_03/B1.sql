-- процедура с параметрами
-- добавить игроков во все сервера определенной версии

create or replace procedure add_max_players(version_to varchar, add_players integer) as
$$
begin
    update Server
    set max_players = max_players + $2
    where version like $1 || '%';
end;
$$ language plpgsql;


call add_max_players('1.17', 10);


select version, max_players
from Server
where version like '1.17%'

