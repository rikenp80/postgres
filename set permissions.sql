--revoke all permissions to the public schema from all roles that have not been explicitly granted permissions
REVOKE ALL ON SCHEMA public FROM PUBLIC;


--create read/write role
CREATE ROLE test_permission_rw_role;

--create read/write user
CREATE ROLE test_permission_rw_user WITH LOGIN PASSWORD 'test123';

--assign read/write role to read/write user
GRANT test_permission_rw_role TO test_permission_rw_user;


--grant usage permissions to read/write role
GRANT USAGE ON SCHEMA public TO test_permission_rw_role;

--grant read/write permissions to read/write role
GRANT SELECT ON ALL TABLES IN SCHEMA public TO test_permission_rw_role;
GRANT UPDATE ON ALL TABLES IN SCHEMA public TO test_permission_rw_role;
GRANT INSERT ON ALL TABLES IN SCHEMA public TO test_permission_rw_role;
GRANT DELETE ON ALL TABLES IN SCHEMA public TO test_permission_rw_role;



--create ci role
CREATE ROLE test_permission_ci_role;

--create ci user
CREATE ROLE test_permission_ci_user WITH LOGIN PASSWORD 'test123';

--assign ci role to ci user
GRANT test_permission_ci_role TO test_permission_ci_user;


--grant all permissions to ci role
GRANT ALL ON ALL tables IN SCHEMA public TO test_permission_ci_role;
GRANT ALL ON SCHEMA public TO test_permission_ci_role;



--ensure that new tables with owner of test_permission_ci_user or reimagineUser can be modified by test_permission_ci_role
SET ROLE test_permission_ci_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO test_permission_ci_role;

SET ROLE "reimagineUser";
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO test_permission_ci_role;


--ensure that new tables with owner of test_permission_ci_user or reimagineUser can be accessed by test_permission_rw_role
SET ROLE test_permission_ci_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO test_permission_rw_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT UPDATE ON TABLES TO test_permission_rw_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT INSERT ON TABLES TO test_permission_rw_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT DELETE ON TABLES TO test_permission_rw_role;

SET ROLE "reimagineUser";
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO test_permission_rw_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT UPDATE ON TABLES TO test_permission_rw_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT INSERT ON TABLES TO test_permission_rw_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT DELETE ON TABLES TO test_permission_rw_role;
