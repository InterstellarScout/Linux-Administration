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
echo "My WAN/Public IP address: ${myip}"
echo "My WAN/Public IP address: ${myip}" >> $file

#Get Internal IP Addresses
ip4=$(/sbin/ip -o -4 addr list eth0 | awk '{print $4}' | cut -d/ -f1)
ip6=$(/sbin/ip -o -6 addr list eth0 | awk '{print $4}' | cut -d/ -f1)
echo $ip4
echo $ip6
echo $ip4 >> $file
echo $ip6 >> $file

if [ ip4=="127.0.0.1" ]; then
echo Interface eth0 is not connected and has the address 127.0.0.1, a loopback address.
fi
if [ ip6=="::1" ]; then
echo Interface eth0 is not connected and has the address 127.0.0.1, a loopback address.
fi

lo_ip4=$(/sbin/ip -o -4 addr list lo | awk '{print $4}' | cut -d/ -f1)
lo_ip6=$(/sbin/ip -o -6 addr list lo | awk '{print $4}' | cut -d/ -f1)
echo $lo_ip4
echo $lo_ip6
echo $lo_ip4 >> $file
echo $lo_ip6 >> $file

if [ lo_ip4=="127.0.0.1" ]; then
echo Interface lo is not connected and has the address 127.0.0.1, a loopback address.
fi
if [ lo_ip6=="::1" ]; then
echo Interface lo is not connected and has the address 127.0.0.1, a loopback address.
fi

MAC=$(ifconfig eth0 | grep -Eo ..\(\:..\){5})
echo "Hardware Address: $MAC"
echo "Hardware Address: $MAC" >> $file

#Check for open ports - outputs open ports, what's listening, and if programs are using it.
echo Open Ports:
ports=$(netstat -atup)
echo "Your ports are: $ports"