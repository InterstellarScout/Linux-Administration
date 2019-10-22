#!/bin/bash
#Dean Sheldon
#This script is used edit entries within your firewall. You can both add and remove entries depending on your needs.
function quit {
  exit 1
}

function Rules {
  #Variable answer is used to choose which rule to enable
  answer=$1
  action=$2
  if [[ "$answer" == "q" ]] || [[ "$answer" == "Q" ]] || [[ "$answer" == "quit" ]] || [[ "$answer" == "Quit" ]];
  then
    exit 1
  fi

  elif [[ "$answer" == 1 ]];
  then
    sudo iptables -L -nv --line-number
  elif [[ "$answer" == 2 ]];
  then
    ### Block Pings ###
    sudo iptables -$action INPUT -p icmp --icmp-type echo-request -j DROP
    sudo iptables -$action OUTPUT -p icmp --icmp-type echo-reply -j DROP
    if [[ "$action" == "A" ]]
    then
      echo Pings are now blocked.
    elif [[ "$action" == "D" ]]
    then
      echo Pings are now allowed.
    else
      echo Something went wrong with your action variable.
      exit 1
    fi

  elif [[ "$answer" == 3 ]];
  then
    ### 3: Drop invalid packets ###
    sudo /sbin/iptables -t mangle -A PREROUTING -m conntrack --ctstate INVALID -j DROP
    if [[ "$action" == "A" ]]
    then
      echo Invalid packets are now blocked.
    elif [[ "$action" == "D" ]]
    then
      echo Invalid are now allowed.
    else
      echo Something went wrong with your action variable.
      exit 1
    fi

  elif [[ "$answer" == 4 ]];
  then
    ### 4: Drop TCP packets that are new and are not SYN ###
    sudo /sbin/iptables -t mangle -$action PREROUTING -p tcp ! --syn -m conntrack --ctstate NEW -j DROP
    if [[ "$action" == "A" ]]
    then
      echo TCP Packets that are not and are not SYN are now blocked.
    elif [[ "$action" == "D" ]]
    then
      echo TCP Packets that are not and are not SYN are now allowed.
    else
      echo Something went wrong with your action variable.
      exit 1
    fi

  elif [[ "$answer" == 5 ]];
  then
    ### 5: Drop SYN packets with suspicious MSS value ###
    sudo /sbin/iptables -t mangle -$action PREROUTING -p tcp -m conntrack --ctstate NEW -m tcpmss ! --mss 536:65535 -j DROP
    if [[ "$action" == "A" ]]
    then
      echo SYN packets with suspicious MSS value are now blocked.
    elif [[ "$action" == "D" ]]
    then
      echo SYN packets with suspicious MSS value are now allowed.
    else
      echo Something went wrong with your action variable.
      exit 1
    fi

  elif [[ "$answer" == 6 ]];
  then
    ### 6: Block packets with bogus TCP flags ###
    sudo /sbin/iptables -t mangle $action PREROUTING -p tcp --tcp-flags FIN,SYN,RST,PSH,ACK,URG NONE -j DROP
    sudo /sbin/iptables -t mangle -$action PREROUTING -p tcp --tcp-flags FIN,SYN FIN,SYN -j DROP
    sudo /sbin/iptables -t mangle -$action PREROUTING -p tcp --tcp-flags SYN,RST SYN,RST -j DROP
    sudo /sbin/iptables -t mangle -$action PREROUTING -p tcp --tcp-flags FIN,RST FIN,RST -j DROP
    sudo /sbin/iptables -t mangle -$action PREROUTING -p tcp --tcp-flags FIN,ACK FIN -j DROP
    sudo /sbin/iptables -t mangle -$action PREROUTING -p tcp --tcp-flags ACK,URG URG -j DROP
    sudo /sbin/iptables -t mangle -$action PREROUTING -p tcp --tcp-flags ACK,FIN FIN -j DROP
    sudo /sbin/iptables -t mangle -$action PREROUTING -p tcp --tcp-flags ACK,PSH PSH -j DROP
    sudo /sbin/iptables -t mangle -$action PREROUTING -p tcp --tcp-flags ALL ALL -j DROP
    sudo /sbin/iptables -t mangle -$action PREROUTING -p tcp --tcp-flags ALL NONE -j DROP
    sudo /sbin/iptables -t mangle -$action PREROUTING -p tcp --tcp-flags ALL FIN,PSH,URG -j DROP
    sudo /sbin/iptables -t mangle -$action PREROUTING -p tcp --tcp-flags ALL SYN,FIN,PSH,URG -j DROP
    sudo /sbin/iptables -t mangle -$action PREROUTING -p tcp --tcp-flags ALL SYN,RST,ACK,FIN,URG -j DROP
    if [[ "$action" == "A" ]]
    then
      echo Packets with bogus TCP flags are now blocked.
    elif [[ "$action" == "D" ]]
    then
      echo SYN packets with suspicious MSS value are now be allowed.
    else
      echo Something went wrong with your action variable.
      exit 1
    fi

  elif [[ "$answer" == 7 ]];
  then
    ### 7: Block spoofed packets ###
    sudo /sbin/iptables -t mangle -$action PREROUTING -s 224.0.0.0/3 -j DROP
    sudo /sbin/iptables -t mangle -$action PREROUTING -s 169.254.0.0/16 -j DROP
    sudo /sbin/iptables -t mangle -$action PREROUTING -s 172.16.0.0/12 -j DROP
    sudo /sbin/iptables -t mangle -$action PREROUTING -s 192.0.2.0/24 -j DROP
    sudo /sbin/iptables -t mangle -$action PREROUTING -s 192.168.0.0/16 -j DROP
    sudo /sbin/iptables -t mangle -$action PREROUTING -s 10.0.0.0/8 -j DROP
    sudo /sbin/iptables -t mangle -$action PREROUTING -s 0.0.0.0/8 -j DROP
    sudo /sbin/iptables -t mangle -$action PREROUTING -s 240.0.0.0/5 -j DROP
    sudo /sbin/iptables -t mangle -$action PREROUTING -s 127.0.0.0/8 ! -i lo -j DROP
    if [[ "$action" == "A" ]]
    then
      echo Spoofed packets are now blocked.
    elif [[ "$action" == "D" ]]
    then
      echo Spoofed packets are now be allowed.
    else
      echo Something went wrong with your action variable.
      exit 1
    fi

  elif [[ "$answer" == 8 ]];
  then
    ### 8: Drop ICMP (you usually don't need this protocol) ###
    sudo /sbin/iptables -t mangle -$action PREROUTING -p icmp -j DROP
    if [[ "$action" == "A" ]]
    then
      echo ICMP is now blocked.
    elif [[ "$action" == "D" ]]
    then
      echo ICMP is now allowed.
    else
      echo Something went wrong with your action variable.
      exit 1
    fi

  elif [[ "$answer" == 9 ]];
  then
    ### 9: Drop fragments in all chains ###
    sudo /sbin/iptables -t mangle -$action PREROUTING -f -j DROP
    if [[ "$action" == "A" ]]
    then
      echo Drop fragments in all chains are now blocked.
    elif [[ "$action" == "D" ]]
    then
      echo Drop fragments in all chains are now be allowed.
    else
      echo Something went wrong with your action variable.
      exit 1
    fi

  elif [[ "$answer" == 10 ]];
  then
    ### 10: Limit connections per source IP ###
    sudo /sbin/iptables -$action INPUT -p tcp -m connlimit --connlimit-above 111 -j REJECT --reject-with tcp-reset
    if [[ "$action" == "A" ]]
    then
      echo Connections per source IP are now limited.
    elif [[ "$action" == "D" ]]
    then
      echo Connections per source IP are now unlimited.
    else
      echo Something went wrong with your action variable.
      exit 1
    fi

  elif [[ "$answer" == 11 ]];
  then
    ### 11: Limit RST packets ###
    sudo /sbin/iptables -$action INPUT -p tcp --tcp-flags RST RST -m limit --limit 2/s --limit-burst 2 -j ACCEPT
    sudo /sbin/iptables -$action INPUT -p tcp --tcp-flags RST RST -j DROP
    if [[ "$action" == "A" ]]
    then
      echo RST Packets are now limited.
    elif [[ "$action" == "D" ]]
    then
      echo RST Packets are now unlimited.
    else
      echo Something went wrong with your action variable.
      exit 1
    fi

  elif [[ "$answer" == 12 ]];
  then
    ### 12: Limit new TCP connections per second per source IP ###
    sudo /sbin/iptables -$action INPUT -p tcp -m conntrack --ctstate NEW -m limit --limit 60/s --limit-burst 20 -j ACCEPT
    sudo /sbin/iptables -$action INPUT -p tcp -m conntrack --ctstate NEW -j DROP
    if [[ "$action" == "A" ]]
    then
      echo New TCP connections per second per source IP is now limited.
    elif [[ "$action" == "D" ]]
    then
      echo New TCP connections per second per source IP is now unlimited.
    else
      echo Something went wrong with your action variable.
      exit 1
    fi

  elif [[ "$answer" == 13 ]];
  then
    ### 13: Use SYNPROXY on all ports (disables connection limiting rule) ###
    sudo iptables -t raw -A PREROUTING -p tcp -m tcp --syn -j CT --notrack
    sudo iptables -$action INPUT -p tcp -m tcp -m conntrack --ctstate INVALID,UNTRACKED -j SYNPROXY --sack-perm --timestamp --wscale 7 --mss 1460
    sudo iptables -$action INPUT -m conntrack --ctstate INVALID -j DROP
    if [[ "$action" == "A" ]]
    then
      echo SYNPROXY on all ports is now enabeled.
    elif [[ "$action" == "D" ]]
    then
      echo SYNPROXY on all ports is now disabeled.
    else
      echo Something went wrong with your action variable.
      exit 1
    fi

  elif [[ "$answer" == 14 ]];
  then
    ### 14: SSH brute-force protection ###
    sudo /sbin/iptables -$action INPUT -p tcp --dport ssh -m conntrack --ctstate NEW -m recent --set
    sudo /sbin/iptables -$action INPUT -p tcp --dport ssh -m conntrack --ctstate NEW -m recent --update --seconds 60 --hitcount 10 -j DROP
    if [[ "$action" == "A" ]]
    then
      echo SSH brute-force protection is now enabeled.
    elif [[ "$action" == "D" ]]
    then
      echo SSH brute-force protection is now disabeled.
    else
      echo Something went wrong with your action variable.
      exit 1
    fi

  elif [[ "$answer" == 15 ]];
  then
    ### 15: Protection against port scanning ###
    sudo /sbin/iptables -N port-scanning
    sudo /sbin/iptables -$action port-scanning -p tcp --tcp-flags SYN,ACK,FIN,RST RST -m limit --limit 1/s --limit-burst 2 -j RETURN
    sudo /sbin/iptables -$action port-scanning -j DROP
    if [[ "$action" == "A" ]]
    then
      echo Protection against port scanning is now enabeled.
    elif [[ "$action" == "D" ]]
    then
      echo Protection against port scanning is now disabeled.
    else
      echo Something went wrong with your action variable.
      exit 1
    fi

  elif [[ "$answer" == 16 ]];
  then
    Rules 2 $action
    Rules 3 $action
    Rules 4 $action
    Rules 5 $action
    Rules 6 $action
    Rules 7 $action
    Rules 8 $action
    Rules 9 $action
    Rules 10 $action
    Rules 11 $action
    Rules 12 $action
    Rules 13 $action
    Rules 14 $action
    Rules 15 $action
    Rules 22 $action

  elif [[ "$answer" == 17 ]];
  then
    ### 17: Remove all Rules ###
    iptables -F

  elif [[ "$answer" == 18 ]];
  then
    ### Save all rules ###
    [ ! -d "/firewall" ] && mkdir firewall
    sudo iptables-save > /firewall/dsl.fw

  elif [[ "$answer" == 19 ]];
  then
    ### Restore saved rules ###
    [ ! -d "/firewall" ] && echo "Firewall file does not exist"
    iptables-restore < /firewall/dsl.fw

  elif [[ "$answer" == 20 ]];
  then
    ### Set all rules to reload upon reboot ###
    if test -f "/etc/rc.local"; then
      echo "/etc/rc.local exist"
      sudo sed -i '$i/sbin/iptables-restore < /firewall/dsl.fw' /etc/rc.local
    else
      echo "The file does not exist..."
      #Create the file that we will be adding the startup command to
      sudo touch /etc/rc.local
      sudo echo "
#!/bin/sh -e

# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will \"exit 0\" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.

#<Add terminal commands here without sude>

exit 0" | sudo tee /etc/rc.local
      sudo chmod +x /etc/rc.local
      sudo systemctl enable rc-local
      sudo sed -i '$i/sbin/iptables-restore < /firewall/dsl.fw' /etc/rc.local
    fi

  elif [[ "$answer" == 21 ]];
  then
    ### Disable reboot restore rules ###
    sudo sed -i.bak -e '/firewall/!d' /etc/rc.local

  elif [[ "$answer" == 22 ]];
  then
    ### Allow SSH Connections from anywhere ###
    sudo iptables -$action INPUT -p tcp --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
    sudo iptables -$action OUTPUT -p tcp --sport 22 -m conntrack --ctstate ESTABLISHED -j ACCEPT
    if [[ "$action" == "A" ]]
    then
      echo Connections to SSH is now enabeled.
    elif [[ "$action" == "D" ]]
    then
      echo Connections to SSH is now disabeled.
    else
      echo Something went wrong with your action variable.
      exit 1
    fi

  elif [[ "$answer" == 23 ]];
  then
    ### Allow basic webserver configuration ###
    #HTTP and HTTPS
    sudo iptables -$action INPUT -p tcp -m multiport --dports 80,443 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
    sudo iptables -$action OUTPUT -p tcp -m multiport --dports 80,443 -m conntrack --ctstate ESTABLISHED -j ACCEPT

    if [[ "$action" == "A" ]]
    then
      echo HTTP and HTTPS is now enabeled.
    elif [[ "$action" == "D" ]]
    then
      echo HTTP and HTTPS is now disabeled.
    else
      echo Something went wrong with your action variable.
      exit 1
    fi

  elif [[ "$answer" == 24 ]];
  then
    ### Allow basic mySQL configuration ###
    #Open port 3306
    sudo iptables -$action INPUT -p tcp --dport 3306 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
    sudo iptables -$action OUTPUT -p tcp --sport 3306 -m conntrack --ctstate ESTABLISHED -j ACCEPT

    if [[ "$action" == "A" ]]
    then
      echo mySQL is now enabeled.
    elif [[ "$action" == "D" ]]
    then
      echo mySQL is now disabeled.
    else
      echo Something went wrong with your action variable.
      exit 1
    fi

  elif [[ "$answer" == 25 ]];
  then
    ### Allow basic telnet configuration ###
    #Open port 3306
    sudo iptables -$action INPUT -p tcp --dport 23 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
    sudo iptables -$action OUTPUT -p tcp --sport 23 -m conntrack --ctstate ESTABLISHED -j ACCEPT

    if [[ "$action" == "A" ]]
    then
      echo Telnet is now enabeled, but you should really consider not doing this. Ever.
    elif [[ "$action" == "D" ]]
    then
      echo Telnet is now disabeled. Thank you.
    else
      echo Something went wrong with your action variable.
      exit 1
    fi

  elif [[ "$answer" == 26 ]];
  then
    ### Allow basic email configuration ###
    sudo iptables -$action INPUT -p tcp -m multiport --dports 25,587,465,110,995 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
    sudo iptables -$action OUTPUT -p tcp -m multiport --dports 25,587,465,110,995 -m conntrack --ctstate ESTABLISHED -j ACCEPT

    if [[ "$action" == "A" ]]
    then
      echo Email server ports are now enabeled.
    elif [[ "$action" == "D" ]]
    then
      echo Email server ports are now disabeled.
    else
      echo Something went wrong with your action variable.
      exit 1
    fi

  elif [[ "$answer" == 27 ]];
  then
    ### 27: Allow/Block IP Address. ###
    echo "What IP Address do you want to block or unblock?"
    read IPAddress
    if [[ $IPAddress =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]];
    then
      sudo iptables -$action INPUT -s $IPAddress -j DROP
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

  elif [[ "$answer" == 28 ]];
  then
    ### 28 :Allow/Block Ports ###
    echo What port would you like to block or unblock?
    read port
    sudo iptables -$action INPUT -p tcp --dport $port -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
    sudo iptables -$action OUTPUT -p tcp --sport $port -m conntrack --ctstate ESTABLISHED -j ACCEPT

    if [[ "$action" == "A" ]]
    then
      echo Port $port has been closed.
    elif [[ "$action" == "D" ]]
    then
      echo Port $port has been opened.
    else
      echo Something went wrong with your action variable.
      exit 1
    fi

  elif [[ "$answer" == 29 ]];
  then
    ### 29: Allow/Block MAC Address Access. ###
    echo "What MAC Address would you like to block or unblock?"
    #if [[ "$action" == "A" ]]; then echo "What MAC Address would you like to block?" fi
    #if [[ "$action" == "D" ]]; then echo "What MAC Address would you like to unblock?" fi
    echo "Remember, a MAC address looks like this 00:00:00:00:00:00"
    read MACAddress
    sudo /sbin/iptables -$action INPUT -m mac --mac-source $MACAddress -j DROP

    if [[ "$action" == "A" ]]
    then
      echo MAC Address $MACAddress has now been blocked.
    elif [[ "$action" == "D" ]]
    then
      echo MAC Address $MACAddress has now been unblocked.
    else
      echo Something went wrong with your action variable.
      exit 1
    fi
  fi
}

function EDisable {
  echo ""
  echo ""
  echo "Would you like to enable to disable rules? (e/d)"
  echo "Type 1 to view current IP Tables"
  read answer
  if [[ "$answer" == "e" ]] || [[ "$answer" == "E" ]] || [[ "$answer" == "enable" ]] || [[ "$answer" == "Enable" ]];
  then
    action=A
  elif [[ "$answer" == "d" ]] || [[ "$answer" == "D" ]] || [[ "$answer" == "disable" ]] || [[ "$answer" == "Disable" ]];
  then
    action=D
  elif [[ "$answer" == 1 ]];
  then
    sudo iptables -L -nv --line-number
    echo ""
    echo ""
    EDisable
  elif [[ "$answer" == "q" ]] || [[ "$answer" == "Q" ]] || [[ "$answer" == "quit" ]] || [[ "$answer" == "Quit" ]];
  then
    exit 1
  else
    echo You entered something wrong.
    exit 1
  fi
}

#########################################################################
############################Start Script###############################
#########################################################################

#Run as Root
if [ "$(whoami)" != "root" ]; then
        echo "Sorry, you are not root."
        exit 1
fi

#########################################################################
############################Startup Tables###############################
#########################################################################
echo "Welcome to Firewall Hardener"
echo "This program contains basic hardening rules to add to your IPTables."
echo "At any point, type Q/q to quit"
while :
do
  #Ask if the user wants to enable to disable the rules
  EDisable

#Move on to the main
  echo " __________________________________________________
|_____________________Options______________________|
| 1) Show IP Tables                                |
| 2) Disable Pings - Prevent Pings                 |
| 3) Drop invalid packets                          |
| 4) Drop TCP packets that are new and are not SYN |
| 5) Drop SYN packets with suspicious MSS value    |
| 6) Block packets with bogus TCP flags            |
| 7) Block spoofed packets                         |
| 8) Drop ICMP (rare protocol)                     |
| 9) Drop fragments in all chains                  |
| 10) Limit connections per source IP              |
| 11) Limit RST packets                            |
| 12) Limit new TCP connections/second/source IP   |
| 13) Use SYNPROXY on all ports                    |
| 14) SSH brute-force protection                   |
| 15) Protection against port scanning             |
| 16) Add All Above Rules                          |
| 17) Remove All Rules                             |
| 18) Save All Rules                               |
| 19) Restore saved rules                          |
| 20) Set all rules to reload upon reboot.         |
| 21) Disable reboot restore rules                 |
| 22) Allow/Block SSH Connections.                 |
| 23) Allow/Block Basic Webserver configurations.  |
| 24) Allow/Block mySQL configurations.            |
| 25) Allow/Block Telnet configurations.           |
| 26) Allow/Block Email configurations.            |
| 27) Allow/Block IP Address.                      |
| 28) Allow/Block Ports                            |
| 29) Allow/Block MAC Address Access.              |
|__________________________________________________|
Enter the number of the option number that you would like to use."

#########################################################################
##################################Main###################################
#########################################################################
  read answer
  Rules $answer $action
done


