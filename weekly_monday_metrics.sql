--psql -U reimagineUser -h reimagine-prod-canada.cluster-ro-ckrmvhnrbxg7.ca-central-1.rds.amazonaws.com -d postgres -f "C:\Users\rpatel3\Documents\GitHub\databases\scripts\weekly_monday_metrics.sql"

\pset footer off
\H
\c associate
select count(*) as "TotalVerifiedAssociates"
from "Associate"
where "IsProfileInfoVerified"=true
    and ("Email" is null or lower("Email") not like '%trueblue.com');


\c orders
select (select count(*) from "Order") as "TotalOrdersCreated",
       (select count(*) from "Shift") as "TotalShiftsCreated",
       (select count(*) from "AssociateShift") as "TotalShiftsAccepted"
      
      