/*
psql -U reimagineUser -h reimagine-dev-canada-instance-1-cluster.cluster-c514w15qevsg.ca-central-1.rds.amazonaws.com -d postgres -f "C:\Users\rpatel3\Documents\GitHub\databases\scripts\RecreateDB.sql" -v v_dbname="jobs"
*/


SELECT pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE datname = :'v_dbname';

DROP DATABASE :v_dbname;

CREATE DATABASE :v_dbname;
