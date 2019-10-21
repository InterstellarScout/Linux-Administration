#!/bin/sh
#This automated ip scoping tool is used to investigate a target's external network.
#This is a Black Box Scan, so we are looking for what we can from the outside.
#Required programs are:
#sudo apt-get install geoip-bin
#wget https://geolite.maxmind.com/download/geoip/database/GeoLite2-City.tar.gz
#gunzip GeoLiteCity.dat.gz
#sudo cp GeoLiteCity.dat /usr/share/GeoIP/
#nmap
#whois
#dnsmap
domainCheck=0 #This variable is needed to jump the domain question if needed.

#Must run as root
if [ "$(whoami)" != "root" ]; then
        echo "Sorry, you are not root."
        exit 1
fi

######################################################
###############Gather Information#####################
######################################################

#################Get IP Address#######################
echo What is the target IP address?
echo If there is none, type \"none\"
read TargetIpAddress
#Check id the IP is valid
if [[ $TargetIpAddress =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]];
	then
	  IPArray=$TargetIpAddress
	  echo Thank you

elif [[ "$TargetIpAddress" == "none" ]] || [ "$TargetIpAddress" == "None" ] || [ "$TargetIpAddress" == "N" ] || [ "$TargetIpAddress" == "n" ];
	then
	echo What is the domain?
	echo If there is none, type \"none\"
	domainCheck=1
	read TargetDomain
	if [ "$TargetDomain" == "none" ] || [ "$TargetDomain" == "None" ] || [ "$TargetDomain" == "N" ] || [ "$TargetDomain" == "n" ];
		then
		#No information is given if they reach this. End program.
		echo I have nothing to investigate. Oh well. Thanks anyway.
		exit 1
	fi
	mapfile -t IPArray < <(dig +short $TargetDomain)
	if [ ${#IPArray[@]} -eq 0 ]; then #If the array is empty, no IP Addresses were found
		echo No IP Address was found from this domain.
		echo Did you spell it right?
	fi
	TargetIpAddress=$IPArray

else
	echo The IP you entered is invalid.
	exit 1
fi

###################Get Domain#######################
if [ $domainCheck == 0 ];
  then
  echo What is the target Domain?
  echo If there is none, type \"none\"
  read TargetDomain
  if [ "$TargetDomain" == "none" ] || [ "$TargetDomain" == "None" ] || [ "$TargetDomain" == "N" ] || [ "$TargetDomain" == "n" ];
	  then
	  #If we do not have a domain, we will use the
	  TargetDomain=$TargetIpAddress
	fi
fi

######################################################
##################Variable Setup######################
######################################################
#Date
d=$(date +%m-%d-%Y)

#File Title
#fileOutput="$TargetDomain"'-Investigation-'"$d"'.txt'
#fileOutput=$TargetDomain'-Investigation-'$d'.txt'
fileOutput={$TargetDomain}-Investigation-{$d}.txt

######################################################
###############Output File Setup######################
######################################################
echo ------------------------------------------------------------ | tee -a $fileOutput
chmod 777 $fileOutput #make the file avaiable to everyone.
echo ------------------Investigation Report---------------------- | tee -a $fileOutput
echo ------------------------------------------------------------ | tee -a $fileOutput
echo This report has been created on: $d | tee -a $fileOutput
echo Interstellar Tech has assembeled this information. | tee -a $fileOutput
echo The target systems are as follows: | tee -a $fileOutput
echo Domain\(s\): $TargetDomain | tee -a $fileOutput
echo According to the domain\'s DNS records, it is being hosted at: | tee -a $fileOutput
for address in "${IPArray[@]}"
do
echo IP Address: $address | tee -a $fileOutput
done
echo | tee -a $fileOutput
echo | tee -a $fileOutput
######################################################
##################Run the Program#####################
######################################################
echo ------------------------------------------------------------ | tee -a $fileOutput
echo ---------------------Domain Scoping------------------------- | tee -a $fileOutput
echo ------------------------------------------------------------ | tee -a $fileOutput
echo | tee -a $fileOutput
#Physical IP Location Lookup
#curl https://ipvigilante.com/$address
#{"status":"success","data":{"ipv4":"64.25.82.10","continent_name":"North America","country_name":"United States","subdivision_1_name":"Massachusetts","subdivision_2_name":null,"city_name":"Beverly","latitude":"42.56530","longitude":"-70.85780"}}
echo Command: curl https://ipvigilante.com/$TargetIpAddress | tee -a $fileOutput
echo Objective: Find where the ip\'s are given to physically. The server is likely being hosted in this area. Once compared with the domain\'s registrar, we may have an exact location. | tee -a $fileOutput
echo Results: | tee -a $fileOutput
for address in "${IPArray[@]}"
do
echo | tee -a $fileOutput
echo Checking the location of $address
curl https://ipvigilante.com/$address | tee -a tempFile
grep -Po '"ipv4":.*?[^\\]"' tempFile|awk -F"[:\"]" '{print $5}' | tee -a $fileOutput
grep -Po '"status":.*?[^\\]"' tempFile|awk -F"[:\"]" '{print $5}' | tee -a $fileOutput
grep -Po '"country_name":.*?[^\\]"' tempFile|awk -F"[:\"]" '{print $5}' | tee -a $fileOutput
grep -Po '"subdivision_1_name":.*?[^\\]"' tempFile|awk -F"[:\"]" '{print $5}' | tee -a $fileOutput
grep -Po '"city_name":.*?[^\\]"' tempFile|awk -F"[:\"]" '{print $5}' | tee -a $fileOutput
grep -Po '"latitude":.*?[^\\]"' tempFile|awk -F"[:\"]" '{print $5}' | tee -a $fileOutput
grep -Po '"longitude":.*?[^\\]"' tempFile|awk -F"[:\"]" '{print $5}' | tee -a $fileOutput
echo | tee -a $fileOutput
rm tempFile
done

echo | tee -a $fileOutput
echo ------------------------------------------------------------ | tee -a $fileOutput
echo | tee -a $fileOutput

if [ $TargetIpAddress == $TargetDomain ]; #If the user did not supply a domain, skip this.
then
	echo Skipping Domain Lookup
else
  echo whois -H $TargetDomain | tee -a $fileOutput
	echo Objective: Scope out what information can be gathered by the domain\’s registrar. | tee -a $fileOutput
	echo Results: | tee -a $fileOutput
	whois -H $TargetDomain | tee -a $fileOutput
fi

echo | tee -a $fileOutput
echo ------------------------------------------------------------ | tee -a $fileOutput
echo | tee -a $fileOutput
exit 1 ##########################TEST BREAK################################

echo Command: whois -H $TargetIpAddress | tee -a $fileOutput
echo Objective: Find out if there are any other IP Addresses given to the company in the IP block.  | tee -a $fileOutput
echo Results: | tee -a $fileOutput
for address in "${IPArray[@]}"
do
  echo | tee -a $fileOutput
  echo Checking the IP Information of $address
  whois -H $address | tee -a $fileOutput
  echo | tee -a $fileOutput
done

echo | tee -a $fileOutput
echo ------------------------------------------------------------ | tee -a $fileOutput
echo | tee -a $fileOutput

if [ $TargetIpAddress == $TargetDomain ]; #If the user did not supply a domain, skip this.
then
	echo Skipping Domain Lookup
else
  echo Command: dnsmap $TargetDomain | tee -a $fileOutput
  echo Objective: Attempt to locate any subdomains that may belong to the domain.  | tee -a $fileOutput
  echo Results:
  dnsmap $TargetDomain | tee -a $fileOutput
fi

echo | tee -a $fileOutput
echo ------------------------------------------------------------ | tee -a $fileOutput
echo | tee -a $fileOutput

if [ $TargetIpAddress == $TargetDomain ]; #If the user did not supply a domain, skip this.
then
	echo Skipping Domain Lookup
else
  echo Command: dnsrecon -d $TargetDomain -g  | tee -a $fileOutput
  echo Objective: Check out domain zones and zone transfers. Discover any cached entries as well.  | tee -a $fileOutput
  echo Results: | tee -a $fileOutput
  dnsrecon -d $TargetDomain -g  | tee -a $fileOutput
fi

echo | tee -a $fileOutput
echo ------------------------------------------------------------ | tee -a $fileOutput
echo | tee -a $fileOutput

echo Command: host -c chaos -t txt version.bind | tee -a $fileOutput
echo Objective: Attempt to find out what BIND version is being used by the domain\'s DNS server. | tee -a $fileOutput
echo Result: | tee -a $fileOutput

echo | tee -a $fileOutput
echo ------------------------------------------------------------ | tee -a $fileOutput
echo | tee -a $fileOutput

echo Command: nmap -sU -p53 -script=dns-recursion $TargetDomain | tee -a $fileOutput
echo Objective: Check if the DNS allows DNS recursion. If enabled, the server is vulnerable to DNS amplification attacks. | tee -a $fileOutput
echo Result: | tee -a $fileOutput

echo | tee -a $fileOutput
echo ------------------------------------------------------------ | tee -a $fileOutput
echo ---------------Port and Network Scanning-------------------- | tee -a $fileOutput
echo ------------------------------------------------------------ | tee -a $fileOutput
echo | tee -a $fileOutput

echo Command: sudo nmap -v -sS -sV -p0-65535 $TargetIpAddress | tee -a $fileOutput
echo Objective: Scan a server for open ports and services using said ports. Scan using TCP protocols. Attempt to identify specific services that may have exploits. | tee -a $fileOutput
echo Result: | tee -a $fileOutput

for address in "${IPArray[@]}"
do
	echo Scanning $address | tee -a $fileOutput
	echo Command: sudo nmap -v -sS -sV -p0-65535 $TargetIpAddress | tee -a $fileOutput
	echo Command: sudo nmap -v -sS -sV -p0-65535 $TargetIpAddress | tee -a Scanoutput.txt

	#Save the ports for the ip address
	mapfile -t PortArray < <(awk -F"[ /]" '/Discovered/{print $4}' Scanoutput.txt)
	#Get more information on each port
	for port in "${IPArray[@]}"
	do
		echo Command: nmap -sC -p$port -T4 $address | tee -a $fileOutput
		echo Scanning $port on $address | tee -a $fileOutput
		sudo nmap -sC -p$port -T4 $address | tee -a $fileOutput
	done

rm Scanoutput.txt
done

echo | tee -a $fileOutput
echo ------------------------------------------------------------ | tee -a $fileOutput
echo | tee -a $fileOutput

#not done
echo Command: nmap -Su -min-rate 5000 $TargetIpAddress | tee -a $fileOutput
echo Objective: Objective: Scan a server for open ports and services using said ports. Scan using UDP protocols. Attempt to identify specific services that may have exploits. | tee -a $fileOutput
echo Result: | tee -a $fileOutput
for address in "${IPArray[@]}"
do
  nmap -Su -min-rate 5000 $address | tee -a $fileOutput
done

echo | tee -a $fileOutput
echo ------------------------------------------------------------ | tee -a $fileOutput
echo | tee -a $fileOutput

echo Command: nmap -sC -p{port},{port},{port} -T4 $TargetIpAddress | tee -a $fileOutput
echo Objective: Take a deeper look at open ports. | tee -a $fileOutput
echo Result: | tee -a $fileOutput
for address in "${IPArray[@]}"
do
  #For each address:
done

echo | tee -a $fileOutput
echo ------------------------------------------------------------ | tee -a $fileOutput
echo | tee -a $fileOutput

echo Command: wafw00f $TargetDomain | tee -a $fileOutput
echo Objective: Learn if the web application has any web application firewalls. This may shed light on the infrastructure that the server has been built in. | tee -a $fileOutput
echo Result: | tee -a $fileOutput

echo | tee -a $fileOutput
echo ------------------------------------------------------------ | tee -a $fileOutput
echo | tee -a $fileOutput

echo Command: dotdotpwn-mhttp-c3-h$TargetIpAddress | tee -a $fileOutput
echo Objective: Initiate a fuzzing against the target server in attempt to find any security flaws in the web facing applications. This command uses the http module to attempt to find flaws with the http programs. Other supported modules are http|http-url|ftp|tftp|payload|stdout. | tee -a $fileOutput
echo Result: | tee -a $fileOutput
for address in "${IPArray[@]}"
do
  #For each address:
  dotdotpwn-mhttp-c3-h$address | tee -a $fileOutput
done

echo | tee -a $fileOutput
echo ------------------------------------------------------------ | tee -a $fileOutput
echo | tee -a $fileOutput
