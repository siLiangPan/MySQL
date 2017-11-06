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


rm -rf "./MysqlBackUp/mysql_*_$Ymd.sql"
echo $Ymd delete OK!

##################
# backup
##################
mysqldump   -h192.168.7.133 -P9906 --databases tdx -uroot -p123456 -q --default-character-set=utf8 > "./MysqlBackUp/mysql_tdx_$Ymd.sql" 
if [ $? -ne 0 ]
then
echo $Ymd backup 133 tdx failed! 
else
echo $Ymd backup 133 tdx succeed! 
fi

mysqldump   -h192.168.7.133 -P9906 --databases pul -uroot -p123456 -q --default-character-set=utf8 > "./MysqlBackUp/mysql_pul_$Ymd.sql" 
if [ $? -ne 0 ]
then
echo $Ymd backup 133 pul failed! 
else
echo $Ymd backup 133 pul succeed! 
fi

mysqldump   -h192.168.7.133 -P9906 --databases new_pul -uroot -p123456 -q --default-character-set=utf8 > "./MysqlBackUp/mysql_new_pul_$Ymd.sql" 
if [ $? -ne 0 ]
then
echo $Ymd backup 133 new_pul failed! 
else
echo $Ymd backup 133 new_pul succeed! 
fi

mysqldump   -h192.168.7.133 -P9906 --databases new_sso -uroot -p123456 -q --default-character-set=utf8 > "./MysqlBackUp/mysql_new_sso_$Ymd.sql" 
if [ $? -ne 0 ]
then
echo $Ymd backup 133 new_sso failed! 
else
echo $Ymd backup 133 new_sso succeed! 
fi

mysqldump   -h192.168.7.133 -P9906 --databases tdx_mobile -uroot -p123456 -q --default-character-set=utf8 > "./MysqlBackUp/mysql_tdx_mobile_$Ymd.sql" 
if [ $? -ne 0 ]
then
echo $Ymd backup 133 tdx_mobile failed! 
else
echo $Ymd backup 133 tdx_mobile succeed! 
fi 

##################
# recover
##################
mysql -h192.168.7.132 -P9906 -uroot -p123456 -q  < "./MysqlBackUp/mysql_tdx_$Ymd.sql" 
if [ $? -ne 0 ]
then
echo $Ymd recover 132 tdx failed! 
else
echo $Ymd recover 132 tdx succeed! 
fi 

mysql -h192.168.7.132 -P9906 -uroot -p123456 -q  < "./MysqlBackUp/mysql_pul_$Ymd.sql" 
if [ $? -ne 0 ]
then
echo $Ymd recover 132 pul failed! 
else
echo $Ymd recover 132 pul succeed! 
fi 

mysql -h192.168.7.132 -P9906 -uroot -p123456 -q  < "./MysqlBackUp/mysql_new_pul_$Ymd.sql" 
if [ $? -ne 0 ]
then
echo $Ymd recover 132 new_pul failed! 
else
echo $Ymd recover 132 new_pul succeed! 
fi 

mysql -h192.168.7.132 -P9906 -uroot -p123456 -q  < "./MysqlBackUp/mysql_new_sso_$Ymd.sql" 
if [ $? -ne 0 ]
then
echo $Ymd recover 132 new_sso failed! 
else
echo $Ymd recover 132 new_sso succeed! 
fi 

mysql -h192.168.7.132 -P9906 -uroot -p123456 -q  < "./MysqlBackUp/mysql_tdx_mobile_$Ymd.sql" 
if [ $? -ne 0 ]
then
echo $Ymd recover 132 tdx_mobile failed! 
else
echo $Ymd recover 132 tdx_mobile succeed! 
fi 

echo $Ymd backup ok!

#if test -f "./MysqlBackUp/mysql_xsd_tdx_tq_$Ymd.sql" ; then
#  rm "./MysqlBackUp/mysql_xsd_tdx_tq_$Ymd.sql"
#fi
