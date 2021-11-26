-- процедура с курсорами
-- информацию об игроках, которые сыграли определенное кол-во часов

create or replace procedure info_about_players_by_hours(start_hours int, end_hours int) as
$$
declare
    cur_player record;
    player_cursor cursor for
        select *
        from Player as p
        where p.hours_all between start_hours and end_hours
		order by p.hours_all;
begin
    open player_cursor;

    loop
        fetch player_cursor into cur_player;
		exit when not found;
        raise notice 'Info - nickname: %, email: %, age: %, hours: %', cur_player.nickname, cur_player.email, cur_player.age, cur_player.hours_all;
    end loop;

    close player_cursor;
end;
$$ language plpgsql;


call info_about_players_by_hours(30, 35);

