select 	c.oid::regclass as table,
		age(c.relfrozenxid),
		current_setting('autovacuum_freeze_max_age'),
		current_setting('autovacuum_freeze_max_age')::INT8 - age(c.relfrozenxid) as xid_left,
		pg_relation_size(c.oid) as relsize,
		pg_size_pretty(pg_relation_size(oid)) as size,
		*
from pg_class c
where 	c.relkind = 'r'
		and c.relnamespace = 82383
		--and age(c.relfrozenxid)::INT8 > (current_setting('autovacuum_freeze_max_age')::INT8 * 0.9)
	order by 4;
	
select datname, age(datfrozenxid), *
from pg_database
where not datistemplate

select * from pg_stat_activity;	




select count(*) from "task-manager".lock
select xmin, xmax, * from "task-manager".lock where createdate is not null order by createdate desc limit 100

DO $$
BEGIN
    LOOP
		insert into "task-manager".lock values ('aaaa', random()*1000, now());
		commit;
  	END LOOP;	
END$$;