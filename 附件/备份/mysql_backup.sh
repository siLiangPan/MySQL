#!/bin/bash

Ymd=$(date +%Y%m%d)

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
mysqldump   -h192.168.7.133 -P9906 --databases ${database_name} -uroot -p123456 -q --default-character-set=utf8 > "./MysqlBackUp/mysql_${database_name}_${Ymd}.sql" 
if [ $? -ne 0 ]
then
echo ${Ymd} backup 133 ${database_name} failed! 
else
echo ${Ymd} backup 133 ${database_name} succeed! 
fi
}

##################
# recover
##################
function mysql_recover {
database_name=$1
mysql -h192.168.7.132 -P9906 -uroot -p123456 -q  < "./MysqlBackUp/mysql_${database_name}_${Ymd}.sql" 
if [ $? -ne 0 ]
then
echo ${Ymd} recover 132 ${database_name} failed! 
else
echo ${Ymd} recover 132 ${database_name} succeed! 
fi
}

##################
# work start
##################
arr_database=("tdx" "pul" "new_pul" "new_sso" "tdx_mobile")
for v in ${arr_database[@]}; do
    mysql_backup $v
    mysql_recover $v
done
echo $Ymd backup ok!

#if test -f "./MysqlBackUp/mysql_xsd_tdx_tq_$Ymd.sql" ; then
#  rm "./MysqlBackUp/mysql_xsd_tdx_tq_$Ymd.sql"
#fi
