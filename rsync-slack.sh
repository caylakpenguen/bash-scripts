#!/bin/bash
# Slackware Yansilama Betigi.
# Caylak Penguen 02 - 02 - 2014 - Pazar
#
#
RSYNC=/usr/bin/rsync
# Yerel Dizin Yolu
LOCALDIR=$HOME/iso/Slackware
# Eşitlenecek Dizin.
TARGETDIR=$LOCALDIR/slackware-current
# Log Dizini
LOGDIR=$LOCALDIR/Loglar
# rsync opsiyonel parametreleri.
#OPSIYON=-avh --stats --del

echo "   Basladi >>> `date`"  >>$LOGDIR/date.txt

# Nereden Yansi alinacak.

# ftp.slackware.com
#  OSUOSL yi Gosteriyor
#  RSYNCURL=rsync://ftp.slackware.com

# Oregon State University - Open Source Lab USA ( Birincil Slackware Resmi Yansi )
#  RSYNCURL=rsync://rsync.osuosl.org
#  RSYNCURK=rsync://slackware.osuosl.org

# Bulgaria Mirrors http://mirrors.unixsol.org (SIk Guncellenmiyor... - 04-02-2012)
# RSYNCURL= rsync://mirrors.unixsol.org

# Yandex Rusya Mirror
# RSYNCURL=rsync://mirror.yandex.ru

# Yunanistan  (SIk Guncellenmiyor...)
# RSYNCURL=rsync://ftp.cc.uoc.gr

# Türkiye Linux Kullanıcıları Derneği Sunucusu (SIk Guncellenmiyor... - 04-02-2012)
  RSYNCURL=rsync://ftp.linux.org.tr

# Tam yansi Adresi. Sunucu ve yansılanacak dizin.
  SLACKURL=$RSYNCURL/slackware/slackware-current

# ---------- Main --------------
# Once Durumu  log dosyasina yazsin ;-)
#  $RSYNC $RSYNCURL/slackware/ > $LOGDIR/rsync-slackware-log-server-`date +%F-%H-%M`.txt

# Esitleme Islemi..
 $RSYNC -av -h --stats --del \
	--exclude=source/* \
	--exclude=extra/source/* \
	$SLACKURL/  $TARGETDIR/ > $LOGDIR/rsync-slackware-log-`date +%F-%H-%M`.txt

echo "   Bitti   >>> `date`"  >>$LOGDIR/date.txt
