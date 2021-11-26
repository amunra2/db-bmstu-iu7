-- информация об индексах указанной таблицы


create or replace procedure get_db_indexes(db_name varchar, table_name varchar)
as $$
declare
	curr_record record;
begin
	select *
	from pg_indexes
	where tablename = table_name;
 	into curr_record;
	
 	raise notice 'Schema name: %, Index name: %, Index definition: %', 
 		curr_record.schemaname, curr_record.indexname, curr_record.indexdef;
end;
$$ language plpgsql;

call get_db_indexes('db_labs', 'server');


SELECT * FROM pg_catalog.pg_tables;