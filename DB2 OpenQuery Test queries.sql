SELECT * FROM OPENQUERY(PARIS3, 'Select current date from sysibm.sysdummy1')
SELECT * FROM OPENQUERY(PARIS3, 'SELECT * FROM corp.employee FETCH FIRST 20 ROWS ONLY with UR')