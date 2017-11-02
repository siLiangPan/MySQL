::1
set "Ymd=%date:~,4%%date:~5,2%%date:~8,2%"  
::2
if not exist "D:\MysqlBackUp"  md "D:\MysqlBackUp"
::3
if exist "D:\MysqlBackUp\mysql_xsd_tdx_tq_%Ymd%.sql"  del /q D:\MysqlBackUp\mysql_xsd_tdx_tq_%Ymd%.sql
if exist "D:\MysqlBackUp\mysql_xsd_tdx_cms_%Ymd%.sql"  del /q D:\MysqlBackUp\mysql_xsd_tdx_cms_%Ymd%.sql
if exist "D:\MysqlBackUp\mysql_xsd_tdx_pmd_%Ymd%.sql"  del /q D:\MysqlBackUp\mysql_xsd_tdx_pmd_%Ymd%.sql
if exist "D:\MysqlBackUp\mysql_xsd_tdx_pul_%Ymd%.sql"  del /q D:\MysqlBackUp\mysql_xsd_tdx_pul_%Ymd%.sql
if exist "D:\MysqlBackUp\mysql_xsd_tdx_qxgl_%Ymd%.sql"  del /q D:\MysqlBackUp\mysql_xsd_tdx_qxgl_%Ymd%.sql
if exist "D:\MysqlBackUp\mysql_xsd_tdx_zxg_%Ymd%.sql"  del /q D:\MysqlBackUp\mysql_xsd_tdx_zxg_%Ymd%.sql
::4
if not exist "D:\MysqlBackUp\mysql_yw_%Ymd%.log"  echo. >"D:\MysqlBackUp\mysql_yw_%Ymd%.log"
::if exist "D:\MysqlBackUp\mysql_%Ymd%.zip"  del /q D:\MysqlBackUp\mysql_%Ymd%.zip
::5
"D:\tdx\database\mysql_sync_yw_3306_x64\bin\mysqldump.exe"   -h localhost -P 3306 --databases xsd_tdx_tq -uroot -pxsdzq-611 -q > "D:/MysqlBackUp/mysql_xsd_tdx_tq_%Ymd%.sql" 
IF %ERRORLEVEL% EQU 0 (echo %Ymd% backup 196 xsd_tdx_tq success! >>"D:\MysqlBackUp\mysql_yw_%Ymd%.log"
) ELSE (echo %Ymd% backup 196 xsd_tdx_tq failure! >>"D:\MysqlBackUp\mysql_yw_%Ymd%.log")
"D:\tdx\database\mysql_sync_yw_3306_x64\bin\mysqldump.exe"   -h localhost -P 3306 --databases xsd_tdx_cms -uroot -pxsdzq-611 -q > "D:/MysqlBackUp/mysql_xsd_tdx_cms_%Ymd%.sql" 
IF %ERRORLEVEL% EQU 0 (echo %Ymd% backup 196 xsd_tdx_cms success! >>"D:\MysqlBackUp\mysql_yw_%Ymd%.log"
) ELSE (echo %Ymd% backup 196 xsd_tdx_cms failure! >>"D:\MysqlBackUp\mysql_yw_%Ymd%.log")
"D:\tdx\database\mysql_sync_yw_3306_x64\bin\mysqldump.exe"   -h localhost -P 3306 --databases xsd_tdx_pmd -uroot -pxsdzq-611 -q > "D:/MysqlBackUp/mysql_xsd_tdx_pmd_%Ymd%.sql" 
IF %ERRORLEVEL% EQU 0 (echo %Ymd% backup 196 xsd_tdx_pmd success! >>"D:\MysqlBackUp\mysql_yw_%Ymd%.log"
) ELSE (echo %Ymd% backup 196 xsd_tdx_pmd failure! >>"D:\MysqlBackUp\mysql_yw_%Ymd%.log")
"D:\tdx\database\mysql_sync_yw_3306_x64\bin\mysqldump.exe"   -h localhost -P 3306 --databases xsd_tdx_pul -uroot -pxsdzq-611 -q > "D:/MysqlBackUp/mysql_xsd_tdx_pul_%Ymd%.sql" 
IF %ERRORLEVEL% EQU 0 (echo %Ymd% backup 196 xsd_tdx_pul success! >>"D:\MysqlBackUp\mysql_yw_%Ymd%.log"
) ELSE (echo %Ymd% backup 196 xsd_tdx_pul failure! >>"D:\MysqlBackUp\mysql_yw_%Ymd%.log")
"D:\tdx\database\mysql_sync_yw_3306_x64\bin\mysqldump.exe"   -h localhost -P 3306 --databases xsd_tdx_qxgl -uroot -pxsdzq-611 -q > "D:/MysqlBackUp/mysql_xsd_tdx_qxgl_%Ymd%.sql" 
IF %ERRORLEVEL% EQU 0 (echo %Ymd% backup 196 xsd_tdx_qxgl success! >>"D:\MysqlBackUp\mysql_yw_%Ymd%.log"
) ELSE (echo %Ymd% backup 196 xsd_tdx_qxgl failure! >>"D:\MysqlBackUp\mysql_yw_%Ymd%.log")
"D:\tdx\database\mysql_sync_yw_3306_x64\bin\mysqldump.exe"   -h localhost -P 3306 --databases xsd_tdx_zxg -uroot -pxsdzq-611 -q > "D:/MysqlBackUp/mysql_xsd_tdx_zxg_%Ymd%.sql" 
IF %ERRORLEVEL% EQU 0 (echo %Ymd% backup 196 xsd_tdx_zxg success! >>"D:\MysqlBackUp\mysql_yw_%Ymd%.log"
) ELSE (echo %Ymd% backup 196 xsd_tdx_zxg failure! >>"D:\MysqlBackUp\mysql_yw_%Ymd%.log")
::6
::rar a  D:/MysqlBackUp/mysql_%Ymd%.zip  D:/MysqlBackUp/mysql_%Ymd%.sql
::7
"D:\tdx\database\mysql_sync_yw_3306_x64\bin\mysql.exe" -h 10.150.5.197 -P 3306 -uroot -pxsdzq-611 -q --default-character-set=utf8 xsd_tdx_tq < "D:/MysqlBackUp/mysql_xsd_tdx_tq_%Ymd%.sql" 
IF %ERRORLEVEL% EQU 0 (echo %Ymd% backup 197 xsd_tdx_tq success! >>"D:\MysqlBackUp\mysql_yw_%Ymd%.log"
) ELSE (echo %Ymd% backup 197 xsd_tdx_tq failure! >>"D:\MysqlBackUp\mysql_yw_%Ymd%.log")
"D:\tdx\database\mysql_sync_yw_3306_x64\bin\mysql.exe" -h 10.150.5.197 -P 3306 -uroot -pxsdzq-611 -q --default-character-set=utf8 xsd_tdx_cms < "D:/MysqlBackUp/mysql_xsd_tdx_cms_%Ymd%.sql" 
IF %ERRORLEVEL% EQU 0 (echo %Ymd% backup 197 xsd_tdx_cms success! >>"D:\MysqlBackUp\mysql_yw_%Ymd%.log"
) ELSE (echo %Ymd% backup 197 xsd_tdx_cms failure! >>"D:\MysqlBackUp\mysql_yw_%Ymd%.log")
"D:\tdx\database\mysql_sync_yw_3306_x64\bin\mysql.exe" -h 10.150.5.197 -P 3306 -uroot -pxsdzq-611 -q --default-character-set=utf8 xsd_tdx_pmd < "D:/MysqlBackUp/mysql_xsd_tdx_pmd_%Ymd%.sql" 
IF %ERRORLEVEL% EQU 0 (echo %Ymd% backup 197 xsd_tdx_pmd success! >>"D:\MysqlBackUp\mysql_yw_%Ymd%.log"
) ELSE (echo %Ymd% backup 197 xsd_tdx_pmd failure! >>"D:\MysqlBackUp\mysql_yw_%Ymd%.log")
"D:\tdx\database\mysql_sync_yw_3306_x64\bin\mysql.exe" -h 10.150.5.197 -P 3306 -uroot -pxsdzq-611 -q --default-character-set=utf8 xsd_tdx_pul < "D:/MysqlBackUp/mysql_xsd_tdx_pul_%Ymd%.sql" 
IF %ERRORLEVEL% EQU 0 (echo %Ymd% backup 197 xsd_tdx_pul success! >>"D:\MysqlBackUp\mysql_yw_%Ymd%.log"
) ELSE (echo %Ymd% backup 197 xsd_tdx_pul failure! >>"D:\MysqlBackUp\mysql_yw_%Ymd%.log")
"D:\tdx\database\mysql_sync_yw_3306_x64\bin\mysql.exe" -h 10.150.5.197 -P 3306 -uroot -pxsdzq-611 -q --default-character-set=utf8 xsd_tdx_qxgl < "D:/MysqlBackUp/mysql_xsd_tdx_qxgl_%Ymd%.sql" 
IF %ERRORLEVEL% EQU 0 (echo %Ymd% backup 197 xsd_tdx_qxgl success! >>"D:\MysqlBackUp\mysql_yw_%Ymd%.log"
) ELSE (echo %Ymd% backup 197 xsd_tdx_qxgl failure! >>"D:\MysqlBackUp\mysql_yw_%Ymd%.log")
"D:\tdx\database\mysql_sync_yw_3306_x64\bin\mysql.exe" -h 10.150.5.197 -P 3306 -uroot -pxsdzq-611 -q --default-character-set=utf8 xsd_tdx_zxg < "D:/MysqlBackUp/mysql_xsd_tdx_zxg_%Ymd%.sql" 
IF %ERRORLEVEL% EQU 0 (echo %Ymd% backup 197 xsd_tdx_zxg success! >>"D:\MysqlBackUp\mysql_yw_%Ymd%.log"
) ELSE (echo %Ymd% backup 197 xsd_tdx_zxg failure! >>"D:\MysqlBackUp\mysql_yw_%Ymd%.log")
::8   
echo onbackup ok!

if exist "D:\MysqlBackUp\mysql_xsd_tdx_tq_%Ymd%.sql"  del /q D:\MysqlBackUp\mysql_xsd_tdx_tq_%Ymd%.sql
if exist "D:\MysqlBackUp\mysql_xsd_tdx_cms_%Ymd%.sql"  del /q D:\MysqlBackUp\mysql_xsd_tdx_cms_%Ymd%.sql
if exist "D:\MysqlBackUp\mysql_xsd_tdx_pmd_%Ymd%.sql"  del /q D:\MysqlBackUp\mysql_xsd_tdx_pmd_%Ymd%.sql
if exist "D:\MysqlBackUp\mysql_xsd_tdx_pul_%Ymd%.sql"  del /q D:\MysqlBackUp\mysql_xsd_tdx_pul_%Ymd%.sql
if exist "D:\MysqlBackUp\mysql_xsd_tdx_qxgl_%Ymd%.sql"  del /q D:\MysqlBackUp\mysql_xsd_tdx_qxgl_%Ymd%.sql
if exist "D:\MysqlBackUp\mysql_xsd_tdx_zxg_%Ymd%.sql"  del /q D:\MysqlBackUp\mysql_xsd_tdx_zxg_%Ymd%.sql

