#!/bin/bash
#Dean Sheldon
#This script is used to backup your firewall to the specified location.

#Run as Root
if [ "$(whoami)" != "root" ]; then
        echo "Sorry, you are not root."
        exit 1
fi

clear
echo "______ _                        _ _  ______            _
|  ___(_)                      | | | | ___ \          | |
| |_   _ _ __ _____      ____ _| | | | |_/ / __ _  ___| | ___   _ _ __
|  _| | | '__/ _ \ \ /\ / / _\` | | | | ___ \/ _\` |/ __| |/ / | | | '_
| |   | | | |  __/\ V  V / (_| | | | | |_/ / (_| | (__|   <| |_| | |_) |
\_|   |_|_|  \___| \_/\_/ \__,_|_|_| \____/ \__,_|\___|_|\_\\__,_| .__/
                                                                 | |
                                                                 |_| "
echo Welcome to Firewall Backup
echo Would you like to backup or restore your IPTables? \(B/R\)
read answer

if [[ "$answer" == "B" ]] || [[ "$answer" == "b" ]] || [[ "$answer" == "backup" ]] || [[ "$answer" == "Backup" ]];
then
  ### Save all rules ###
  echo Backing up your firewall...
  echo Your firewall is being backed up to a folder called \"firewall\" in this machine\'s main directory.
  [ ! -d "/firewall" ] && sudo mkdir /firewall
  sudo iptables-save > /firewall/dsl.fw
  echo Your firewall has been saved.

elif [[ "$answer" == "R" ]] || [[ "$answer" == "r" ]] || [[ "$answer" == "restore" ]] || [[ "$answer" == "Restore" ]];
  then
    ### Restore saved rules ###
    [ ! -d "/firewall" ] && echo "Firewall file does not exist"
    iptables-restore < /firewall/dsl.fw
    echo Your firewall has been restored.

else
  echo Something has gone wrong.
fi