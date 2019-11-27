Startup Control
Dean Sheldon
This program is used to control your services and allows you to start/stop them as well as enable/disable them on startup. 
You can locate this script here:
https://github.com/InterstellarScout/Linux-Administration/blob/master/scripts/linuxAdministration-Tools/securityScripts/startupControl/startupControl.sh

Note: If you do not run with sudo, it will be added with the privileges as the user running this command. This program will not work if you are not sudo. 
Usage: sudo bash startupControl.sh

Download the script by using wget:
wget https://raw.githubusercontent.com/InterstellarScout/Linux-Administration/master/scripts/linuxAdministration-Tools/securityScripts/startupControl/startupControl.sh
Give the script the proper permissions:
sudo chmod 755 startupControl.sh
Run the script:
sudo bash startupControl.sh
