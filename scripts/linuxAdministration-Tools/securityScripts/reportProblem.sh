#!/bin/sh
#This program is used to email a warning to the admin email.
sendEmail() {
  #$1 Subject
  #$2 Body
  echo Sending email
  #mail -s 'Message Subject' -a From:Admin\<admin@interstellarlibrary.net\> das097@gmail.com <<< 'testing message'
  mail -s ${subject} -a From:${fromName}\<${fromEmail}\> ${toEmail} <<< ${body}
}

appendLogs() {
  #$1 Subject
  #$2 Body
  echo Writing Log
  echo date '+%d/%m/%Y %H:%M:%S' ${subject}
}

#To change the admin email, change the below line:
toEmail=das097@gmail.com
#To change the from user, change the below line:
fromName=Admin
#To change the from email address, change the below line:
fromEmail=admin@interstellarlibrary.net
#The following defines what warning will be sent to the admin.
errMessage="$1"
#The following is the hostname of this computer to be used in the subject
host=`hostname`
#The following contains the standard mainbody of an email sent by the error.
mainHeader="Server ${host} Alert.
Hello Moderator,
You are recieving this message because your email address has been added to the alerting dashboard. To be removes, please contact your administrator.
`date '+%d/%m/%Y %H:%M:%S'`
"
mainFooter="Thank you,
${host}"

#The following variable is specified to later choose what alert level will be used for each error.
alert=0

#If the variable is empty, the program will end - nothing to do.
if [ -z "$1" ]
then
      echo No error message was recieved.
      exit 0
else
      echo "The error is $errMessage"
fi
#############################################################################
#Errors are handed out by error codes. New errors need to be generated below.
#############################################################################
if [ "$errMessage" = "0" ]; #Error Test - if 1 is recieved, an email will be sent saying everything is all set.
then
  errorBody="Error Message:
${1}
Everything is okay. You're doing a good job. Keep up the good work.
${mainFooter}"
  #Required Variables for each program that will be using this.
  alert=4
  origin="Tester Variable"
  #Use optional secondary if neccessary
  #progVar=$2
elif [ "$errMessage" = "1" ]; #Change detected on passwd file
then
  errorBody="${mainHeader}
Error Message:
${1}
Alert: A change has been detected on the passwd file. A user may have been created. Authorized?
${mainFooter}"
  #Required Variables for each program that will be using this.
  alert=2
  origin="Passwd Alert"
fi

body=${mainHeader}${errorBody}${mainFooter}

#The following defines the subject
if [ "$alert" = "4" ];
then
subject="Server-${host}-Information" #AlertLevel4 - Informational
elif [ "$alert" = "3" ];
then
subject="Server-${host}-Warning" #AlertLevel3 - Warning
elif [ "$alert" = "2" ];
then
subject="Server-${host}-Alert" #AlertLevel2 - Alert
elif [ "$alert" = "1" ];
then
subject="Server-${host}-Critical-Alert" #AlertLevel1 - Critical
fi

#Send the email
  sendEmail $subject $body

  #echo Sending email
  #mail -s 'Message Subject' -a From:Admin\<admin@interstellarlibrary.net\> email@email.com <<< 'testing message'
  #echo mail -s ${subject} -a From:${fromName}\<${fromEmail}\> ${toEmail} ${body}
  #mail -s ${subject} -a From:${fromName}\<${fromEmail}\> ${toEmail} <<< ${body}
  #echo ${body} | mail -s ${subject} -a From:${fromName}\<${fromEmail}\> ${toEmail}
