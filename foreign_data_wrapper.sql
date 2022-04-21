CREATE EXTENSION postgres_fdw;

--DROP SERVER IF EXISTS uat_associate CASCADE;
CREATE SERVER uat_associate
FOREIGN DATA WRAPPER postgres_fdw
OPTIONS (host 'reimagine-uat-canada.cluster-ro-cbmqdqu3rmoo.ca-central-1.rds.amazonaws.com', port '5432', dbname 'associate');


--DROP USER MAPPING IF EXISTS FOR "reimagineUser" SERVER uat_associate;
CREATE USER MAPPING FOR "reimagineUser"
SERVER uat_associate
OPTIONS (user 'reimagineUser', password '');


--DROP FOREIGN TABLE "Associate";
IMPORT FOREIGN SCHEMA public LIMIT TO ("Associate") FROM SERVER uat_associate INTO public;


