DECLARE @dbname VARCHAR(50)   
DECLARE @statement NVARCHAR(max)

DECLARE db_cursor CURSOR 
    LOCAL FAST_FORWARD
    FOR  
      SELECT name
      FROM MASTER.dbo.sysdatabases
      WHERE (name like 'CP_U_OH_%' or name like 'MCP_%') and name not in ('CP_U_OH_Audit')
      -- could try <name like N'MCP_Staging_OH-%'>
      OPEN db_cursor  
      FETCH NEXT FROM db_cursor INTO @dbname  
    WHILE @@FETCH_STATUS = 0  

    BEGIN  
        SELECT @statement = 'use ['+@dbname +'];'+ 'EXEC sp_addrolemember N''db_datareader'', 
        [HEALTHSHARE\johnyj]'
        print @statement	
        exec sp_executesql @statement

        FETCH NEXT FROM db_cursor INTO @dbname  
    END  
CLOSE db_cursor  

DEALLOCATE db_cursor 
