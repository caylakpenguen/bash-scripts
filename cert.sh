#!/bin/bash
# Caylakpenguen
# Selfsinged SSL sertifika üretir.
# apache Nginx ve Eposta sunucularında kullanılabilir Sertifika üretir.
# cert icin betik - Cts 02 Eyl 2017 13:33:35 +03
# Lisans: Gnu/Gpl
# kullanim sekli: ./cert.sh domain.com admin 

DOM="$1"


openssl req -new -x509 -days 3650 -nodes \
    -out "$DOM.crt" \
    -newkey rsa:2048 \
    -keyout "$DOM.key"<<EOF
TR
Istanbul
Istanbul
Development
Development
$DOM
$2@$DOM

EOF



