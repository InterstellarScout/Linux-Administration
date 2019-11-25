#!/bin/bash
#This file is meant to be run as a crontab. It will check the current md5 against the previous to see if there is a change.
#If a change is detected, it notifies reportProblem.sh to log and email it.
#Usage ./directoryChecker.sh /directory

FILE=`pwd`/md5Log${1}.log
checkedDirectory=$1

if test -f "$FILE"; then
    #The file exists. Get the current md5 and compare it to the previous entry.
    #currentMD5=`md5sum /etc/passwd` | awk '{ print $1 }'
    currentMD5=`find checkedDirectory -type f -print0 | sort -z | xargs -0 sha1sum | sha1sum`
    previousResults=`cat "previousMD5"`

    if [ "$currentMD5" != "$previousResults" ];
    then
      #change found - report it.
      bash ../reportProblem.sh 2 $checkedDirectory
    fi
else
  #The files does not exist - create it.
  currentMD5=`find checkedDirectory -type f -print0 | sort -z | xargs -0 sha1sum | sha1sum`
  #currentMD5=`md5sum /etc/passwd` | awk '{ print $1 }'
   echo "`date '+%d/%m/%Y_%H:%M:%S'` /etc/passwd ${currentMD5}" >> md5Log.log #add to log
  echo `find checkedDirectory -type f -print0 | sort -z | xargs -0 sha1sum | sha1sum` | awk '{ print $1 }' >> previousMD5 #create first log
fi


