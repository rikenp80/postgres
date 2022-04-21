SELECT * FROM pg_catalog.pg_sequences

SELECT nextval(format('%I', 'AuthorizedEntity_id_seq'));
SELECT nextval(format('%I', 'AuthorizedEntity_user_id_seq'));

ALTER SEQUENCE "AuthorizedEntity_user_id_seq" RESTART WITH 257;