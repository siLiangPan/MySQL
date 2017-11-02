-- call mysql.p_get_table_information('test','t_tc50_login_req');

-- GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' ;
-- flush privileges;
-- SELECT table_schema,table_name FROM information_schema.tables PROCEDURE ANALYSE(10, 2000);
/*
错误代码： 1044
Access denied for user 'root'@'%' to database 'information_schema'
http://stackoverflow.com/questions/30912394/1044-access-denied-for-user-rootlocalhost-to-database-information-schem
You should not be running statements on the info schema db (unless you REALLY know what you're doing). 
The database serves as a "meta" repository that dictates how the server operates. 
Chances are that you have no need to touch it and you'll likely brick your server if you do.
*/
DELIMITER $$

USE mysql $$

DROP PROCEDURE /*!IF EXISTS */  p_get_table_information $$

CREATE
    /*[DEFINER = { user | CURRENT_USER }]*/
    PROCEDURE `p_get_table_information`(
    in_table_owner VARCHAR(64),
    in_table_name VARCHAR(64)
)
    /*LANGUAGE SQL
    | [NOT] DETERMINISTIC
    | { CONTAINS SQL | NO SQL | READS SQL DATA | MODIFIES SQL DATA }
    | SQL SECURITY { DEFINER | INVOKER }
    | COMMENT 'string'*/
    BEGIN
    
-- declare in_table_owner varchar(64) default 'test';
-- DECLARE in_table_name VARCHAR(64) DEFAULT 't_tc50_login_req';

-- set in_table_owner = 'test';
-- SET in_table_name = 't_tc50_login_req';

-- 表
SELECT tab.table_schema,tab.table_name,tab.engine,FORMAT(tab.table_rows,0) AS table_rows,
 CONCAT(FORMAT(ROUND(tab.DATA_LENGTH/1024/1024,2),2),'M') AS size_M,
tab.auto_increment,col.`COLUMN_NAME`,tab.update_time
 FROM information_schema.`TABLES` tab 
 LEFT JOIN information_schema.COLUMNS col
 ON col.`TABLE_SCHEMA` = tab.`TABLE_SCHEMA`
 AND col.`TABLE_NAME` = tab.`TABLE_NAME`
 AND col.`EXTRA` = 'auto_increment'
WHERE tab.table_schema = in_table_owner
  AND tab.table_name = in_table_name; 
    
-- 索引

SET @sql_string =CONCAT('SHOW INDEX FROM ',in_table_owner,'.',in_table_name);
# CALL tls_his.p_execute_sql(@sql_string,@result);

SELECT idx.table_schema, idx.table_name, idx.index_name ,idx.index_type,
/*CAST(*/idx.column_name/* AS CHAR(255) CHARACTER SET utf8)*/ AS column_name,
cons.`CONSTRAINT_TYPE` 
FROM 
(SELECT idx1.table_schema, idx1.table_name, idx1.index_name ,idx1.index_type,
GROUP_CONCAT(CONCAT_WS(' ',idx1.column_name,idx1.CARDINALITY,col.column_type) ORDER BY seq_in_index ASC)  AS column_name
FROM information_schema.`STATISTICS` idx1
  INNER JOIN information_schema.COLUMNS col
  ON col.table_schema = idx1.TABLE_SCHEMA
  AND col.table_name = idx1.TABLE_NAME
  AND col.column_name = idx1.column_name
  WHERE idx1.table_schema = in_table_owner
  AND idx1.table_name = in_table_name
  GROUP BY idx1.table_schema, idx1.table_name, idx1.index_name ,idx1.index_type) idx
  LEFT JOIN information_schema.TABLE_CONSTRAINTS cons ON idx.table_schema = cons.`TABLE_SCHEMA`
  AND idx.table_name = cons.`TABLE_NAME` AND idx.index_name = cons.`CONSTRAINT_NAME`;

-- 分区表
SELECT table_schema, table_name, 
-- partition_desc
CAST((CASE WHEN subpartition_name IS NOT NULL THEN '' ELSE
CONCAT_WS(',',partition_name,partition_method,partition_expression,partition_description,
CONCAT(table_rows,' rows'),
CONCAT(FORMAT(ROUND(data_length/1024/1024,2),2),'M')) END) AS CHAR(255) CHARACTER SET utf8) AS partition_desc,
-- subpartition_desc
(CASE WHEN subpartition_name IS NULL THEN '' ELSE
CONCAT_WS(',',subpartition_name,subpartition_method,subpartition_expression,partition_description,
CONCAT(table_rows,' rows'),
CONCAT(FORMAT(ROUND(data_length/1024/1024,2),2),'M')) END ) AS subpartition_desc
-- end
FROM information_schema.`PARTITIONS`
WHERE partition_name IS NOT NULL
 AND table_schema = in_table_owner
 AND table_name = in_table_name;
 
    END$$

DELIMITER ;