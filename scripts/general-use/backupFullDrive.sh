#!/bin/sh
#This program backs up the entire drive in a tar on a backup drive.
if [ "$(whoami)" != "root" ]; then
        echo "Sorry, you are not root."
        exit 1
fi

d=`date +%F`

#Backup command - exclude any mounted drives, including the one in which our backup is being made.

cd /

sudo tar -zcvf SystemBackup${d}.tar.gz --exclude=/media/ --one-file-system /

#Move to another location
#sudo cp /media/DataDrive/SystemBackup$d.tar.gz
#/var/www/html/interstellarlibrary.net/public_html/Downloads/
