/*

psql -U reimagineUser -h reimagine-dev-canada-instance-1.c514w15qevsg.ca-central-1.rds.amazonaws.com -d postgres -f "C:\Users\rpatel3\Documents\GitHub\databases\scripts\LockDownPermissions.sql" ^
-v v_rw_role="config_readwrite" ^
-v v_rw_user="config" ^
-v v_ci_role="config_ci" ^
-v v_ci_user="config_ci_user" ^
-v v_read_role="config_readonly" ^
-v v_dbname="config"

*/

\c :v_dbname


--remove existing permissions
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


--drop default permissions
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


--create read only role
CREATE ROLE :"v_read_role";

--assign read role to the all_db_readonly role
GRANT :"v_read_role" to all_db_readonly;

--create ci user
CREATE ROLE :"v_ci_user" WITH LOGIN PASSWORD 'test123';



--grant usage permissions to new roles
GRANT USAGE ON SCHEMA public TO :"v_rw_role";
GRANT USAGE ON SCHEMA public TO :"v_read_role";


--grant read/write permissions to read/write role
GRANT SELECT ON ALL TABLES IN SCHEMA public TO :"v_rw_role";
GRANT UPDATE ON ALL TABLES IN SCHEMA public TO :"v_rw_role";
GRANT INSERT ON ALL TABLES IN SCHEMA public TO :"v_rw_role";
GRANT DELETE ON ALL TABLES IN SCHEMA public TO :"v_rw_role";


--grant read permissions to read role as the reimagineUser 
GRANT SELECT ON ALL TABLES IN SCHEMA public TO :"v_read_role";


--ensure that new tables with owner of :"v_ci_user" or reimagineUser can be accessed by v_rw_role and v_read_role
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO :"v_rw_role";
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT UPDATE ON TABLES TO :"v_rw_role";
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT INSERT ON TABLES TO :"v_rw_role";
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT DELETE ON TABLES TO :"v_rw_role";
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO :"v_read_role";

SET ROLE :"v_ci_user";
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO :"v_rw_role";
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT UPDATE ON TABLES TO :"v_rw_role";
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT INSERT ON TABLES TO :"v_rw_role";
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT DELETE ON TABLES TO :"v_rw_role";
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO :"v_read_role";

RESET ROLE;



--grant all permissions to ci user
GRANT ALL ON ALL tables IN SCHEMA public TO :"v_ci_user";
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO :"v_ci_user";
GRANT ALL ON SCHEMA public TO :"v_ci_user";