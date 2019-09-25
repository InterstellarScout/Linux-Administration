#!/bin/sh
#This file makes a mail user

echo "What is the user's username?"
echo "NOTE: Make a user account on this system first if you have not already."
echo "The commands for that is:"
echo "sudo useradd myusername"
echo "sudo passwd myusername"
read username
sudo mkdir -p /var/www/html/$username
sudo chown -R myusername:myusername /var/www/html/$username
usermod -m -d /var/www/html/$username $username
