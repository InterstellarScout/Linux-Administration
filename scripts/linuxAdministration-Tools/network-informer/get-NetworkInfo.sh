#!/bin/bash
#Dean Sheldon
#This program is used to drop netorking information both on your screen and into a file called:
file=networkinfo.txt

#Get Date
d=$(date +%Y-%m-%d)

#Get Computer name
computerName=$(hostname)

#Display Information
echo This file contains the network information for $computerName
echo This infomration was collected: $d

#Setup Network File
echo This file contains the network information for $computerName >> $file
echo This infomration was collected: $d >> $file

#This feature is really here just in case it's needed. Keeping this in the program will require sudo privliges.
#If CentOS
#if [ -f /etc/redhat-release ]; then
#  sudo yum update
#  sudo yum install net-tools
#fi

#If Ubuntu
#if [ -f /etc/lsb-release ]; then
#  sudo apt-get update
#  sudo apt-get install net-tools
#Fi

#Get External IP Address
myip="$(dig +short myip.opendns.com @resolver1.opendns.com)"
printf "\n\nMy WAN/Public IP address: ${myip}"
printf "\n\nMy WAN/Public IP address: ${myip}" >> $file

#Get Internal IP Addresses
#First, lets make the file that will contain our active interfaces:
ip link show >> links.txt
#Now lets show results for each active interface. This format works woth eth0, lo, and wlan0

if grep -q "eth0" "links.txt"; then
  ip4=$(/sbin/ip -o -4 addr list eth0 | awk '{print $4}' | cut -d/ -f1)
  ip6=$(/sbin/ip -o -6 addr list eth0 | awk '{print $4}' | cut -d/ -f1)
  #printf "\nYour local IPv4 address on interface eth0 is $ip4\n"
  #printf "\nYour local IPv6 address on interface eth0 is $ip6\n"
  #printf "\nYour local IPv4 address on interface eth0 is $ip4\n" >> $file
  #printf "\nYour local IPv6 address on interface eth0 is $ip6\n" >> $file

  if [ "$ip4" == "127.0.0.1" ]; then
    echo Interface eth0 is not connected and has the address 127.0.0.1, a loopback address.
  else
    echo Interface eth0 has the IPv4 address $ip4
  fi
  if [ "$ip6" == "::1" ]; then
    echo Interface eth0 IPv6 is not connected and has the address ::1, a loopback address.
  else
    echo Your local interface, eth0, has the IPv6 address $ip6
  fi
fi

if grep -q "lo" "links.txt"; then
  lo_ip4=$(/sbin/ip -o -4 addr list lo | awk '{print $4}' | cut -d/ -f1)
  lo_ip6=$(/sbin/ip -o -6 addr list lo | awk '{print $4}' | cut -d/ -f1)
  #printf "\nYour local IPv4 address on interface lo is $lo_ip4\n"
  #printf "\nYour local IPv6 address on interface lo is $lo_ip6\n"
  #printf "\nYour local IPv4 address on interface lo is $lo_ip4\n" >> $file
  #printf "\nYour local IPv6 address on interface lo is $lo_ip6\n" >> $file

  if [ "$lo_ip4" == "127.0.0.1" ]; then
  echo Interface lo is not connected and has the address 127.0.0.1, a loopback address.
  else
    echo Your local interface, lo, has the IPv4 address $lo_ip4
  fi
  if [ "$lo_ip6" == "::1" ]; then
  echo Interface lo is not connected and has the address ::1, a loopback address.
  else
    echo Interface lo has the IPv6 address $ip6
  fi
fi

#if wlan0 is found:
if grep -q "wlan0" "links.txt"; then
  wlan0_ip4=$(/sbin/ip -o -4 addr list wlan0 | awk '{print $4}' | cut -d/ -f1)
  wlan0_ip6=$(/sbin/ip -o -6 addr list wlan0 | awk '{print $4}' | cut -d/ -f1)
  #printf "\nYour local IPv4 address on interface wlan0 is $wlan0_ip4\n"
  #printf "\nYour local IPv6 address on interface wlan0 is $wlan0_ip6\n"
  #printf "\nYour local IPv4 address on interface wlan0 is $wlan0_ip4\n" >> $file
  #printf "\nYour local IPv6 address on interface wlan0 is $wlan0_ip6\n" >> $file

  if [ $wlan0_ip4 == "127.0.0.1" ]; then
  echo Interface wlan0 is not connected and has the address 127.0.0.1, a loopback address.
  else
    echo Interface wlan0 has the IPv6 address $wlan0_ip4
    fi
  if [ $wlan0_ip6 == "::1" ]; then
  echo Interface wlan0 is not connected and has the address 127.0.0.1, a loopback address.
  else
    echo Your local interface, wlan0, has the IPv6 address $wlan0_ip6
    fi
fi

#remove the file we no longer need
rm links.txt

MAC=$(ifconfig eth0 | grep -Eo ..\(\:..\){5})
printf "\n\nHardware Address: $MAC\n"
printf "\n\nHardware Address: $MAC\n" >> $file

#Check for open ports - outputs open ports, what's listening, and if programs are using it.
echo Open Ports:
ports=$(netstat -atup)
printf "\n\nYour ports are:\n $ports"
printf "\n\nYour ports are:\n $ports" >> $file