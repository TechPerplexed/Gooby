#!/bin/bash

sudo apt-get update -y && sudo apt-get upgrade -y

sudo apt-get -y install \
 git \
 fail2ban \
 nano \
 unzip \
 wget \
 curl \
 ufw \
 socat \
 fuse \
 apt-transport-https \
 acl \
 ca-certificates \
denyhosts at sudo software-properties-common

sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw --force enable

sudo rm -r /opt/Gooby
sudo git clone -b develop https://github.com/TechPerplexed/Gooby /opt/Gooby

sudo chmod +x -R /opt/Gooby/install
sudo chmod +x -R /opt/Gooby/menus
sudo rsync -a /opt/Gooby/install/gooby /bin
sudo chmod 755 /bin/gooby

source /opt/Gooby/menus/variables.sh

clear
	echo -e "${GREEN}"
	echo -e "--------------------------------------------------"
	echo -e " Installation complete!"
	echo -e " Type ${WHITE}gooby${GREEN} to access the menu."
	echo -e " Visit techperplexed.ga for setup instructions!"
	echo -e "--------------------------------------------------"
	echo -e "${STD}"
