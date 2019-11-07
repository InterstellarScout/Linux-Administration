#!/bin/sh

echo Enter an IP Address
read ip

if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]];
then
echo Thank you
else
echo The IP you entered is invalid.
exit 1
fi
