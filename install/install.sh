#!/bin/bash

sudo apt-get update -y
sudo apt-get upgrade -y

for i in git fail2ban nano unzip wget curl rsync grsync ufw socat fuse apt-transport-https acl mergerfs ca-certificates gpg-agent; do
  sudo apt-get -y install $i
done

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
