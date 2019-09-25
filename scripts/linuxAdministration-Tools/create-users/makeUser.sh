#!/bin/sh
#This file makes a new user and mail account
if [ "$(whoami)" != "root" ]; then
        echo "Sorry, you are not root."
        exit 1
fi

echo What is the user's username?
read username
sudo useradd $username

echo Please enter the new user's password.
sudo passwd $username

echo Creating their home directory.
sudo mkdir -p /home/$username
sudo chown -R $username:$username /home/$username
usermod -m -d /home/$username $username
echo done.
