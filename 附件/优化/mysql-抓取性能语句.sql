# 全局信息
SELECT * FROM information_schema.INNODB_METRICS;
SELECT * FROM information_schema.profiling;
SELECT state, ROUND(SUM(duration),5) AS `duration (summed) in sec` 
FROM information_schema.profiling WHERE query_id = 16 
GROUP BY state 
ORDER BY `duration (summed) in sec` DESC; 

SELECT * FROM information_schema.INNODB_BUFFER_POOL_STATS;
SELECT * FROM information_schema.global_status ORDER BY variable_value + 0 DESC;
SELECT * FROM information_schema.global_variables WHERE variable_name LIKE '%buffer%';  # select 8388608/1024/1024 as xM;
SELECT * FROM information_schema.session_status ORDER BY variable_value + 0 DESC;
SELECT * FROM information_schema.session_variables WHERE variable_name LIKE '%buffer%';

# lock
SELECT * FROM information_schema.processlist;

SELECT * FROM information_schema.INNODB_LOCK_WAITS;
# LOCK_MODE:S, X, IS, IX, and gap locks(for update) # Section 14.5.1, “InnoDB Locking”.
# LOCK_TYPE:RECORD、TABLE
SELECT * FROM information_schema.INNODB_LOCKS a
INNER JOIN information_schema.INNODB_TRX b ON a.LOCK_TRX_ID = b.TRX_ID
WHERE a.LOCK_ID = 'requested_lock_id'
  AND a.LOCK_TRX_ID = 'requesting_trx_id';

# slow_query
SELECT * FROM mysql.slow_log;
# 开启慢查询
slow_query_log_file=/DATA/LOCAL-pul-slow.log
slow_launch_time=5

SET GLOBAL slow_query_log=ON;
SET GLOBAL slow_launch_time=5;
SET GLOBAL log_output='TABLE'; # 慢查询日志、一般日志写到数据库表

mysql> SHOW VARIABLES LIKE '%slow%';
+---------------------------+--------------------------+
| Variable_name             | VALUE                    |
+---------------------------+--------------------------+
| log_slow_admin_statements | OFF                      |
| log_slow_slave_statements | OFF                      |
| slow_launch_time          | 2                        |
| slow_query_log            | OFF                      |
| slow_query_log_file       | /DATA/LOCAL-pul-slow.log |
| long_query_time           | 10.000000                |
+---------------------------+--------------------------+
5 ROWS IN SET (0.00 sec)
#
SELECT * FROM mysql.general_log;
#开启一般日志 这个日志量比较大
SET GLOBAL general_log=ON;
mysql> SHOW GLOBAL VARIABLES LIKE '%general%';
+------------------+---------------------+
| Variable_name    | VALUE               |
+------------------+---------------------+
| general_log      | OFF                 |
| general_log_file | /DATA/LOCAL-pul.log |
+------------------+---------------------+
2 ROWS IN SET (0.00 sec)

mysql> SHOW VARIABLES LIKE 'log_output';
+---------------+-------+
| Variable_name | VALUE |
+---------------+-------+
| log_output    | FILE  |
+---------------+-------+
1 ROW IN SET (0.00 sec)

# 表分析
ANALYZE TABLE