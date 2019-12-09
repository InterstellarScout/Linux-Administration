directoryChecker.sh
Usage: <i>sudo bash directoryChecker.sh {path to directory}</i>

Recurring Usage: Run this command as a cron tab. 

This program is meant to run in a cron job. This guide will show you how to deploy it. 
The objective of this program is to inform the admin that the passwd file has been changed. Is an account is changed without notice, it may suggest a hacker’s attempt to access. 
How does crontab work?
 
<b>* * * * *  command to execute</b>

 │ │ │ │ │

 │ │ │ │ │

 │ │ │ │ └─ day of week (0 - 6) 

 │ │ │ └────────── month (1 - 12)

 │ │ └─────────────── day of month (1 - 31)

 │ └──────────────────── hour (0 - 23)

 └───────────────────────── min (0 - 59)

Special Strings:
Entry	Description	Equivalent to	Example
@yearly (or @annually)	Run once a year at midnight on January 1	0 0 1 1 *	@yearly php /home/example_username/mail.php
@monthly	Run once a month at midnight on the first day of the month	0 0 1 * *	@monthly php /home/example_username/mail.php
@weekly	Run once a week at midnight on Sunday morning	0 0 * * 0	@weekly php /home/example_username/mail.php
@daily (or @midnight)	Run once a day at midnight	0 0 * * *	@daily php /home/example_username/mail.php
@hourly	Run once an hour at the beginning of the hour	0 * * * *	@hourly php /home/example_username/mail.php
@reboot	Run at startup (of the cron daemon)	@reboot	@reboot php /home/example_username/mail.php

To create a cron job:
Before you start, make sure you have administrator privileges. 
Option 1:
sudo crontab -e
Note: If you do not run with sudo, it will be added with the privileges as the user running this command. This program will not work if you are not sudo. 

Choose the editor of your choice by entering the number the corresponds with the editor. 
Once chosen, enter the command that we will be using. The below example runs hourly. If that is not what you want, see below to choose the proper timetable. 
0 * * * *  bash /home/{user}/Linux-Administration/scripts/linuxAdministration-Tools/securityScripts/directoryChecker/directoryChecker.sh {directory to check}
Example Command – Check at the top of the hour, each hour:
0 * * * *  bash /home/user/Linux-Administration/scripts/linuxAdministration-Tools/securityScripts/directoryChecker/directoryChecker.sh /var/www/html

 
Enter the command on the bottom, then save and quit. Once completed, it should tell you that it is installing the new crontab. 
 
Option 2:
First, access the crontab file which is referenced by the system to run jobs.
sudo nano /etc/crontab
 
To make this program run hourly, use the command:
* * * * * program path-to-file
Example:
0 * * * * bash /home/{user}/Linux-Administration/scripts/linuxAdministration-Tools/securityScripts/directoryChecker/directoryChecker.sh {path to directory}
Note: Once this cronjob is created, it is a good idea to make sure the program being run is always the same. 

Done.
If the directory that you chose to monitor is different the next time it is checked, an email is sent to the email listed in the reportproblem.sh file. 
 

