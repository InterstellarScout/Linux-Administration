#!/bin/sh
#This program is used to email a warning to the admin email.
#usage bash reportProblem.sh {errorCode}
#Alerts 1 and 2 send emails where all of them add to the log.
#Log Outline
#01-01-0101 2400 (Date) Critical-ALert(subject) Tester Variable(origin) Error Message: 0(errorBody) Everything is okay. You're doing a good job. Keep up the good work.(errorInfo)

######################################################################################
##################################    Functions    ###################################
######################################################################################
sendEmail() {
  #$1 Subject
  #$2 Body
  echo Sending email
  #mail -s 'Message Subject' -a From:Admin\<admin@interstellarlibrary.net\> das097@gmail.com <<< 'testing message'
  mail -s ${subject} -a From:${fromName}\<${fromEmail}\> ${toEmail} <<< ${body}
}

appendLogs() {
  #$1 subject
  #$2 origin
  #$3 errorBody
  #$4 errorInfo
  #01-01-0101 2400 (Date) Critical-ALert(subject) Tester Variable(origin) Error Message: 0(errorbody) Everything is okay. You're doing a good job. Keep up the good work.(errorInfo)
  echo Writing Log
  #This log is stored in the folder in which this it run.
  FILE=`pwd`/security.log
  if [ -f "$FILE" ];
  then
    #echo "`date '+%d/%m/%Y %H:%M:%S'` ${1} ${2} ${3} ${4}" >> $FILE
    echo "`date '+%d/%m/%Y %H:%M:%S'` ${subject} ${origin} ${errorBody} ${errorInfo}" >> $FILE
  else
    touch $FILE
    #echo "`date '+%d/%m/%Y %H:%M:%S'` ${1} ${2} ${3} ${4}" >> $FILE
    echo "`date '+%d/%m/%Y %H:%M:%S'` ${subject} ${origin} ${errorBody} ${errorInfo}" >> $FILE
  fi
}

######################################################################################
##############################    Variable Setup    ##################################
######################################################################################
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
mainFooter="
Thank you,
${host}"

#The following variable is specified to later choose what alert level will be used for each error.
alert=0

######################################################################################
####################################    Main    ######################################
######################################################################################
#If the variable is empty, the program will end - nothing to do.
if [ -z "$1" ]
then
      echo No error message was recieved.
      exit 0
else
      echo "The error is $errMessage"
fi

##############################################################################
#Errors are handed out by error codes. New errors need to be generated below.#
##############################################################################
if [ "$errMessage" = "0" ]; #Error Test - if 1 is recieved, an email will be sent saying everything is all set.
then
  errorBody="Error Message: ${1}"
  errorInfo="Everything is okay. You're doing a good job. Keep up the good work."
  #Required Variables for each program that will be using this.
  alert=4
  origin="Test Variable"
  #Use optional secondary if neccessary
  #progVar=$2

elif [ "$errMessage" = "1" ]; #Change detected on passwd file
then
  errorBody="Error Message: ${1}"
  errorInfo="Alert: A change has been detected on the passwd file. A user may have been created. Authorized?"
  #Required Variables for each program that will be using this.
  alert=2
  origin="Passwd Alert"

fi

body=${mainHeader}${errorBody}${errorInfo}${mainFooter}

#The following defines the subject
if [ "$alert" = "4" ];
then
  #AlertLevel4 - Informational
  subject="Server-${host}-Information"
  #Append the Log
  #appendLogs $subject $origin $errorbody $errorInfo
  appendLogs $subject $origin $errorBody $errorInfo

elif [ "$alert" = "3" ];
then
  #AlertLevel3 - Warning
  subject="Server-${host}-Warning"
  #Append the Log
  #appendLogs $subject $origin $errorbody $errorInfo
  appendLogs $subject $origin $errorBody $errorInfo

elif [ "$alert" = "2" ];
then
  #AlertLevel2 - Alert
  subject="Server-${host}-Alert"
  #Send an email
  sendEmail $subject $body
  #Append the Log
  #appendLogs $subject $origin $errorbody $errorInfo
  appendLogs $subject $origin $errorBody $errorInfo

elif [ "$alert" = "1" ];
then
  #AlertLevel1 - Critical
  subject="Server-${host}-Critical-Alert"
  #Send the email
  sendEmail $subject $body
  #Append the Log
  #appendLogs $subject $origin $errorbody $errorInfo
  appendLogs $subject $origin $errorBody $errorInfo

fi
