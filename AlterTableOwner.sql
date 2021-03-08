DO $$
DECLARE
	r record;
	v_new_owner varchar := 'reimagineUser';
BEGIN
    FOR r IN 
        select 'ALTER TABLE "' || tablename || '" OWNER TO "' || v_new_owner || '";' AS a
		from pg_tables
		where tableowner not in ('rdsadmin', v_new_owner)
    LOOP
		EXECUTE r.a;
        raise notice '%', r.a;
    END LOOP;
	
END$$;
