psql -U reimagineUser -h reimagine-uat-canada.cluster-cbmqdqu3rmoo.ca-central-1.rds.amazonaws.com -d customer -c "CREATE SCHEMA """task-manager""" AUTHORIZATION """reimagineUser""";"


psql -U reimagineUser -h reimagine-uat-canada.cluster-cbmqdqu3rmoo.ca-central-1.rds.amazonaws.com -d postgres -f "C:\Users\rpatel3\Documents\GitHubNew\databases\scripts\SetPermissions.sql" ^
-v v_rw_role="customer_readwrite" ^
-v v_rw_user="customer" ^
-v v_ci_user="customer_ci_user" ^
-v v_read_role="customer_readonly" ^
-v v_dbname="customer" ^
-v v_schema="task-manager