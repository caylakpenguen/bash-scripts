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
$CMD FORUMDB | gzip -9 > /root/FORUMDB.sql.gz
$CMD RESIMDB | gzip -9 > /root/RESIMDB.sql.gz
$CMD DOSYADB | gzip -9 > /root/DOSYADB.sql.gz

#Tar arsivi olustur.
cd /root
sleep 1
tar -cpf backup.tar FORUMDB.sql.gz \
        RESIMDB.sql.gz \
        DOSYADB.sql.gz

#ftp bilgileri girilecek.
ftphost='10.20.30.40'
user='caylak'
pass='P4r0l+a5evD4'

#Ftp Gonderimi.
ftp -n -v $ftphost << EOT
ascii
user $user $pass
prompt
# harici disk dizinine gir.
cd Backup/xenforo
# dosyayi yolla tarihli olarak.
put backup.tar  backup-$DATE.tar
#
bye
EOT
#-------
#bittiiii :)
