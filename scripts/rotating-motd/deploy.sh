#!/bin/bash
echo You must be sudo to run this.
#sudo chmod 777 runChangeMOTD.sh #make it so the system can run this script
#sudo chown root:root runChangeMOTD.sh
sudo chmod +x /etc/profile.d/runChangeMOTD.sh
sudo cp -r ../rotating-motd /etc/ #move the folder to /etc/
sudo cp runChangeMOTD.sh /etc/profile.d