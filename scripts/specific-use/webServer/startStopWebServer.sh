#!/bin/sh
#This script starts and stops the web service.

#answer = ${1?Error: no parameter given}
echo "Would you like to start or stop the webserver (on/off)?"
read answer

if [ "$answer" = "on" ];
then
        sudo /etc/init.d/mysql start #Start my sql Service
        sudo service apache2 start

elif [ "$answer" = "off" ];
then
        sudo /etc/init.d/mysql stop #Stop my sql Service
        sudo service apache2 stop
fi
