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

function stopService {
  echo "What service would you like to stop?"
  echo "Enter the exact name of the service shown above."
  read toStop
  sudo systemctl stop $toStop
  echo $toStop has been started
}

function startService {
  echo "What service would you like to stop?"
  echo "Enter the exact name of the service shown above."
  read toStart
  sudo systemctl start $toStart
  echo $toStart has been started
}

function enableService {
  echo "What service would you like to stop?"
  echo "Enter the exact name of the service shown above."
  read toStart
  sudo systemctl enable $toStart
  echo $toStart has been enabeled
}

function disableService {
  echo "What service would you like to stop?"
  echo "Enter the exact name of the service shown above."
  read toStart
  sudo systemctl disable $toStart
  echo $toStart has been disabeled
}

function startup {
  clear
  echo Welcome to Startup Control
  echo Would you like to view enabeled \(e\), disabeled \(d\), or all \(a\) services?
  echo Would you like to start \(s\) or stop \(st\) service?
  echo Would you like to prevent a program from starting on startup \(p\)?
  echo Would you like to allow a program to start on startup \(l/L\)?
  read answer
  if [[ "$answer" == "e" ]] || [[ "$answer" == "E" ]] || [[ "$answer" == "enable" ]] || [[ "$answer" == "Enable" ]];
    then
      eprograms #run enabeled programs
      startup
  elif [[ "$answer" == "d" ]] || [[ "$answer" == "D" ]] || [[ "$answer" == "disable" ]] || [[ "$answer" == "Disable" ]];
    then
      dprograms #run disabeled programs
      startup
  elif [[ "$answer" == "a" ]] || [[ "$answer" == "A" ]] || [[ "$answer" == "all" ]] || [[ "$answer" == "All" ]];
    then
      eprograms #run enabeled programs
      dprograms #run disabeled programs
      startup
  elif [[ "$answer" == "s" ]] || [[ "$answer" == "S" ]] || [[ "$answer" == "start" ]] || [[ "$answer" == "Start" ]];
    then
      eprograms #run enabeled programs
      startService
      startup
  elif [[ "$answer" == "st" ]] || [[ "$answer" == "St" ]] || [[ "$answer" == "stop" ]] || [[ "$answer" == "Stop" ]];
    then
      dprograms #run disabeled programs
      stopService
      startup
  elif [[ "$answer" == "p" ]] || [[ "$answer" == "P" ]] || [[ "$answer" == "prevent" ]] || [[ "$answer" == "Prevent" ]];
    then
      eprograms #run enabeled programs
      enableService #run enabeled programs
      startup
  elif [[ "$answer" == "l" ]] || [[ "$answer" == "L" ]] || [[ "$answer" == "allow" ]] || [[ "$answer" == "Allow" ]];
    then
      dprograms #run disabeled programs
      disableService #run enabeled programs
      startup
    else
      echo Incorrect input.
      exit 1
    fi
}

#########################################################################
###############################Start Script##############################
#########################################################################

#Run as Root
if [ "$(whoami)" != "root" ]; then
        echo "Sorry, you are not root."
        exit 1
fi

startup