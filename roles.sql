select *
from pg_roles
where rolname like '%@%'
order by upper(rolname)