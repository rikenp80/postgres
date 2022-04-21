pg_dump -h reimagine-prod-canada.cluster-ro-ckrmvhnrbxg7.ca-central-1.rds.amazonaws.com -U "reimagineUser" -s addresses > "C:\Users\rpatel3\Documents\dumps\prod_dumps_20210830\addresses.dump"

select pg_terminate_backend(pid) from pg_stat_activity where datname = 'addresses';
drop database addresses;
create database addresses;

psql -h reimagine-demo-canada.cluster-cmfqyg6jqm4p.ca-central-1.rds.amazonaws.com -U reimagineUser -d addresses < "C:\Users\rpatel3\Documents\dumps\prod_dumps_20210830\addresses.dump"



pg_dump -h reimagine-dev-canada.cluster-ro-c514w15qevsg.ca-central-1.rds.amazonaws.com -U "reimagineUser" -d addresses > "C:\Users\rpatel3\Documents\dumps\addresses.dump"
pg_dump -h reimagine-prod-canada.cluster-ro-ckrmvhnrbxg7.ca-central-1.rds.amazonaws.com -U "reimagineUser" -s config > "C:\Users\rpatel3\Documents\dumps\prod_dumps_20210830\config.dump"
pg_dump -h reimagine-prod-canada.cluster-ro-ckrmvhnrbxg7.ca-central-1.rds.amazonaws.com -U "reimagineUser" -s configuration_can > "C:\Users\rpatel3\Documents\dumps\prod_dumps_20210830\configuration_can.dump"
pg_dump -h reimagine-prod-canada.cluster-ro-ckrmvhnrbxg7.ca-central-1.rds.amazonaws.com -U "reimagineUser" -s customer > "C:\Users\rpatel3\Documents\dumps\prod_dumps_20210830\customer.dump"
pg_dump -h reimagine-prod-canada.cluster-ro-ckrmvhnrbxg7.ca-central-1.rds.amazonaws.com -U "reimagineUser" -s identity > "C:\Users\rpatel3\Documents\dumps\prod_dumps_20210830\identity.dump"
pg_dump -h reimagine-prod-canada.cluster-ro-ckrmvhnrbxg7.ca-central-1.rds.amazonaws.com -U "reimagineUser" -s jobs > "C:\Users\rpatel3\Documents\dumps\prod_dumps_20210830\jobs.dump"
pg_dump -h reimagine-prod-canada.cluster-ro-ckrmvhnrbxg7.ca-central-1.rds.amazonaws.com -U "reimagineUser" -s notifications > "C:\Users\rpatel3\Documents\dumps\prod_dumps_20210830\notifications.dump"
pg_dump -h reimagine-prod-canada.cluster-ro-ckrmvhnrbxg7.ca-central-1.rds.amazonaws.com -U "reimagineUser" -s orders > "C:\Users\rpatel3\Documents\dumps\prod_dumps_20210830\orders.dump"




psql -h reimagine-demo-canada.cluster-cmfqyg6jqm4p.ca-central-1.rds.amazonaws.com -U reimagineUser -d associate < "C:\Users\rpatel3\Documents\dumps\prod_dumps_20210830\associate.dump"
psql -h reimagine-demo-canada.cluster-cmfqyg6jqm4p.ca-central-1.rds.amazonaws.com -U reimagineUser -d config < "C:\Users\rpatel3\Documents\dumps\prod_dumps_20210830\config.dump"
psql -h reimagine-demo-canada.cluster-cmfqyg6jqm4p.ca-central-1.rds.amazonaws.com -U reimagineUser -d configuration_can < "C:\Users\rpatel3\Documents\dumps\prod_dumps_20210830\configuration_can.dump"
psql -h reimagine-demo-canada.cluster-cmfqyg6jqm4p.ca-central-1.rds.amazonaws.com -U reimagineUser -d customer < "C:\Users\rpatel3\Documents\dumps\prod_dumps_20210830\customer.dump"
psql -h reimagine-demo-canada.cluster-cmfqyg6jqm4p.ca-central-1.rds.amazonaws.com -U reimagineUser -d identity < "C:\Users\rpatel3\Documents\dumps\prod_dumps_20210830\identity.dump"
psql -h reimagine-demo-canada.cluster-cmfqyg6jqm4p.ca-central-1.rds.amazonaws.com -U reimagineUser -d jobs < "C:\Users\rpatel3\Documents\dumps\prod_dumps_20210830\jobs.dump"
psql -h reimagine-demo-canada.cluster-cmfqyg6jqm4p.ca-central-1.rds.amazonaws.com -U reimagineUser -d notifications < "C:\Users\rpatel3\Documents\dumps\prod_dumps_20210830\notifications.dump"
psql -h reimagine-demo-canada.cluster-cmfqyg6jqm4p.ca-central-1.rds.amazonaws.com -U reimagineUser -d orders < "C:\Users\rpatel3\Documents\dumps\prod_dumps_20210830\orders.dump"
