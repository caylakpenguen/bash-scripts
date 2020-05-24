#!/bin/bash
# caylakpenguen
# Paz 24 May 2020 17:18:38 +03 
# Disk Doluluk Kontrolu....
# Disk dolulugu belirli seviyeyi gectiginde
# ilgili kisiye bildirim gonderir.
#cron gorevi icin girdi. 15 dakikada bir calisir.
# */15 * * * * /opt/disk.sh

#Tarih
TARIH=$(date '+%F-%H-%M')
## Sistem Kok Bolumu
DISKADI="/dev/sda1"

## Kime Eposta Gonderilecek...
KIME="admin@local.lan"

#data dosyasi...
MAILFILE="/tmp/eposta.txt"
DISKUSE="/tmp/diskdf.txt"
# % de olarak hesaplanir.
SINIR="90"

kontrol(){

df -h | grep "$DISKADI" | awk '{ print $5}' > $DISKUSE

DURUM=$(cat $DISKUSE | cut -f1 -d\%)

if [ $DURUM -ge $SINIR ]; then
        echo "UYARI! Disk Kullanimi % $SINIR" > $MAILFILE
        echo "" >> $MAILFILE

        echo "Sistem Disk doluluk orani. % $DURUM " >> $MAILFILE
	echo "Sistem Diskinizi kontrol ediniz." >> $MAILFILE
        echo "" >> $MAILFILE
        echo "iyi calismalar..." >> $MAILFILE
	echo "$(hostname)" >> $MAILFILE
	echo "Tarih:  $TARIH ." >> $MAILFILE
        mail -s "UYARI! Disk Kullanimi 90%" $KIME < $MAILFILE
	rm -f $MAILFILE $DISKUSE
	
fi
}

#
kontrol
