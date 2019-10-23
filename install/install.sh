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

APPLIST="acl apt-transport-https ca-certificates curl fail2ban fuse git gpg-agent grsync jq mergerfs nano rsync sqlite3 ufw socat unzip wget"

for i in $APPLIST; do
	echo Installing $i...
	echo
	sudo apt-get -y install $i
	echo; sleep 2
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
	sudo rsync -a /opt/Gooby/scripts/bin/* /bin
	sudo chmod 755 /bin/gooby
	sudo chmod 755 /bin/gbackup
	sudo chmod 755 /bin/plexstats
	sudo chmod 755 /bin/rclean
	sudo chmod 755 /bin/resetbackup
	sudo chmod 755 /bin/rstats
	sudo chmod 755 /bin/sizer
	sudo chmod 755 /bin/syncmount
fi

source /opt/Gooby/menus/variables.sh

echo "${GREEN}"
echo "--------------------------------------------------"
echo " Server initialization and dependencies complete!"
echo " Type ${WHITE}gooby${GREEN} to continue installation."
echo " Visit techperplexed.ga for setup instructions."
echo "--------------------------------------------------"
echo "${STD}"
