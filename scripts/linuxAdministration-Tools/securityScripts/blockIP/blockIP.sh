#!/bin/bash
#This program is used to block of unblock the given IP Address
#Usage sudo comHardenFirewall.sh {allow/block} {ip-address}
#$1 - block or unblock
#$2 - ip-address
IPAddress=$2
if [ "$1" == "block" ];
then
  action=A
else
  action=D
fi

    if [[ $IPAddress =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; #confirm that the IPAddress is authentic.
    then
      sudo iptables -$action INPUT -s $IPAddress -j DROP
    else
      exit 0
    fi

    if [[ "$action" == "A" ]]
    then
      echo IP Address $IPAddress has been blocked.
    elif [[ "$action" == "D" ]]
    then
      echo IP Address $IPAddress has been unblocked.
    else
      echo Something went wrong with your action variable.
      exit 1
    fi