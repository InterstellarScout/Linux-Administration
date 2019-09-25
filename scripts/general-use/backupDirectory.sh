#!/bin/sh
#This program backs up the a portion of a drive drive in a tar on a backup drive.

d=`date +%F`
echo What would you like to backup?
read backupDir

echo What would you like the tar to be called?
read toSave
#Backup command - exclude any mounted drives, including the one in which our backup is being made.
sudo tar -zcvf $toSave.tar.gz $backupDir

#Move to another location
#sudo cp /media/DataDrive/SystemBackup$d.tar.gz
#/var/www/html/interstellarlibrary.net/public_html/Downloads/
