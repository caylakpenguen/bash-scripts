#!/bin/bash
#
# Lars Strand
#
# slackware.no
#
# Sun Nov 10 20:34:08 CET 2013
#

export RSYNC_PASSWORD=Sei0oona

file=/var/www/virtual/www.slackware.no/rsynclogs/slackware/rsync_`date +%Y-%m-%d`
file2=/dev/shm/slackware-syncing

# are we still sync'ing from slackware.com?
if [ ! -r $file2 ]; then
  touch $file2
  echo "
       NB! Slackware-current is syncing from slackware.com!
       Started: `date`
       " > /usit/ftp1/ftp/slackware/NB-SYNCING-FROM-SLACKWARE.COM

  # loop until we get a free slot
  status=1
  while [ $status != 0 ]
  do
    /local/bin/rsync -av --delete-after --delay-updates --hard-links \
	--links --stats \
	--exclude=NB-SYNCING-FROM-SLACKWARE.COM \
	--exclude=ls-lR* \
	--exclude=.message \
	--exclude=.bash_history \
	--exclude=slackware-1.1.2 \
	--exclude=slackware-2.0.1 \
	--exclude=slackware-2.1 \
	--exclude=slackware-2.2.0 \
	--exclude=slackware-2.3 \
	--exclude=slackware-3.0 \
	--exclude=slackware-3.1 \
	--exclude=slackware-3.3 \
	--exclude=slackware-3.4 \
	--exclude=slackware-3.5 \
	--exclude=slackware-3.6 \
	--exclude=slackware-3.9 \
	--exclude=slackware-4.0 \
	--exclude=slackware-7.0 \
	--exclude=slackware-7.1 \
	--exclude=slackware-8.0 \
	--exclude=slackware-8.1 \
	--exclude=slackware-9.0 \
	--exclude=slackware-9.1 \
	--exclude=slackware-iso \
	rsync.osuosl.org::slackware /usit/ftp1/ftp/slackware/ >> $file 2>> $file

    # not using 2>&1 | tee $file redirect because of $? 
    status=$?
    if [ $status != 0 ]
    then
      echo "
	`date`
	Sleeping 5 min...
	" >> $file
	sleep 300
    fi
  done

  # sync ISOs
  # loop until we get a free slot
  status=1
  while [ $status != 0 ]
  do
    /local/bin/rsync -av --delete-after --delay-updates --hard-links \
        --links --stats \
        --exclude=slackware-current-iso \
        --exclude=slackware-8.1-iso \
        --exclude=slackware-9.0-iso \
        --exclude=slackware-9.1-iso \
        --exclude=slackware-10.0-iso \
        --exclude=slackware-10.1-iso \
        --exclude=slackware-10.2-iso \
        --exclude=slackware-11.0-iso \
        --exclude=slackware-12.0-iso \
        --exclude=slackware-12.1-iso \
        --exclude=slackware-12.2-iso \
        --exclude=slackware-13.0-iso \
        --exclude=slackware-13.1-iso \
        --exclude=slackware-13.37-iso \
        --exclude=slackware64-13.0-iso \
        --exclude=slackware64-13.1-iso \
        --exclude=slackware64-13.37-iso \
        slackware-iso@ftp.osuosl.org::slackware-iso /usit/ftp1/ftp/slackware/slackware-iso/ >> $file 2>> $file

    # not using 2>&1 | tee $file redirect because of $?
    status=$?
    if [ $status != 0 ]
    then
      echo "
        `date`
        Sleeping 5 min...
        " >> $file
        sleep 300
    fi
  done


  # Since I'm not redirecting to stdout, and I would like to recive status in 
  # my mail, I cat the newly created file
  #cat $file

  # not all files are readable from slackware.com (ISOs) to reduce load
  chmod -R a+r /usit/ftp1/ftp/slackware/

  # make index
  cd /usit/ftp1/ftp/slackware/
  ls -lR > ls-lR
  gzip ls-lR -9 -c > ls-lR.gz

  # cleaning up
  rm /usit/ftp1/ftp/slackware/NB-SYNCING-FROM-SLACKWARE.COM
  rm $file2

fi

