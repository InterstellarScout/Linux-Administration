#!/bin/bash
#This program adds some of my common shortcuts to the bash profile
#Make sure these programs are installed if needed:
sudo apt install python3
sudo apt install python3-pip

cd ~
echo
#sudo the previous statement.
echo "alias please='sudo \$(fc -ln -1)'" >> .bashrc
#when you summon python, make sure it uses 3
echo "alias python=python3" >> .bashrc
#when you summon pip, make sure it uses pip3
echo "alias pip=pip3" >> .bashrc