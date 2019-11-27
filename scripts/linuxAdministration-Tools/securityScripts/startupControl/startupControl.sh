#!/bin/bash
#This program is made to give the user control over their startup services and daemons.

function eprograms {
    echo "================================================================="
    echo "=======================Enabeled Programs:========================"
    echo "================================================================="
    if [ -f /etc/redhat-release ]; then #If redhat or Cent OS
        systemctl list-unit-files --type=service | awk {' if ($2 =="enabled") printf ("%5s\t%s\n", $2, substr($1, 1, length($1)-8))'}
    fi

    if [ -f /etc/lsb-release ]; then #If ubuntu
        service --status-all | awk {' if ($2 =="+") printf ("%5s\t%s\n", $2, $4)'}
    fi
    echo "Press \"Enter\" to continue"
    read go
    }

function dprograms {
    echo "================================================================="
    echo "======================Disabeled Programs:========================"
    echo "================================================================="
    if [ -f /etc/redhat-release ]; then #If redhat or Cent OS
        systemctl list-unit-files --type=service | awk {' if ($2 =="enabled") printf ("%5s\t%s\n", $2, substr($1, 1, length($1)-8))'}
    fi

    if [ -f /etc/lsb-release ]; then #If ubuntu
        service --status-all | awk {' if ($2 =="+") printf ("%5s\t%s\n", $2, $4)'}
    fi
    echo "Press \"Enter\" to continue"
    read go
  }

function stopService {
  echo "What service would you like to stop?"
  echo "Enter the exact name of the service shown above."
  read toStop
  sudo systemctl stop $toStop
  echo $toStop has been stopped
  echo "Press \"Enter\" to continue"
  read go
}

function startService {
  echo "What service would you like to stop?"
  echo "Enter the exact name of the service shown above."
  read toStart
  sudo systemctl start $toStart
  echo $toStart has been started
  echo "Press \"Enter\" to continue"
  read go
}

function enableService {
  echo "What service would you like to stop?"
  echo "Enter the exact name of the service shown above."
  read toStart
  sudo systemctl enable $toStart
  echo $toStart has been enabeled
  echo "Press \"Enter\" to continue"
  read go
}

function disableService {
  echo "What service would you like to stop?"
  echo "Enter the exact name of the service shown above."
  read toStart
  sudo systemctl disable $toStart
  echo $toStart has been disabeled
  echo "Press \"Enter\" to continue"
  read go
}

function startup {
  clear
  echo Welcome to Startup Control
  echo Would you like to view enabeled \(e\), disabeled \(d\), or all \(a\) services?
  echo Would you like to start \(s\) or stop \(st\) service?
  echo Would you like to prevent a program from starting on startup \(p\)?
  echo Would you like to allow a program to start on startup \(l/L\)?
  echo Press any other key to exit.
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
      echo Goodbye!
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