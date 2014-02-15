#!/bin/bash
# 12 - 02 - 2014  CaylakPenguen
rsync -av -h --del --stats \
	--exclude=14.0/* \
	rsync://rsync.slackware.org.uk/msb/  $HOME/iso/Slackware/mateSB/ > $HOME/iso/Slackware/Loglar/rsync-mate-log-`date +%F-%H-%M`.txt
