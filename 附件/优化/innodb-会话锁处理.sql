SELECT tab.table_schema,tab.table_name,tab.engine,FORMAT(tab.table_rows,0) AS table_rows,
 CONCAT(FORMAT(ROUND(tab.DATA_LENGTH/1024/1024,2),2),'M') AS size_M,
tab.auto_increment,col.`COLUMN_NAME`,tab.update_time
 FROM information_schema.`TABLES` tab 
 LEFT JOIN information_schema.COLUMNS col
 ON col.`TABLE_SCHEMA` = tab.`TABLE_SCHEMA`
 AND col.`TABLE_NAME` = tab.`TABLE_NAME`
 AND col.`EXTRA` = 'auto_increment'
WHERE tab.table_schema = 'monitor'
ORDER BY table_rows DESC;
  
SELECT * FROM information_schema.`PROCESSLIST`
WHERE state <> ''
ORDER BY state DESC;
SELECT * FROM information_schema.INNODB_LOCK_WAITS;
SELECT * FROM information_schema.INNODB_LOCKS ORDER BY trx_started;
SELECT * FROM information_schema.INNODB_TRX;
SELECT * FROM information_schema.`PROCESSLIST`
WHERE id = '96302';


SHOW VARIABLES LIKE 'general_log%';
SET GLOBAL general_log = ON;

SET GLOBAL general_log = OFF;

SELECT a.`trx_id`,a.`trx_state`,a.`trx_started`,CONCAT('kill ',pro.`ID`,';') AS kill_sql, pro.* FROM information_schema.INNODB_TRX a,information_schema.PROCESSLIST pro
WHERE a.trx_id IN (SELECT b.blocking_trx_id FROM information_schema.INNODB_LOCK_WAITS b)
  AND a.`trx_mysql_thread_id` = pro.`ID`;

-- 锁了哪些
SELECT * FROM information_schema.INNODB_LOCKS
WHERE lock_trx_id = '22ACF267';

SELECT * FROM information_schema.INNODB_LOCK_WAITS
WHERE blocking_trx_id = '22ACF267';
