#!/bin/sh
#Remove this file from the folder, drop it where you want the Repo (for example, Home or ~), then run this script (see below).
#NOTE Permissions may be needed. If so, run chmod 777 getUpdatedRepo.sh and then run with ./getUpdatedRepo.sh
cd ~
sudo rm -r Linux-Administration
git clone https://github.com/Intergalacticstoryteller/Linux-Administration.git

cd Linux-Administration
chmod 777 prepareScripts.sh
./prepareScripts.sh
