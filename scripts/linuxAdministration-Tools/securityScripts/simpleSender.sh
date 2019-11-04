#!/bin/bash

#To change the admin email, change the below line:
toEmail=das097@gmail.com
#To change the from user, change the below line:
fromName=Admin
#To change the from email address, change the below line:
fromEmail=admin@interstellarlibrary.net
#The following defines what warning will be sent to the admin.
errMessage=$1
#The following is the hostname of this computer to be used in the subject
host=`hostname`

body="Server `hostname` Alert.
  Hello Moderator,
  You are recieving this message because your email address has been added to the alerting dashboard. To be removes, please contact your administrator.
  Error Message:
  ${1}
  Everything is okay. You're doing a good job. Keep up the good work.
  Thank you,
  `hostname`
  "

subject="Server-${host}-Information"

echo mail -s ${subject} -a From:${fromName}\<${fromEmail}\> ${toEmail} ${body}
$mail -s ${subject} -a From:${fromName}\<${fromEmail}\> ${toEmail} <<< ${body}
