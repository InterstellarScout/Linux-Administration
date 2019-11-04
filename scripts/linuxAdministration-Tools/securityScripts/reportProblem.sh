#!/bin/sh
#This program is used to email a warning to the admin email.
function sendEmail {
  #$1 Subject
  #$2 Body
  echo Sending email
  #mail -s 'Message Subject' -a From:Admin\<admin@interstellarlibrary.net\> das097@gmail.com <<< 'testing message'
  mail -s ${1} -a From:${fromName}\<${fromEmail}\> ${toEmail} <<< ${2}
}

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

#The following variable is specified to later choose what alert level will be used for each error.
alert=0

#If the variable is empty, the program will end - nothing to do.
if [ -z "$1" ]
then
      echo No error message was recieved.
      exit 0
else
      echo "The error is $1"
fi

#Errors are handed out by error codes. New errors need to be generated below.
if [ "$errMessage" == "0" ]; #Error Test - if 1 is recieved, an email will be sent saying everything is all set.
then
  body="Server ${host} Alert.
  Hello Moderator,
  You are recieving this message because your email address has been added to the alerting dashboard. To be removes, please contact your administrator.

  Error Message:
  ${1}
  Everything is okay. You're doing a good job. Keep up the good work.

  Thank you,
  ${host}
  "
  alert=4
fi

#The following defines the subject
if [ "alert" == "4" ];
then
subject="Server ${host} Information" #AlertLevel4 - Informational
elif [ "alert" == "3" ];
then
subject="Server ${host} Warning" #AlertLevel3 - Warning
elif [ "alert" == "2" ];
then
subject="Server ${host} Alert" #AlertLevel2 - Alert
elif [ "alert" == "1" ];
then
subject="Server ${host} Critical Alert" #AlertLevel1 - Critical
fi

#Send the email
sendEmail $subject "This is an error"

