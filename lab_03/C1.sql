-- триггер AFTER
-- выводит информацию об обновлении при Update таблицы Player

create or replace function update_info()
returns trigger as
$$
begin
    raise notice 'Update: Information was successfully updated';
    return new;
end;
$$ language plpgsql;


-- create trigger update_trigger after update on Player
-- for row execute procedure update_info();


update Player
set hours_all = hours_all - 1
where hours_all = 1;
