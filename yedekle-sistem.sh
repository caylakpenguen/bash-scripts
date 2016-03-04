#!/bin/bash
# Çrş 02 Mar 2016 20:32:16 EET  CaylakPenguen
# sistem servis yedeklerini almak icin betik
# Lisans = GNU/GPL
#

DATADIR="/root/sistem"
DIZIN="$DATADIR/$(date +%F)"

yedekal(){
mkdir -p $DIZIN
cd $DIZIN
cp -r /etc/bind .
cp -r /etc/nginx .
cp -r /etc/supervisor .
cp -a /etc/aliases* .
cp -ar /etc/postfix .
cp -ar /etc/opendkim* .
cp -ar /var/log/apt apt-log
cp -ar /var/log/mail.* .
date > $(date +%F-%H-%M).txt
cd $DATADIR
tar -zcf $DIZIN.tar.gz $DIZIN
}

yedekle (){
yedekal
}

# ***

yedekle

