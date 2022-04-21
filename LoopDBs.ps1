cls

$db_instance = "reimagine-prod-us-cluster.cluster-cupaxtoidagf.us-west-2.rds.amazonaws.com"
$db_user = "reimagineUser"
$db_password = "ewrCizIaHNh3gkEVmxJ6R"

$db_connection = "postgresql://" + $db_user + ":" + $db_password + "@" + $db_instance + "/postgres"


$query = "SELECT datname FROM pg_database `
           WHERE datistemplate = false and datname not in ('rdsadmin','postgres')"

$databases = psql --dbname=$db_connection -t -c $query


$loop_query1 = "drop schema pganalyze cascade;"
$loop_query2 = "drop schema datadog cascade;"


foreach ($database in $databases)
{
    if ($database -ne "")
    {
        $db_connection = "postgresql://" + $db_user + ":" + $db_password + "@" + $db_instance + "/" + $database.trim()

        write-output "======= $database ======="

        $query = "\dn"
        $schema = psql --dbname=$db_connection -t -c $query
        $schema


    
        psql --dbname=$db_connection -t -c $loop_query1
        psql --dbname=$db_connection -t -c $loop_query2

        
        $query = "\dn"
        $schema = psql --dbname=$db_connection -t -c $query
        $schema
    }
}
