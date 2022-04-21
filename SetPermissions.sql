 /*

psql -U reimagineUser -h new-env-dev-canada.cluster-c514w15qevsg.ca-central-1.rds.amazonaws.com -d postgres -f "C:\Users\rpatel3\Documents\GitHubNew\databases\scripts\SetPermissions.sql" ^
-v v_rw_role="config_readwrite" ^
-v v_rw_user="config" ^
-v v_rw_user_password="" ^
-v v_ci_user="config_ci_user" ^
-v v_ci_user_password="" ^
-v v_read_role="config_readonly" ^
-v v_dbname="config" ^
-v v_schema="public"

*/

\c :v_dbname

--create shared roles
CREATE ROLE all_db_readonly;
CREATE ROLE all_db_readwrite;

--create read/write role
CREATE ROLE :"v_rw_role";

--create read/write user
CREATE ROLE :"v_rw_user" WITH LOGIN PASSWORD :'v_rw_user_password';

--assign read/write role to read/write user
GRANT :"v_rw_role" TO :"v_rw_user";

--create read only role
CREATE ROLE :"v_read_role";

--assign read role to the all_db_readonly role
GRANT :"v_read_role" to all_db_readonly;

--create ci user
CREATE ROLE :"v_ci_user" WITH LOGIN PASSWORD :'v_ci_user_password';




--grant usage permissions to new roles
GRANT USAGE ON SCHEMA :"v_schema" TO :"v_rw_role";
GRANT USAGE ON SCHEMA :"v_schema" TO :"v_read_role";


--grant read/write permissions to read/write role
GRANT SELECT ON ALL TABLES IN SCHEMA :"v_schema" TO :"v_rw_role";
GRANT UPDATE ON ALL TABLES IN SCHEMA :"v_schema" TO :"v_rw_role";
GRANT INSERT ON ALL TABLES IN SCHEMA :"v_schema" TO :"v_rw_role";
GRANT DELETE ON ALL TABLES IN SCHEMA :"v_schema" TO :"v_rw_role";


--grant read permissions to read role as the reimagineUser
GRANT SELECT ON ALL TABLES IN SCHEMA :"v_schema" TO :"v_read_role";


--ensure that new tables with owner of :"v_ci_user" or reimagineUser can be accessed by v_rw_role and v_read_role
ALTER DEFAULT PRIVILEGES IN SCHEMA :"v_schema" GRANT SELECT ON TABLES TO :"v_rw_role";
ALTER DEFAULT PRIVILEGES IN SCHEMA :"v_schema" GRANT UPDATE ON TABLES TO :"v_rw_role";
ALTER DEFAULT PRIVILEGES IN SCHEMA :"v_schema" GRANT INSERT ON TABLES TO :"v_rw_role";
ALTER DEFAULT PRIVILEGES IN SCHEMA :"v_schema" GRANT DELETE ON TABLES TO :"v_rw_role";
ALTER DEFAULT PRIVILEGES IN SCHEMA :"v_schema" GRANT SELECT ON TABLES TO :"v_read_role";

SET ROLE :"v_ci_user";
ALTER DEFAULT PRIVILEGES IN SCHEMA :"v_schema" GRANT SELECT ON TABLES TO :"v_rw_role";
ALTER DEFAULT PRIVILEGES IN SCHEMA :"v_schema" GRANT UPDATE ON TABLES TO :"v_rw_role";
ALTER DEFAULT PRIVILEGES IN SCHEMA :"v_schema" GRANT INSERT ON TABLES TO :"v_rw_role";
ALTER DEFAULT PRIVILEGES IN SCHEMA :"v_schema" GRANT DELETE ON TABLES TO :"v_rw_role";
ALTER DEFAULT PRIVILEGES IN SCHEMA :"v_schema" GRANT SELECT ON TABLES TO :"v_read_role";

RESET ROLE;



--grant all permissions to ci user
GRANT ALL ON ALL TABLES IN SCHEMA :"v_schema" TO :"v_ci_user";
GRANT ALL ON ALL SEQUENCES IN SCHEMA :"v_schema" TO :"v_ci_user";
GRANT ALL ON SCHEMA :"v_schema" TO :"v_ci_user";



--output generated passwords
\echo '\n-----------------------------------------------------------------------------------'
\echo 'db:' :v_dbname, 'user:' :v_rw_user, 'password:' :v_rw_user_password
\echo 'db:' :v_dbname, 'user:' :v_ci_user, 'password:' :v_ci_user_password
\echo '-----------------------------------------------------------------------------------\n'