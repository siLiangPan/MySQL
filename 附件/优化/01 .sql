
infobright学习笔记 
http://blog.csdn.net/bff1022/article/details/50346009


Optimizing at the Database Level
1. Are the tables structured properly? In particular, do the columns have the right data types, and does
each table have the appropriate columns for the type of work? 数据类型
2. Are the right indexes in place to make queries efficient? 索引
3. Are you using the appropriate storage engine for each table, and taking advantage of the strengths and
features of each storage engine you use? In particular, the choice of a transactional storage engine
such as InnoDB or a nontransactional one such as MyISAM can be very important for performance and
scalability. 存储引擎

压缩表

并发

 Are all memory areas used for caching sized correctly? 缓存
 
 SHOW [GLOBAL | SESSION] VARIABLES [like_or_where]
 mysql> SHOW variables like '%size%';
innodb_buffer_pool_size
sort_buffer_size
read_buffer_size
query_cache_size


mysql> SHOW variables like '%buffer_size';
mysql> SHOW variables like '%cache_size';


key_buffer_size = 640M
--max_allowed_packet = 2M
query_cache_size = 100M
read_buffer_size = 1M
read_rnd_buffer_size = 4M
sort_buffer_size = 4M

一般配置以下三个参数
ServerMainHeapSize：为IB所使用内存的最大值（不包括bh_loader），如果是专用DB服务器，可适当调大，保证在业务最高峰，系统swap交换不高即可
ServerCompressedHeapSize：
LoaderMainHeapSize：由于是列式存储，IB需要将多行数据各列数据组合后写入数据块，如果导入表的列数很多，字段很长，将该值调高，加快导入速率（导入前set autocommit=0,完成后commit+复原，可大幅提高导入效率）

# System Memory    Server Main Heap Size     Server Compressed Heap Size   Loader Main Heap Size 
 # 32GB                 24000M                     4000M                       800M 
 # 16GB                 10000                      1000                       800 
 #  8GB                  4000                       500                       800 
 #  4GB                  1300                       400                       400 
 #  2GB                  600                        250                       320 
 
ServerMainHeapSize=24000M
LoaderMainHeapSize=800M
thread_concurrency = 32

SET GLOBAL key_buffer_size = 3072*1024*1024;
SET GLOBAL query_cache_size = 256*1024*1024;
SET GLOBAL read_buffer_size = 4*1024*1024;

show global variables like 'key_buffer_size';
show global variables like 'query_cache_size';
show global variables like 'read_buffer_size';

--还原
SET GLOBAL key_buffer_size = 16*1024*1024;
SET GLOBAL query_cache_size = 8*1024*1024;
SET GLOBAL read_buffer_size = 1*1024*1024;

read_rnd_buffer_size = 8M
sort_buffer_size = 4M

 
 Disk seeks time for this is usually lower than 10ms
 one disk delivers at least 10–20MB/s throughput
 
 
 
 Balancing Portability and Performance
To use performance-oriented SQL extensions in a portable MySQL program, you can wrap MySQL-
specific keywords in a statement within /*! */ comment delimiters. Other SQL servers ignore the
commented keywords. For information about writing comments, see Section 9.6, “Comment Syntax”.


表分析
ANALYZE TABLE

