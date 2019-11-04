#!/bin/bash
#Example Crontab syntax:
#* * * * * /path/to/command arg1 arg2

#Run as Root
if [ "$(whoami)" != "root" ]; then
        echo "Sorry, you are not root."
        exit 1
fi

#Check if the following has been added to the file

#Add the needed rules for cronjobs

