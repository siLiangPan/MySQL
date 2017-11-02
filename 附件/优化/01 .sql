
infobrightѧϰ�ʼ� 
http://blog.csdn.net/bff1022/article/details/50346009


Optimizing at the Database Level
1. Are the tables structured properly? In particular, do the columns have the right data types, and does
each table have the appropriate columns for the type of work? ��������
2. Are the right indexes in place to make queries efficient? ����
3. Are you using the appropriate storage engine for each table, and taking advantage of the strengths and
features of each storage engine you use? In particular, the choice of a transactional storage engine
such as InnoDB or a nontransactional one such as MyISAM can be very important for performance and
scalability. �洢����

ѹ����

����

 Are all memory areas used for caching sized correctly? ����
 
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

һ������������������
ServerMainHeapSize��ΪIB��ʹ���ڴ�����ֵ��������bh_loader���������ר��DB�����������ʵ����󣬱�֤��ҵ����߷壬ϵͳswap�������߼���
ServerCompressedHeapSize��
LoaderMainHeapSize����������ʽ�洢��IB��Ҫ���������ݸ���������Ϻ�д�����ݿ飬��������������ܶ࣬�ֶκܳ�������ֵ���ߣ��ӿ쵼�����ʣ�����ǰset autocommit=0,��ɺ�commit+��ԭ���ɴ����ߵ���Ч�ʣ�

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

--��ԭ
SET GLOBAL key_buffer_size = 16*1024*1024;
SET GLOBAL query_cache_size = 8*1024*1024;
SET GLOBAL read_buffer_size = 1*1024*1024;

read_rnd_buffer_size = 8M
sort_buffer_size = 4M

 
 Disk seeks time for this is usually lower than 10ms
 one disk delivers at least 10�C20MB/s throughput
 
 
 
 Balancing Portability and Performance
To use performance-oriented SQL extensions in a portable MySQL program, you can wrap MySQL-
specific keywords in a statement within /*! */ comment delimiters. Other SQL servers ignore the
commented keywords. For information about writing comments, see Section 9.6, ��Comment Syntax��.


�����
ANALYZE TABLE

