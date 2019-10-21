#!/bin/bash
#Dean Sheldon
#This script is used edit entries within your firewall. You can both add and remove entries depending on your needs.
function quit {
  exit 1
}

function enableRules {
  #Variable answer is used to choose which rule to enable
  answer=$1
}
#Run as Root
if [ "$(whoami)" != "root" ]; then
        echo "Sorry, you are not root."
        exit 1
fi

#########################################################################
############################Startup Tables###############################
#########################################################################
echo Welcome to Firewall Hardener
echo This program contains basic hardening rules to add to your IPTables.
echo  __________________________________________________
echo |___________________Options________________________|
echo | 1\) Show IP Tables                               |
echo | 2\) Disable Pings - Prevent Pings                |
echo | 3\) Drop invalid packets                         |
echo | 4\) Drop TCP packets that are new and are not SYN|
echo | 5\) Drop SYN packets with suspicious MSS value   |
echo | 6\) Block packets with bogus TCP flags           |
echo | 7\) Block spoofed packets                        |
echo | 8\) Drop ICMP \(rare protocol\)                  |
echo | 9\) Drop fragments in all chains                 |
echo | 10\) Limit connections per source IP             |
echo | 11\) Limit RST packets                           |
echo | 12\) Limit new TCP connections/second/source IP  |
echo | 13\) Use SYNPROXY on all ports                   |
echo | 14\) SSH brute-force protection                  |
echo | 15\) Protection against port scanning            |
echo | 16\) Add All Rules                               |
echo |__________________________________________________|
echo Enter the number of the option you would like to use.
read answer

if [[ $answer == 1 ]];
then
  sudo iptables -L -nv --line-number
elif [[ $answer == 2 ]];
then
  ### Block Pings ###
  sudo iptables -A INPUT -p icmp --icmp-type echo-request -j DROP
  sudo iptables -A OUTPUT -p icmp --icmp-type echo-reply -j DROP
elif [[ $answer == 3 ]];
then
  ### 3: Drop invalid packets ###
  sudo /sbin/iptables -t mangle -A PREROUTING -m conntrack --ctstate INVALID -j DROP
elif [[ $answer == 4 ]];
then
  ### 4: Drop TCP packets that are new and are not SYN ###
  sudo /sbin/iptables -t mangle -A PREROUTING -p tcp ! --syn -m conntrack --ctstate NEW -j DROP
elif [[ $answer == 5 ]];
then
  ### 5: Drop SYN packets with suspicious MSS value ###
  sudo /sbin/iptables -t mangle -A PREROUTING -p tcp -m conntrack --ctstate NEW -m tcpmss ! --mss 536:65535 -j DROP
elif [[ $answer == 6 ]];
then
  ### 6: Block packets with bogus TCP flags ###
  sudo /sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags FIN,SYN,RST,PSH,ACK,URG NONE -j DROP
  sudo /sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags FIN,SYN FIN,SYN -j DROP
  sudo /sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags SYN,RST SYN,RST -j DROP
  sudo /sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags FIN,RST FIN,RST -j DROP
  sudo /sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags FIN,ACK FIN -j DROP
  sudo /sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags ACK,URG URG -j DROP
  sudo /sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags ACK,FIN FIN -j DROP
  sudo /sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags ACK,PSH PSH -j DROP
  sudo /sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags ALL ALL -j DROP
  sudo /sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags ALL NONE -j DROP
  sudo /sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags ALL FIN,PSH,URG -j DROP
  sudo /sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags ALL SYN,FIN,PSH,URG -j DROP
  sudo /sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags ALL SYN,RST,ACK,FIN,URG -j DROP
elif [[ $answer == 7 ]];
then
  ### 7: Block spoofed packets ###
  sudo /sbin/iptables -t mangle -A PREROUTING -s 224.0.0.0/3 -j DROP
  sudo /sbin/iptables -t mangle -A PREROUTING -s 169.254.0.0/16 -j DROP
  sudo /sbin/iptables -t mangle -A PREROUTING -s 172.16.0.0/12 -j DROP
  sudo /sbin/iptables -t mangle -A PREROUTING -s 192.0.2.0/24 -j DROP
  sudo /sbin/iptables -t mangle -A PREROUTING -s 192.168.0.0/16 -j DROP
  sudo /sbin/iptables -t mangle -A PREROUTING -s 10.0.0.0/8 -j DROP
  sudo /sbin/iptables -t mangle -A PREROUTING -s 0.0.0.0/8 -j DROP
  sudo /sbin/iptables -t mangle -A PREROUTING -s 240.0.0.0/5 -j DROP
  sudo /sbin/iptables -t mangle -A PREROUTING -s 127.0.0.0/8 ! -i lo -j DROP
elif [[ $answer == 8 ]];
then
  ### 8: Drop ICMP (you usually don't need this protocol) ###
  sudo /sbin/iptables -t mangle -A PREROUTING -p icmp -j DROP
elif [[ $answer == 9 ]];
then
  ### 9: Drop fragments in all chains ###
  sudo /sbin/iptables -t mangle -A PREROUTING -f -j DROP
elif [[ $answer == 10 ]];
then
  ### 10: Limit connections per source IP ###
  sudo /sbin/iptables -A INPUT -p tcp -m connlimit --connlimit-above 111 -j REJECT --reject-with tcp-reset
elif [[ $answer == 11 ]];
then
  ### 11: Limit RST packets ###
  sudo /sbin/iptables -A INPUT -p tcp --tcp-flags RST RST -m limit --limit 2/s --limit-burst 2 -j ACCEPT
  sudo /sbin/iptables -A INPUT -p tcp --tcp-flags RST RST -j DROP
elif [[ $answer == 12 ]];
then
  ### 12: Limit new TCP connections per second per source IP ###
  sudo /sbin/iptables -A INPUT -p tcp -m conntrack --ctstate NEW -m limit --limit 60/s --limit-burst 20 -j ACCEPT
  sudo /sbin/iptables -A INPUT -p tcp -m conntrack --ctstate NEW -j DROP
elif [[ $answer == 13 ]];
then
  ### 13: Use SYNPROXY on all ports (disables connection limiting rule) ###
  sudo iptables -t raw -A PREROUTING -p tcp -m tcp --syn -j CT --notrack
  sudo iptables -A INPUT -p tcp -m tcp -m conntrack --ctstate INVALID,UNTRACKED -j SYNPROXY --sack-perm --timestamp --wscale 7 --mss 1460
  sudo iptables -A INPUT -m conntrack --ctstate INVALID -j DROP
elif [[ $answer == 14 ]];
then
  ### 14: SSH brute-force protection ###
  sudo /sbin/iptables -A INPUT -p tcp --dport ssh -m conntrack --ctstate NEW -m recent --set
  sudo /sbin/iptables -A INPUT -p tcp --dport ssh -m conntrack --ctstate NEW -m recent --update --seconds 60 --hitcount 10 -j DROP
elif [[ $answer == 15 ]];
then
  ### 15: Protection against port scanning ###
  sudo /sbin/iptables -N port-scanning
  sudo /sbin/iptables -A port-scanning -p tcp --tcp-flags SYN,ACK,FIN,RST RST -m limit --limit 1/s --limit-burst 2 -j RETURN
  sudo /sbin/iptables -A port-scanning -j DROP
elif [[ $answer == 16 ]];
then
  ### 16: Enable All Rules ###

fi
