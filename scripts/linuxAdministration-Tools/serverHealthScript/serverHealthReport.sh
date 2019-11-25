#!/bin/bash
#Dean Sheldon
#This program is used to drop display system information both on your screen and into a file called: systemInfo.txt
# clear the screen
file=serverinfo.txt

clear

unset tecreset os architecture kernelrelease internalip externalip nameserver loadaverage

# Check if connected to Internet or not
ping -c 1 google.com &> /dev/null && echo -e '\E[32m'"Internet: $tecreset Connected" || echo -e '\E[32m'"Internet: $tecreset Disconnected" | tee -a $file

# Check OS Type
os=$(uname -o)
echo -e '\E[32m'"Operating System Type :" $tecreset $os | tee -a $file

# Check OS Release Version and Name
cat /etc/os-release | grep 'NAME\|VERSION' | grep -v 'VERSION_ID' | grep -v 'PRETTY_NAME' > /tmp/osrelease | tee -a $file
echo -n -e '\E[32m'"OS Name :" $tecreset  && cat /tmp/osrelease | grep -v "VERSION" | cut -f2 -d\" | tee -a $file
echo -n -e '\E[32m'"OS Version :" $tecreset && cat /tmp/osrelease | grep -v "NAME" | cut -f2 -d\" | tee -a $file

# Check Architecture
architecture=$(uname -m)
echo -e '\E[32m'"Architecture :" $tecreset $architecture | tee -a $file

# Check Kernel Release
kernelrelease=$(uname -r)
echo -e '\E[32m'"Kernel Release :" $tecreset $kernelrelease | tee -a $file

# Check hostname
echo -e '\E[32m'"Hostname :" $tecreset $HOSTNAME | tee -a $file

# Check Internal IP
internalip=$(hostname -I)
echo -e '\E[32m'"Internal IP :" $tecreset $internalip | tee -a $file

# Check External IP
externalip=$(curl -s ipecho.net/plain;echo)
echo -e '\E[32m'"External IP : $tecreset "$externalip | tee -a $file

# Check DNS
nameservers=$(cat /etc/resolv.conf | sed '1 d' | awk '{print $2}')
echo -e '\E[32m'"Name Servers :" $tecreset $nameservers | tee -a $file

# Check Logged In Users
who>/tmp/who
echo -e '\E[32m'"Logged In users :" $tecreset && cat /tmp/who | tee -a $file

# Check RAM and SWAP Usages
free -h | grep -v + > /tmp/ramcache
echo -e '\E[32m'"Ram Usages :" $tecreset | tee -a $file
cat /tmp/ramcache | grep -v "Swap" | tee -a $file
echo -e '\E[32m'"Swap Usages :" $tecreset | tee -a $file
cat /tmp/ramcache | grep -v "Mem" | tee -a $file

# Check Disk Usages
df -h| grep 'Filesystem\|/dev/sda*' > /tmp/diskusage | tee -a $file
echo -e '\E[32m'"Disk Usages :" $tecreset | tee -a $file
cat /tmp/diskusage | tee -a $file

# Check Load Average
loadaverage=$(top -n 1 -b | grep "load average:" | awk '{print $10 $11 $12}')
echo -e '\E[32m'"Load Average :" $tecreset $loadaverage | tee -a $file

# Check System Uptime
tecuptime=$(uptime | awk '{print $3,$4}' | cut -f1 -d,)
echo -e '\E[32m'"System Uptime Days/(HH:MM) :" $tecreset $tecuptime | tee -a $file

# Unset Variables
unset tecreset os architecture kernelrelease internalip externalip nameserver loadaverage

# Remove Temporary Files
rm /tmp/osrelease /tmp/who /tmp/ramcache /tmp/diskusage
