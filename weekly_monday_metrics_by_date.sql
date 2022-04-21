--psql -U reimagineUser -h reimagine-prod-canada.cluster-ro-ckrmvhnrbxg7.ca-central-1.rds.amazonaws.com -d postgres -f "C:\Users\rpatel3\Documents\GitHubNew\databases\scripts\weekly_monday_metrics_by_date.sql"

\pset footer off
\H
\c associate
select count(*) as "TotalVerifiedAssociates"
from "Associate"
where "IsProfileInfoVerified"=true
	and "Created" > CURRENT_DATE - INTERVAL '4 months'
    and ("Email" is null or lower("Email") not like '%trueblue.com');


\c orders
select (select count(*) from "Order" where "Created" > CURRENT_DATE - INTERVAL '4 months') as "TotalOrdersCreated",
       (select count(*) from "Shift" where "Created" > CURRENT_DATE - INTERVAL '4 months') as "TotalShiftsCreated",
       (select count(*) from "AssociateShift" where "Created" > CURRENT_DATE - INTERVAL '4 months') as "TotalShiftsAccepted"