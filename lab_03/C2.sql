-- триггер INSTEAD OF UPDATE
-- выводит информацию об обновлении при Update таблицы World

create or replace function check_update_player()
returns trigger as
$$
begin
    if new.mode not in ('survival', 'creative', 'hardcore', 'spectator', 'adventure') then
        raise notice 'Update: mode % is unknown', new.mode;

        return null;
    else
        raise notice 'Update: World was successfully updated';

        update World
        set mode = new.mode
		where id = new.id;

        return new;
	end if;
end;
$$ language plpgsql;


drop view world_view;

create view world_view as
select * 
from World
order by id
limit 23;

create trigger world_update instead of update on world_view
for each row execute procedure check_update_player();


update world_view
set mode = 'creative'
where id = 2;

select * 
from world_view
where id = 2

