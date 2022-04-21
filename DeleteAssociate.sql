--psql -U reimagineUser -h reimagine-prod-canada.cluster-ckrmvhnrbxg7.ca-central-1.rds.amazonaws.com -d postgres -f "C:\Users\rpatel3\Documents\GitHub\databases\scripts\DeleteAssociate.sql" -v v_cognitouserid="c066bd09-f2ac-4177-b3fd-8320aff06cea"

\x

\c associate
select * from "Associate" where "CognitoUserId" = :'v_cognitouserid';
delete from "Associate" where "CognitoUserId" = :'v_cognitouserid';

\c jobs
select * from "Associate" where "CognitoUserId" = :'v_cognitouserid';
delete from "Associate" where "CognitoUserId" = :'v_cognitouserid';

\c orders
select * from "Associate" where "CognitoUserId" = :'v_cognitouserid';
delete from "Associate" where "CognitoUserId" = :'v_cognitouserid';

\c customer
select * from "Associate" where "CognitoUserId" = :'v_cognitouserid';
delete from "Associate" where "CognitoUserId" = :'v_cognitouserid';
