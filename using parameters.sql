\set v_database 'permission_test'


select pg_terminate_backend(pg_stat_activity.pid)
from pg_stat_activity
where datname = :'v_database';


drop database :v_database;






\set v1  10
SELECT * FROM test1 WHERE col1 = :v1;


\set v1  10
insert into test1 values (:v1);