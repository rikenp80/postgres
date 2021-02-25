--psql -U  -h  -d permission_test -f "C:\Users\rpatel3\Documents\GitHub\databases\scripts\LockDownPermissions.sql" -v v_rw_role="test_rw_role" -v v_rw_user="test_rw_user" -v v_ci_role="test_ci_role" -v v_ci_user="test_ci_user" 


--revoke all permissions to the public schema from all roles that have not been explicitly granted permissions
REVOKE ALL ON SCHEMA public FROM PUBLIC;


--create read/write role
CREATE ROLE :v_rw_role;

--create read/write user
CREATE ROLE :v_rw_user WITH LOGIN PASSWORD 'test123';

--assign read/write role to read/write user
GRANT :v_rw_role TO :v_rw_user;


--grant usage permissions to read/write role
GRANT USAGE ON SCHEMA public TO :v_rw_role;

--grant read/write permissions to read/write role
GRANT SELECT ON ALL TABLES IN SCHEMA public TO :v_rw_role;
GRANT UPDATE ON ALL TABLES IN SCHEMA public TO :v_rw_role;
GRANT INSERT ON ALL TABLES IN SCHEMA public TO :v_rw_role;
GRANT DELETE ON ALL TABLES IN SCHEMA public TO :v_rw_role;



--create ci role
CREATE ROLE :v_ci_role;

--create ci user
CREATE ROLE :v_ci_user WITH LOGIN PASSWORD 'test123';

--assign ci role to ci user
GRANT :v_ci_role TO :v_ci_user;


--grant all permissions to ci role
GRANT ALL ON ALL tables IN SCHEMA public TO :v_ci_role;
GRANT ALL ON SCHEMA public TO :v_ci_role;



--ensure that new tables with owner of :v_ci_user or reimagineUser can be modified by :v_ci_role
SET ROLE :v_ci_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO :v_ci_role;

SET ROLE "reimagineUser";
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO :v_ci_role;


--ensure that new tables with owner of :v_ci_user or reimagineUser can be accessed by :v_rw_role
SET ROLE :v_ci_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO :v_rw_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT UPDATE ON TABLES TO :v_rw_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT INSERT ON TABLES TO :v_rw_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT DELETE ON TABLES TO :v_rw_role;

SET ROLE "reimagineUser";
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO :v_rw_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT UPDATE ON TABLES TO :v_rw_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT INSERT ON TABLES TO :v_rw_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT DELETE ON TABLES TO :v_rw_role;
