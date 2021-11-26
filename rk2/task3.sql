-- информация об индексах текущей таблицы

create or replace procedure get_db_indexes(db_name varchar, table_name varchar)
as $$
declare
	curr_ind record;
begin
	select schemaname, indexname, indexdef
	from pg_indexes
	where tablename = table_name
	into curr_ind;
	
	raise notice 'Schema name: %, Index name: %, Index definition: %', 
		curr_ind.schemaname, curr_ind.indexname, curr_ind.indexdef;
end;
$$ language plpgsql;


call get_db_indexes('rk_prep', 'florist');


-- удалить триггеры

-- создать триггер
create or replace function update_info()
returns trigger as
$$
begin
    raise notice 'Update: Information was successfully updated';
    return new;
end;
$$ language plpgsql;


create trigger update_trigger after update on cf
for row execute procedure update_info();


-- удалить триггеры

create or replace procedure del_triggers() as
$$
declare
	deleted int;
	trigger_rec record;
	
	trig_name varchar;
	trig_table varchar;
begin
	select count(tgname)
	from pg_trigger
	where tgisinternal = 'false'
	into deleted;
	
	raise notice 'Deleted count = %', deleted;
	
	for trigger_rec in (select tgname, tablename from pg_tables, pg_trigger where schemaname = 'public' and tgisinternal = 'false') loop
		trig_name = trigger_rec.tgname;
		trig_table = trigger_rec.tablename;
		
--    		raise notice '%, %', trig_name, trig_table;

   		execute format('drop trigger if exists %I on %I', trig_name, trig_table);
	end loop;
end;
$$ language plpgsql;


call del_triggers();


-- вывести список всех ограничений

create or replace procedure show_constraints(name_table varchar) as
$$
declare
	cur_constraint record;
 
begin 
	for cur_constraint in 
			(select pgc.conname as constraint_name,
				   ccu.table_schema as table_schema,
				   ccu.column_name, pg_get_constraintdef(pgc.oid) as definition
			from pg_constraint pgc
			join pg_namespace nsp on nsp.oid = pgc.connamespace
			join pg_class  cls on pgc.conrelid = cls.oid
			left join information_schema.constraint_column_usage ccu
					  on pgc.conname = ccu.constraint_name
					  and nsp.nspname = ccu.constraint_schema
			where contype ='c' and ccu.table_name = name_table and pg_get_constraintdef(pgc.oid) like '%~~%') loop
 
		raise notice '%, %, %, %', cur_constraint.constraint_name, cur_constraint.table_schema, 
									cur_constraint.column_name, cur_constraint.definition;
 
	end loop;
end;
$$ language plpgsql;
 
 
call show_constraints('player');

-- вывести информацию о функциях + количество с ufn

-- where proname like 'ufn%'

create or replace procedure count_funcs() as
$$
declare
	cnt int;
	
	func_def record;
	
begin
	select count(proname)
	from pg_proc
-- 	where proname like 'ufn%'
	into cnt;
	
	raise notice 'Count = %', cnt; 
	
	for func_def in (select oid, proname from pg_proc) loop
		raise notice '%, %', func_def.proname, 
						pg_get_functiondef(func_def.oid);
						
	end loop;
end;
$$ language plpgsql;
	

call count_funcs();
