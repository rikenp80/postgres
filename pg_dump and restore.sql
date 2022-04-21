aws s3 cp "s3://pr-cloud-database/dumps/config_BusinessUnit_20210421_183617.dump" "C:\\Users\\rpatel3\\Documents\\dumps\\"


--powershell

pg_dump -h reimagine-uat-canada.cluster-ro-cbmqdqu3rmoo.ca-central-1.rds.amazonaws.com -U "reimagineUser" -c associate > "C:\Users\rpatel3\Documents\dumps\associate.dump"

psql -h reimagine-uat-us-cluster.cluster-c1p7ragy6mmj.us-west-2.rds.amazonaws.com -U reimagineUser -d associate -f "C:\Users\rpatel3\Documents\dumps\associate.dump"


--cmd command

pg_dump -c -t """ShiftPriorityInvitation""" -h reimagine-dev-canada.cluster-c514w15qevsg.ca-central-1.rds.amazonaws.com -U "reimagineUser" orders > "C:\Users\rpatel3\Documents\dumps\orders_ShiftPriorityInvitation_20210722.dump"

psql -h reimagine-dev-canada.cluster-c514w15qevsg.ca-central-1.rds.amazonaws.com -U reimagineUser -d addresses < "C:\Users\rpatel3\Documents\dumps\addresses_country.dump"
