exec sp_msforeachdb 'select ''?'', OBJECT_SCHEMA_NAME(object_id,DB_ID(''?'')) AS Schema_Name, OBJECT_NAME(object_id,DB_ID(''?'')) AS Table_Name, name AS Column_Name, masking_function from [?].sys.masked_columns'

exec sp_msforeachdb 'select ''?'',* from [?].sys.masked_columns'