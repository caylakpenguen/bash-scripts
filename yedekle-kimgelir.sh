#!/bin/bash
# Çrş 02 Mar 2016 18:54:22 EET 
# caylakpenguen
# Lisans = GNU/GPL

# crontab girdisi icin
#59 23 * * * /root/yedekle-kimgelir.sh

# --- Degiskenler
DATADIR="/webapps"
BCKDIR="/root/Kimgelir-Backup"
DATE=$(date)
cd $BCKDIR

dondur(){
# en eski yedek silinsin.
rm -rf $BCKDIR/backup.08.delete
# Once yedek dizinleri Dondurelim.
mv -f $BCKDIR/backup.07 $BCKDIR/backup.08.delete
mv -f $BCKDIR/backup.06 $BCKDIR/backup.07
mv -f $BCKDIR/backup.05 $BCKDIR/backup.06
mv -f $BCKDIR/backup.04 $BCKDIR/backup.05
mv -f $BCKDIR/backup.03 $BCKDIR/backup.04
mv -f $BCKDIR/backup.02 $BCKDIR/backup.03
mv -f $BCKDIR/backup.01 $BCKDIR/backup.02
mv -f $BCKDIR/backup.00 $BCKDIR/backup.01
sleep 1
}
yedek(){
# yedekleme islemi icin.
cd $BCKDIR
mkdir -p $BCKDIR/backup.00
touch $BCKDIR/backup.00
date > $BCKDIR/backup.00/$(date +%F-%H-%M).txt
rsync -a --exclude=*.sock $DATADIR $BCKDIR/backup.00/
}

eposta(){
# bilgilendirmek icin :-)
cat > $BCKDIR/mesaj.txt <<EOF

Merhaba Patron.

Yedekleme islemi tamamlanmistir.


Bilgilerinize arz ederim.

Yedek Dizini = $BCKDIR 
Tarih: $DATE

Kimgelir.com Yedekleme Servisi :-)
EOF

# mail gonderim kismi.
mail -s "yedek islemi" info@kimgelir.com < $BCKDIR/mesaj.txt
rm -f $BCKDIR/mesaj.txt
date >>$BCKDIR/tarih.txt
echo "+ ------ +" >>$BCKDIR/tarih.txt
}
# bitis.....

# 
yedekle(){
dondur
yedek
eposta
}

# - islemler
yedekle

