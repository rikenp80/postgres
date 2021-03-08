--psql -U -h  -d  -f "C:\Users\rpatel3\Documents\GitHub\databases\scripts\LockDownPermissions.sql" -v v_rw_role="" -v v_rw_user="" -v v_ci_user="" -v v_dbname=""

\c :v_dbname

REVOKE ALL ON DATABASE :"v_dbname" FROM :"v_rw_role";
REVOKE ALL ON DATABASE :"v_dbname" FROM :"v_rw_user";
REVOKE ALL ON DATABASE :"v_dbname" FROM :"v_ci_role";
REVOKE ALL ON DATABASE :"v_dbname" FROM :"v_ci_user";

REVOKE ALL ON SCHEMA public FROM :"v_rw_role";
REVOKE ALL ON SCHEMA public FROM :"v_rw_user";
REVOKE ALL ON SCHEMA public FROM :"v_ci_role";
REVOKE ALL ON SCHEMA public FROM :"v_ci_user";


REVOKE ALL ON ALL TABLES IN SCHEMA public FROM :"v_rw_role";
REVOKE ALL ON ALL TABLES IN SCHEMA public FROM :"v_rw_user";
REVOKE ALL ON ALL TABLES IN SCHEMA public FROM :"v_ci_role";
REVOKE ALL ON ALL TABLES IN SCHEMA public FROM :"v_ci_user";

REVOKE ALL ON ALL SEQUENCES IN SCHEMA public FROM :"v_rw_role";
REVOKE ALL ON ALL SEQUENCES IN SCHEMA public FROM :"v_rw_user";
REVOKE ALL ON ALL SEQUENCES IN SCHEMA public FROM :"v_ci_role";
REVOKE ALL ON ALL SEQUENCES IN SCHEMA public FROM :"v_ci_user";


ALTER DEFAULT PRIVILEGES IN SCHEMA public REVOKE ALL ON SEQUENCES FROM :"v_rw_role";
ALTER DEFAULT PRIVILEGES IN SCHEMA public REVOKE ALL ON SEQUENCES FROM :"v_rw_user";
ALTER DEFAULT PRIVILEGES IN SCHEMA public REVOKE ALL ON SEQUENCES FROM :"v_ci_role";
ALTER DEFAULT PRIVILEGES IN SCHEMA public REVOKE ALL ON SEQUENCES FROM :"v_ci_user";

ALTER DEFAULT PRIVILEGES IN SCHEMA public REVOKE ALL ON TABLES FROM :"v_rw_role";
ALTER DEFAULT PRIVILEGES IN SCHEMA public REVOKE ALL ON TABLES FROM :"v_rw_user";
ALTER DEFAULT PRIVILEGES IN SCHEMA public REVOKE ALL ON TABLES FROM :"v_ci_role";
ALTER DEFAULT PRIVILEGES IN SCHEMA public REVOKE ALL ON TABLES FROM :"v_ci_user";



SET ROLE :"v_rw_role";
DROP OWNED BY :"v_rw_role";

SET ROLE :"v_rw_user";
DROP OWNED BY :"v_rw_user";

SET ROLE :"v_ci_role";
DROP OWNED BY :"v_ci_role";

SET ROLE :"v_ci_user";
DROP OWNED BY :"v_ci_user";

RESET ROLE;


--drop existing roles
DROP ROLE :"v_rw_role";
DROP ROLE :"v_rw_user";
DROP ROLE :"v_ci_role";
DROP ROLE :"v_ci_user";


--revoke all permissions to the public schema from all roles that have not been explicitly granted permissions
REVOKE ALL ON SCHEMA public FROM PUBLIC;



--create read/write role
CREATE ROLE :"v_rw_role";

--create read/write user
CREATE ROLE :"v_rw_user" WITH LOGIN PASSWORD 'test123';

--assign read/write role to read/write user
GRANT :"v_rw_role" TO :"v_rw_user";


--grant usage permissions to read/write role
GRANT USAGE ON SCHEMA public TO :"v_rw_role";

--grant read/write permissions to read/write role
GRANT SELECT ON ALL TABLES IN SCHEMA public TO :"v_rw_role";
GRANT UPDATE ON ALL TABLES IN SCHEMA public TO :"v_rw_role";
GRANT INSERT ON ALL TABLES IN SCHEMA public TO :"v_rw_role";
GRANT DELETE ON ALL TABLES IN SCHEMA public TO :"v_rw_role";




--create ci user
CREATE ROLE :"v_ci_user" WITH LOGIN PASSWORD 'test123';


--grant all permissions to ci role
GRANT ALL ON ALL tables IN SCHEMA public TO :"v_ci_user";
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO :"v_ci_user";
GRANT ALL ON SCHEMA public TO :"v_ci_user";



--ensure that new tables with owner of :"v_ci_user" or reimagineUser can be accessed by :"v_rw_role"
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO :"v_rw_role";
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT UPDATE ON TABLES TO :"v_rw_role";
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT INSERT ON TABLES TO :"v_rw_role";
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT DELETE ON TABLES TO :"v_rw_role";

SET ROLE :"v_ci_user";
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO :"v_rw_role";
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT UPDATE ON TABLES TO :"v_rw_role";
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT INSERT ON TABLES TO :"v_rw_role";
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT DELETE ON TABLES TO :"v_rw_role";

RESET ROLE;

select 'ALTER TABLE "' || t.tablename || '" OWNER TO :"v_ci_user;' from  pg_tables t where t.tableowner not in ('rdsadmin', ':"v_ci_user"');
