#!/bin/bash
#This file is meant to be run as a crontab. It will check the current md5 against the previous to see if there is a change.
#If a change is detected, it notifies reportProblem.sh to log and email it.

FILE=`pwd`/md5Log.log
if test -f "$FILE"; then
    #The file exists. Get the current md5 and compare it to the previous entry.
    currentMD5=`md5sum /etc/passwd` | awk '{ print $1 }'
    previousResults=`cat "previousMD5"`

    if [ "$currentMD5" != "$previousResults" ];
    then
      #change found - report it.
      bash ../reportProblem.sh 1
    fi
else
  #The files does not exist - create it.
  currentMD5=`md5sum /etc/passwd` | awk '{ print $1 }'
   echo "`date '+%d/%m/%Y_%H:%M:%S'` /etc/passwd ${currentMD5}" >> md5Log.log #add to log
  echo `md5sum /etc/passwd` | awk '{ print $1 }' >> previousMD5 #create first log
fi


