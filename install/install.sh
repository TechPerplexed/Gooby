#!/bin/bash

sudo apt-get update -y
sudo apt-get upgrade -y

sudo apt-get -y install git
sudo apt-get -y install fail2ban
sudo apt-get -y install nano
sudo apt-get -y install unzip
sudo apt-get -y install wget
sudo apt-get -y install curl
sudo apt-get -y install ufw
sudo apt-get -y install socat
sudo apt-get -y install fuse
sudo apt-get -y install apt-transport-https
sudo apt-get -y install acl
sudo apt-get -y install ca-certificates

sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw --force enable

sudo rm -r /opt/Gooby
sudo git clone -b master https://github.com/TechPerplexed/Gooby /opt/Gooby

sudo chmod +x -R /opt/Gooby/install
sudo chmod +x -R /opt/Gooby/menus
sudo chmod +x -R /opt/Gooby/scripts/cron
sudo rsync -a /opt/Gooby/install/gooby /bin
sudo chmod 755 /bin/gooby

source /opt/Gooby/menus/variables.sh

clear
echo "${GREEN}"
echo "--------------------------------------------------"
echo " Installation complete!"
echo " Type ${WHITE}gooby${GREEN} to access the menu."
echo " Visit techperplexed.ga for setup instructions!"
echo "--------------------------------------------------"
echo "${STD}"
