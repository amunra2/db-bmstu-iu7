-- delete
-- удалить записи после 1000, где кол-во игроков равно 900 

delete from Server
where id in (select id
          	 from Server
          	 where id > 1000 and max_players = 900)