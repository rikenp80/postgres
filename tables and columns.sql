SELECT columns.attname as name,
 data_types.typname as type,
 class.relname as table,
 tables.schemaname as schema
 
FROM pg_attribute columns
INNER JOIN pg_class class ON columns.attrelid = class.oid
INNER JOIN pg_tables tables on class.relname = tables.tablename
INNER JOIN pg_type data_types 
ON columns.atttypid = data_types.oid

WHERE data_types.typname = 'varchar';