#!/bin/bash
# Caylak Penguen 12 Mayis 2014 Pazartesi
# Web sunucusunun ip adresini patronuna bildirmesi icin betik.
#
wget -O ip.txt http://ipecho.net/plain
IP=$(cat ip.txt)

cat >mektup.txt<<EOF
Merhaba Patron.

IP adresim : $IP

Evinizin Web Sunucusu : Raspberry Pi

Zaman Bilgisi: `date`
EOF

mail -v -s "ip adresim" FalancaFilanca@gmail.com <mektup.txt
