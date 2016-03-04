#!/bin/bash
# 10 mayis 2015 caylakpenguen
# Wordpress Db yedegi icin
wp_yedek(){
	cd /root/yedek/
	wpdata=/root/yedek/wordpress-$(date +%F-%H-%M).sql
	mysqldump -uroot -pPAROLA _xyz_blogs > $wpdata
	gzip -9 $wpdata
}

tuxweet(){
        cd /root/yedek/
        tuxweetdb=/root/yedek/tuxweet-$(date +%F-%H-%M).sql
        mysqldump -uroot -pPAROLA _Pr4nga5_tuxweet > $tuxweetdb
        gzip -9 $tuxweetdb
}

forum(){
        cd /root/yedek/
        forumdb=/root/yedek/truva-forum-$(date +%F-%H-%M).sql
        mysqldump -uroot -pPAROLA forums > $forumdb
        gzip -9 $forumdb
}

url(){
        cd /root/yedek/
        urldb=/root/yedek/troyaURL-$(date +%F-%H-%M).sql
        mysqldump -uroot -pPAROLA _yxcdfgt_troyaURL > $urldb
        gzip -9 $urldb
}


# *** betik ***
wp_yedek
tuxweet
# forum db yedek islemi simdilik kapalidir. 24 - 02 - 2016
#forum
url


# Login olanlari kaydedelim :D

echo "+----------------+">>/root/last.txt
date >>/root/last.txt
echo "+----------------+">>/root/last.txt
last >>/root/last.txt


# Kimgelir Yedekleme Servisi :-)
# 2 Mart ta eklendi.
/root/yedekle-kimgelir.sh

/root/yedekle-sistem.sh
