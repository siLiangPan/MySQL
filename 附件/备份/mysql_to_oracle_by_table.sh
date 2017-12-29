#!/bin/bash

Ymd=$(date +%Y%m%d)

mysql_host=
mysql_port=
mysql_pw=

if test ! -d ./MysqlBackUp; then
  mkdir ./MysqlBackUp
fi

# 3
#if test -f "./MysqlBackUp/mysql_*.sql" ; then
#  rm -rf "./MysqlBackUp/*"
#fi

#rm -rf /stall/MysqlBackUp/mysql_*
#echo $Ymd delete OK!


rm -rf ./MysqlBackUp/mysql_*.sql
echo $Ymd delete OK!

##################
# backup
##################
function mysql_backup {
database_name=$1
table_name=$2
mysqldump   -h192.168.7.133 -P9906 -uroot -p123456 ${database_name} ${table_name} --where=" log_date=DATEDIFF(ADDDATE(${Ymd},-1),19900101)"   -q --default-character-set=utf8 > "./MysqlBackUp/mysql_${table_name}_${Ymd}.sql" 
if [ $? -ne 0 ]
then
echo ${Ymd} backup ${database_name}.${table_name} failed! 
else
echo ${Ymd} backup ${database_name}.${table_name} succeed! 
fi
}

##################
# recover
##################
function oracle_recover {
database_name=$1
table_name=$2
sqlplus sys/sys1234@10.240.240.141:1522/ycfkdb as sysdba << EOF
set heading off feedback off
@@./MysqlBackUp/mysql_${table_name}_${Ymd}.sql;
commit;
EOF
if [ $? -ne 0 ]
then
echo ${Ymd} recover ${database_name}.${table_name} failed! 
else
echo ${Ymd} recover ${database_name}.${table_name} succeed! 
fi
}

##################
# work start
##################
arr_database=("tls_his")
arr_table=("t_tc50_log_failed" "t_tc50_log_info" "t_tc50_login_ans" "t_tc50_login_req" "t_tc50_sc_ans" "t_tc50_sc_req" "t_tc50_trade_ans" "t_tc50_trade_req")
for v in ${arr_database[@]}; do
    for v_table in ${arr_table[@]}; do
	    ${v_table} = ${v_table}_${Ymd}
		mysql_backup $v $v_table
		oracle_recover $v $v_table
	done
done
echo $Ymd backup ok!

#if test -f "./MysqlBackUp/mysql_xsd_tdx_tq_$Ymd.sql" ; then
#  rm "./MysqlBackUp/mysql_xsd_tdx_tq_$Ymd.sql"
#fi
