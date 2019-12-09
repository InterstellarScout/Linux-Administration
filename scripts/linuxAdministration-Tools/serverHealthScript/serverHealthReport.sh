#!/bin/bash
#This program is used to drop display system information both on your screen and into a file called: systemInfo.txt
# clear the screen
file=serverinfo.txt

clear

unset tecreset os architecture kernelrelease internalip externalip nameserver loadaverage

# Check if connected to Internet or not
ping -c 1 google.com &> /dev/null && echo -e "Internet: $tecreset Connected" || echo -e "Internet: $tecreset Disconnected" | tee -a $file

# Check OS Type
os=$(uname -o)
echo -e "Operating System Type :" $tecreset $os | tee -a $file

# Check OS Release Version and Name
cat /etc/os-release | grep 'NAME\|VERSION' | grep -v 'VERSION_ID' | grep -v 'PRETTY_NAME' > /tmp/osrelease | tee -a $file
echo -n -e "OS Name :" $tecreset  && cat /tmp/osrelease | grep -v "VERSION" | cut -f2 -d\" | tee -a $file
echo -n -e "OS Version :" $tecreset && cat /tmp/osrelease | grep -v "NAME" | cut -f2 -d\" | tee -a $file

# Check Architecture
architecture=$(uname -m)
echo -e "Architecture :" $tecreset $architecture | tee -a $file

# Check Kernel Release
kernelrelease=$(uname -r)
echo -e "Kernel Release :" $tecreset $kernelrelease | tee -a $file

# Check hostname
echo -e "Hostname :" $tecreset $HOSTNAME | tee -a $file

# Check Internal IP
internalip=$(hostname -I)
echo -e "Internal IP :" $tecreset $internalip | tee -a $file

# Check External IP
externalip=$(curl -s ipecho.net/plain;echo)
echo -e "External IP : $tecreset "$externalip | tee -a $file

# Check DNS
nameservers=$(cat /etc/resolv.conf | sed '1 d' | awk '{print $2}')
echo -e "Name Servers :" $tecreset $nameservers | tee -a $file

# Check Logged In Users
who>/tmp/who
echo -e "Logged In users :" $tecreset && cat /tmp/who | tee -a $file

# Check RAM and SWAP Usages
free -h | grep -v + > /tmp/ramcache
echo -e "Ram Usages :" $tecreset | tee -a $file
cat /tmp/ramcache | grep -v "Swap" | tee -a $file
echo -e "Swap Usages :" $tecreset | tee -a $file
cat /tmp/ramcache | grep -v "Mem" | tee -a $file

# Check Disk Usages
df -h| grep 'Filesystem\|/dev/sda*' > /tmp/diskusage | tee -a $file
echo -e "Disk Usages :" $tecreset | tee -a $file
cat /tmp/diskusage | tee -a $file

# Check Load Average
loadaverage=$(top -n 1 -b | grep "load average:" | awk '{print $10 $11 $12}')
echo -e "Load Average :" $tecreset $loadaverage | tee -a $file

# Check System Uptime
tecuptime=$(uptime | awk '{print $3,$4}' | cut -f1 -d,)
echo -e "System Uptime Days/(HH:MM) :" $tecreset $tecuptime | tee -a $file

# Unset Variables
unset tecreset os architecture kernelrelease internalip externalip nameserver loadaverage

# Remove Temporary Files
rm /tmp/osrelease /tmp/who /tmp/ramcache /tmp/diskusage
