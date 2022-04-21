CREATE EXTENSION IF NOT EXISTS postgres_fdw;

CREATE SERVER dev_associate
FOREIGN DATA WRAPPER postgres_fdw
OPTIONS (host 'reimagine-dev-canada.cluster-ro-c514w15qevsg.ca-central-1.rds.amazonaws.com', port '5432', dbname 'associate');


CREATE USER MAPPING FOR "reimagineUser"
SERVER dev_associate
OPTIONS (user 'reimagineUser', password '');


IMPORT FOREIGN SCHEMA public LIMIT TO ("Associate") FROM SERVER dev_associate INTO public;



INSERT INTO public."Address"(line_one, line_two, city, region, state_or_province_id, country_id, postal_code, postal_code_ext, latitude, longitude, creator_id, modifier_id, type_id, active, business_unit_id, use_for_billing, created, modified)
SELECT "Address1", "Address2", "City", "Region", "StateCode", "Country", "PostalCode", "PostalCodeExt", "Latitude", "Longitude", "Id", "Id", 900, true, 1, FALSE, NOW(), NOW()
FROM public."Associate"

INSERT INTO public."EntityAddress"(entity_id, address_id, address_type_id, business_unit_id)
SELECT b."Id", a.id, a.type_id, a.business_unit_id
from public."Address" a inner join public."Associate" b on a.creator_id = b."Id"
where a.created >= '2021-07-13'
    and a.id>3000
    and a.type_id=900
    and a.business_unit_id=1
    and not exists (select * from public."EntityAddress" e where b."Id"=e.entity_id and a.type_id=e.address_type_id and a.business_unit_id=e.business_unit_id)
	
	
	
--DROP FOREIGN TABLE "Associate";