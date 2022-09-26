-- хранимые процедуры + метаданные
-- вывести информацию о базе данных по ее имени


create or replace procedure get_database_info(name_db varchar) as
$$
declare
    database_id integer;
    data_collade varchar;
    data_lastsysoid varchar;
begin
    select pg.oid, pg.datcollate, pg.datlastsysoid
    from pg_database as pg
    where pg.datname like name_db
    into database_id, data_collade, data_lastsysoid;
	
	raise notice 'Database: name - %, id - %, collade - %, lastsysold - %', name_db, database_id, data_collade, data_lastsysoid;
end;
$$ language plpgsql;


call get_database_info('db_labs')
