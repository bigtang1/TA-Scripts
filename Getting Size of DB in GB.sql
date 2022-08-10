select
	DB_NAME(db.database_id) as [DB Name],
	CONVERT(DECIMAL(10,3),SUM((CONVERT(DECIMAL(20,5),mf.size)*8)/1048576)) as [DB Size in GB]
FROM
	sys.databases db
	LEFT JOIN sys.master_files mf
		ON db.database_id = mf.database_id
WHERE
	DB_NAME(db.database_id) like 'DW%'
group by DB_NAME(db.database_id)