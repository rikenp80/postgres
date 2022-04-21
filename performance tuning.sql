SELECT state, query_start, backend_start, * FROM pg_stat_activity
WHERE usename = 'jobs_ci_user'
order by query_start desc


select queryid,
query,
calls,
round(total_time/1000) total_time_secs,
min_time, max_time, mean_time
from pg_stat_statements order by total_time desc limit 10;

select * from pg_stat_statements where query like '%DELETE FROM "task-manager"."job"%' order by total_time desc limit 10;

select calls from pg_stat_statements where queryid = '8835773289793569333';
SELECT pg_sleep(60);
select calls from pg_stat_statements where queryid = '8835773289793569333';




CREATE  INDEX ix_hangfire_job_expireat ON "task-manager"."job"(expireat) WITH (fillfactor = 90);
drop  INDEX ix_hangfire_job_stateid ON "task-manager"."job"(stateid) WITH (fillfactor = 90);


select query, calls, total_time, mean_time from pg_stat_statements order by total_time desc limit 10;


select count(*) from "task-manager"."jobparameter"
select * from "task-manager"."jobparameter" limit 100;

select count(*) from "task-manager"."job" 
WHERE "id" IN (
    SELECT "id" 
    FROM "task-manager"."job" 
    WHERE "expireat" < NOW() AT TIME ZONE $1 
    LIMIT $2
)


explain
DELETE FROM "task-manager"."job" 
WHERE "expireat" < NOW() AT TIME ZONE $1