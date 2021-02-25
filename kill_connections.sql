select pg_terminate_backend(pg_stat_activity.pid)
from pg_stat_activity
where datname = 'test_permission';
