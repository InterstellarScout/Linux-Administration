if [ "$(whoami)" != "root" ]; then
        echo "Sorry, you are not root."
        exit 1
fi

echo Opening Firewall port 8000
sudo iptables -A INPUT -p tcp --dport 8000 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
sudo iptables -A OUTPUT -p tcp --dport 8000 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT

echo Turning on Splunk
cd /opt/splunk/bin
./splunk start --accept-license

echo Connect to Splunk using one of the following addresses at port 8000
echo So xxx.xxx.xxx.xxx:8000

#Get Internal IP Addresses
#Now lets show results for each active interface. This format works woth eth0, lo, and wlan0
if grep -q "eth0" "links.txt"; then
  printf "\nInterface eth0: \n"
  ip4=$(/sbin/ip -o -4 addr list eth0 | awk '{print $4}' | cut -d/ -f1)
  ip6=$(/sbin/ip -o -6 addr list eth0 | awk '{print $4}' | cut -d/ -f1)

  if [ "$ip4" == "127.0.0.1" ]; then
    echo Interface eth0 is not connected and has the address 127.0.0.1, a loopback address.
  else
    echo Interface eth0 has the IPv4 address $ip4
  fi
  if [ "$ip6" == "::1" ]; then
    echo Interface eth0 IPv6 is not connected and has the address ::1, a loopback address.
  else
    echo Interface eth0 has the IPv6 address $ip6
  fi
fi

if grep -q "lo" "links.txt"; then
  printf "\nInterface lo: \n"
  lo_ip4=$(/sbin/ip -o -4 addr list lo | awk '{print $4}' | cut -d/ -f1)
  lo_ip6=$(/sbin/ip -o -6 addr list lo | awk '{print $4}' | cut -d/ -f1)

  if [ "$lo_ip4" == "127.0.0.1" ]; then
  echo Local interface lo is not connected and has the address 127.0.0.1, a loopback address.
  else
    Interface lo has the IPv4 address $lo_ip4
  fi
  if [ "$lo_ip6" == "::1" ]; then
  echo Local interface lo is not connected and has the address ::1, a loopback address.
  else
    Interface lo has the IPv6 address $ip6
  fi
fi

#if wlan0 is found:
if grep -q "wlan0" "links.txt"; then
  printf "\nInterface wlan0: \n"
  wlan0_ip4=$(/sbin/ip -o -4 addr list wlan0 | awk '{print $4}' | cut -d/ -f1)
  wlan0_ip6=$(/sbin/ip -o -6 addr list wlan0 | awk '{print $4}' | cut -d/ -f1)

  if [ $wlan0_ip4 == "127.0.0.1" ]; then
  echo Interface wlan0 is not connected and has the address 127.0.0.1, a loopback address.
  else
    echo Interface wlan0 has the IPv4 address $wlan0_ip4
    fi
  if [ $wlan0_ip6 == "::1" ]; then
  echo Interface wlan0 is not connected and has the address ::1, a loopback address.
  else
    echo Interface wlan0 has the IPv6 address $wlan0_ip6
    fi
fi