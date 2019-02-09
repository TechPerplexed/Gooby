#!/bin/bash

clear
echo
echo "--------------------------------------------------"
echo " This will install Gooby"
echo " Please sit back while we intialize dependencies"
echo " For best results, run as user 'root'"
echo "--------------------------------------------------"
echo; sleep 5

echo Installing server updates...
echo
sudo apt-get update -y
sudo apt-get upgrade -y
echo

APPLIST="git fail2ban nano unzip wget curl rsync grsync ufw socat fuse apt-transport-https acl mergerfs ca-certificates gpg-agent"

for i in $APPLIST; do
	echo Installing $i...
	echo; sleep 2
	sudo apt-get -y install $i
	echo
done

echo Setting UFW firewall...
echo
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw --force enable
echo

# Finalizing

sudo rm -r /opt/.Gooby > /dev/null 2>&1
sudo git clone -b master https://github.com/TechPerplexed/Gooby /opt/.Gooby > /dev/null 2>&1

if [ -d /opt/.Gooby ]; then
	sudo rm -r /opt/Gooby > /dev/null 2>&1
	sudo mv /opt/.Gooby /opt/Gooby
	sudo chmod +x -R /opt/Gooby/install
	sudo chmod +x -R /opt/Gooby/menus
	sudo chmod +x -R /opt/Gooby/scripts/bin
	sudo chmod +x -R /opt/Gooby/scripts/cron
	sudo rsync -a /opt/Gooby/scripts/bin/gooby /bin
	sudo chmod 755 /bin/gooby
fi

source /opt/Gooby/menus/variables.sh

clear
echo "${GREEN}"
echo "--------------------------------------------------"
echo " Server initialization and dependencies complete!"
echo " Type ${WHITE}gooby${GREEN} to continue installation."
echo " Visit techperplexed.ga for setup instructions."
echo "--------------------------------------------------"
echo "${STD}"
