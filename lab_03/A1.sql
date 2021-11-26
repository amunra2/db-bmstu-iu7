-- скалярные функции
-- считает средний возраст игроков, которые наиграли более 15 часов

create or replace function get_avg_age() returns float as
$$
begin
    return (select avg(age)
            from Player
            where hours_all > 15);
end;
$$ language plpgsql;


select get_avg_age() as AvgAge
