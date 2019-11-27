#!/bin/bash
#This program is made to give the user control over their startup services and daemons.

function eprograms {
    echo "================================================================="
    echo "=======================Enabeled Programs:========================"
    echo "================================================================="
    service --status-all | awk {' if ($2 =="+") printf ("%5s\t%s\n", $2, $4)'}
    }

function dprograms {
    echo "================================================================="
    echo "======================Disabeled Programs:========================"
    echo "================================================================="
    service --status-all | awk {' if ($2 =="-") printf ("%5s\t%s\n", $2, $4)'}
  }

#########################################################################
############################Start Script###############################
#########################################################################

#Run as Root
if [ "$(whoami)" != "root" ]; then
        echo "Sorry, you are not root."
        exit 1
fi


echo Welcome to Startup Control
echo Would you like to view enabeled \(e\), disabeled \(d\), or all \(a\) services?
read answer
if [[ "$answer" == "e" ]] || [[ "$answer" == "E" ]] || [[ "$answer" == "enable" ]] || [[ "$answer" == "Enable" ]];
  then
    eprograms #run enabeled programs
elif [[ "$answer" == "d" ]] || [[ "$answer" == "D" ]] || [[ "$answer" == "disable" ]] || [[ "$answer" == "Disable" ]];
  then
    dprograms #run disabeled programs
elif [[ "$answer" == "a" ]] || [[ "$answer" == "A" ]] || [[ "$answer" == "all" ]] || [[ "$answer" == "All" ]];
  then
    eprograms #run enabeled programs
    dprograms #run disabeled programs
  else
    echo Incorrect input.
    exit 1
  fi


service --status-all | awk {'printf ("%5s\t%s\n", $2, $4)'} >> thing.txt