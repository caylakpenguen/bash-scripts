#!/bin/bash
# caylakpenguen http://www.truvalinux.org.tr
# mysql Datalarini yedekleme icin betik 14 Mayis 2016 Cumartesi
#

# dizinleri olusturmak icin.
# for i in backup.{00..30}; do mkdir $i; done

BCKDIR=/root/MySQL_Yedek
DIZIN=$(date +%F)
yedekal(){
cd $BCKDIR/backup.00
mkdir $DIZIN
for i in `cat $BCKDIR/liste.txt`
do
#echo " Yedek Alinan Db =>> $i"
mysqldump -uroot $i >$DIZIN/$i.sql
done
gzip -9 $DIZIN/*.sql >/dev/null
}

dondur(){
# en eski yedek silinsin.
	rm -rf $BCKDIR/backup.31
# Once yedek dizinleri Dondurelim.
        mv -f $BCKDIR/backup.30 $BCKDIR/backup.31
        mv -f $BCKDIR/backup.29 $BCKDIR/backup.30
        mv -f $BCKDIR/backup.28 $BCKDIR/backup.29
        mv -f $BCKDIR/backup.27 $BCKDIR/backup.28
        mv -f $BCKDIR/backup.26 $BCKDIR/backup.27
        mv -f $BCKDIR/backup.25 $BCKDIR/backup.26
        mv -f $BCKDIR/backup.24 $BCKDIR/backup.25
        mv -f $BCKDIR/backup.23 $BCKDIR/backup.24
        mv -f $BCKDIR/backup.22 $BCKDIR/backup.23
        mv -f $BCKDIR/backup.21 $BCKDIR/backup.22
        mv -f $BCKDIR/backup.20 $BCKDIR/backup.21
        mv -f $BCKDIR/backup.19 $BCKDIR/backup.20
        mv -f $BCKDIR/backup.18 $BCKDIR/backup.19
        mv -f $BCKDIR/backup.17 $BCKDIR/backup.18
        mv -f $BCKDIR/backup.16 $BCKDIR/backup.17
        mv -f $BCKDIR/backup.15 $BCKDIR/backup.16
        mv -f $BCKDIR/backup.14 $BCKDIR/backup.15
        mv -f $BCKDIR/backup.13 $BCKDIR/backup.14
        mv -f $BCKDIR/backup.12 $BCKDIR/backup.13
        mv -f $BCKDIR/backup.11 $BCKDIR/backup.12
        mv -f $BCKDIR/backup.10 $BCKDIR/backup.11
        mv -f $BCKDIR/backup.09 $BCKDIR/backup.10
        mv -f $BCKDIR/backup.08 $BCKDIR/backup.09
	mv -f $BCKDIR/backup.07 $BCKDIR/backup.08
	mv -f $BCKDIR/backup.06 $BCKDIR/backup.07
	mv -f $BCKDIR/backup.05 $BCKDIR/backup.06
	mv -f $BCKDIR/backup.04 $BCKDIR/backup.05
	mv -f $BCKDIR/backup.03 $BCKDIR/backup.04
	mv -f $BCKDIR/backup.02 $BCKDIR/backup.03
	mv -f $BCKDIR/backup.01 $BCKDIR/backup.02
	mv -f $BCKDIR/backup.00 $BCKDIR/backup.01
sleep 1
}

# Mysql Dblerini listele.
listele(){
find /var/lib/mysql/ -type d | cut -d. -f1 | cut -d/ -f5 | sort | grep -v "mysql" >$BCKDIR/liste.txt
cp $BCKDIR/liste.txt $BCKDIR/liste`date +%F`.txt
}
yedek(){
# yedekleme islemi icin.
	dondur
	cd $BCKDIR
	listele
	mkdir -p backup.00
	touch backup.00
	date > $BCKDIR/backup.00/$(date +%F-%H-%M).txt
	yedekal
}
# main
yedek


# mail gonderme kismi
echo " Merhaba Patron
$(date +%F) tarihli MySQL yedekleme islemi tamamlandi.
iyi calismalar dileriz.
Tarih: $(date)
+--------------+
DB listesi
+--------------+
" >$BCKDIR/bilgi.txt
cat $BCKDIR/liste.txt >>$BCKDIR/bilgi.txt
mail -s "Mysql Yedekleme" info@FalancaFilanca.com <$BCKDIR/bilgi.txt


