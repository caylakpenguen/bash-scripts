#!/bin/bash
# https://forum.pfsense.org/index.php?topic=109612.0
# Author: tcjackal
#Alias
ftphost='ftp.test.local'
user='test'
pass='test123456'
pfname='sube1'
date=`date "+%Y%m%d-%H%M%S"`

#Conf
cd /cf/conf/

#Ftp Login
ftp -n -v $ftphost << EOT
ascii
user $user $pass
prompt
put config.xml  $pfname-$date.xml
bye
EOT
#-------

