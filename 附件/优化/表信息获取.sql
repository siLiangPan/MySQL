-- call tls_his.p_get_table_information('test','t_tc50_login_req');


BEGIN

-- declare in_table_owner varchar(64);-- default 'test';
-- DECLARE in_table_name VARCHAR(64);-- DEFAULT 't_tc50_login_req';

 SET  @in_table_owner = 'test';
 SET  @in_table_name = 't_tc50_login_req';


-- 表
SELECT tab.table_schema,tab.table_name,tab.engine,tab.table_rows,
 CONCAT(FORMAT(ROUND(tab.DATA_LENGTH/1024/1024,2),2),'M') AS size_M,
tab.auto_increment,col.`COLUMN_NAME`,tab.update_time
 FROM information_schema.`TABLES` tab 
 LEFT JOIN information_schema.COLUMNS col
 ON col.`TABLE_SCHEMA` = tab.`TABLE_SCHEMA`
 AND col.`TABLE_NAME` = tab.`TABLE_NAME`
 AND col.`EXTRA` = 'auto_increment'
WHERE tab.table_schema = @in_table_owner
  AND tab.table_name = @in_table_name; 
    
-- 索引
SELECT idx.*,cons.`CONSTRAINT_TYPE` FROM 
(SELECT idx1.table_schema, idx1.table_name, idx1.index_name ,idx1.index_type,
GROUP_CONCAT(CONCAT_WS(' ',idx1.column_name,idx1.CARDINALITY,col.column_type) ORDER BY seq_in_index ASC)  AS column_name
FROM information_schema.`STATISTICS` idx1
  INNER JOIN information_schema.COLUMNS col
  ON col.table_schema = idx1.TABLE_SCHEMA
  AND col.table_name = idx1.TABLE_NAME
  AND col.column_name = idx1.column_name
  WHERE idx1.table_schema = @in_table_owner
  AND idx1.table_name = @in_table_name
  GROUP BY idx1.table_schema, idx1.table_name, idx1.index_name ,idx1.index_type) idx
  LEFT JOIN information_schema.TABLE_CONSTRAINTS cons ON idx.table_schema = cons.`TABLE_SCHEMA`
  AND idx.table_name = cons.`TABLE_NAME` AND idx.index_name = cons.`CONSTRAINT_NAME`;

-- 分区表
SELECT table_schema, table_name, 
(CASE WHEN subpartition_name IS NOT NULL THEN '' ELSE
CONCAT_WS(',',partition_name,partition_method,partition_expression,partition_description,
CONCAT(table_rows,' rows'),
CONCAT(FORMAT(ROUND(data_length/1024/1024,2),2),'M')) END) AS partition_desc,
(CASE WHEN subpartition_name IS NULL THEN '' ELSE
CONCAT_WS(',',subpartition_name,subpartition_method,subpartition_expression,partition_description,
CONCAT(table_rows,' rows'),
CONCAT(FORMAT(ROUND(data_length/1024/1024,2),2),'M')) END ) AS subpartition_desc
FROM information_schema.`PARTITIONS`
WHERE partition_name IS NOT NULL
 AND table_schema = @in_table_owner
 AND table_name = @in_table_name;

END;