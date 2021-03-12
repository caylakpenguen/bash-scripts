#!/bin/bash
# caylakpenguen - 20 Aralik 2020 - 19:14
# edit = Prs 14 Oca 2021 21:46:15 +03 
# Plesk-Panel icin Mysql db yedekleme servisi :)
#
# her saat basi yedek almak icin. 
# Ornek Cron girdisi
# 00 * * * * /root/yedekle.sh
#
#
DATE=`date "+%Y%m%d-%H%M%S"`
OPSIYON="--single-transaction --default-character-set=utf8mb4"
MYSQL_PWD=`cat /etc/psa/.psa.shadow`
DUMPCMD="mysqldump -uadmin"
CMD="$MYSQL_PWD $DUMPCMD $OPSIYON"


#Yedek-Al
$CMD FORUMDB | gzip -9 > /root/Backup/FORUMDB.sql.gz
$CMD RESIMDB | gzip -9 > /root/Backup/RESIMDB.sql.gz
$CMD DOSYADB | gzip -9 > /root/Backup/DOSYADB.sql.gz
#-------
#bittiiii :)
