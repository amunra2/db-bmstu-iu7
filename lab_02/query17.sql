-- insert + select
-- добавить строку в таблицу World

insert into Server(name, owner, ip, max_players, version, create_date)
    select name, owner, ip, max_players - 100, version, create_date
    from Server
    where max_players = 1000