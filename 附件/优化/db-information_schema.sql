SELECT * FROM information_schema.character_sets;
SELECT * FROM information_schema.collation_character_set_applicability;
SELECT * FROM information_schema.collations;

SELECT * FROM information_schema.column_privileges;
SELECT * FROM information_schema.COLUMNS;
SELECT * FROM information_schema.ENGINES;
SELECT * FROM information_schema.EVENTS; # 调度作业
SELECT * FROM information_schema.files;
SELECT * FROM information_schema.global_status;
SELECT * FROM information_schema.global_variables WHERE variable_name LIKE '%buffer%';  # select 8388608/1024/1024 as xM;
SELECT * FROM information_schema.key_column_usage; # 索引
SELECT * FROM information_schema.optimizer_trace;
SELECT * FROM information_schema.parameters; # PROCEDURE,FUNCTION 参数
SELECT * FROM information_schema.PARTITIONS;
SELECT * FROM information_schema.PLUGINS;
SELECT * FROM information_schema.PROCESSLIST;
SELECT * FROM information_schema.profiling WHERE query_id = 1;
SELECT * FROM information_schema.referential_constraints;
SELECT * FROM information_schema.routines; # PROCEDURE,FUNCTION
SELECT * FROM information_schema.schema_privileges;
SELECT * FROM information_schema.schemata;
SELECT * FROM information_schema.session_status;
SELECT * FROM information_schema.session_variables WHERE variable_name LIKE '%buffer%';
SELECT * FROM information_schema.statistics WHERE table_schema = 'ab' AND table_name = '200901001'; # 索引
SELECT * FROM information_schema.table_constraints WHERE constraint_schema = 'ab' AND table_name = '200901001';
SELECT * FROM information_schema.table_privileges;
SELECT * FROM information_schema.TABLES;
SELECT * FROM information_schema.tablespaces;
SELECT * FROM information_schema.TRIGGERS;
SELECT * FROM information_schema.user_privileges;
SELECT * FROM information_schema.views;

SELECT COUNT(1) FROM ab.200703000;
SHOW CREATE TABLE PLUGINS;


SELECT 
  table_schema,
  table_name,
  table_rows,
  data_length / 1024 / 1024 / 1024 AS size_G,
  update_time,
  ENGINE,
  table_comment 
FROM
  information_schema.TABLES 
ORDER BY size_G DESC ;


SELECT CONCAT('KILL ',ID,';') FROM INFORMATION_SCHEMA.PROCESSLIST
WHERE COMMAND = 'Sleep';