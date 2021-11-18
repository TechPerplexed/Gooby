#!/bin/bash

clear
echo
echo "--------------------------------------------------"
echo " This will install Gooby"
echo " For best results, run as user 'root'"
echo
echo " Do you wish to install Gooby now? (y/N)? "
echo "--------------------------------------------------"
echo
read -n 1 -s -r -p " ---> "
echo

if [[ ${REPLY} =~ ^[Yy]$ ]]; then

	echo "--------------------------------------------------"
	echo " Great! Let's begin."
	echo " Please sit back while we initialize dependencies"
	echo "--------------------------------------------------"

	# Installing needed apps

	echo; sleep 2; sudo apt-get update -y
	echo; sleep 2; sudo apt-get upgrade -y
	echo; sleep 2

	APPLIST="acl apt-transport-https ca-certificates curl fail2ban fuse git gpg-agent grsync jq mergerfs nano rsync sqlite3 screen socat ufw unzip wget"

	for i in ${APPLIST}; do
		echo Installing $i...
		echo
		sudo apt-get -y install $i
		echo; sleep 2
	done

	# Enable UFW firewall

	echo Enabling UFW firewall...
	echo
	sudo ufw default deny incoming
	sudo ufw default allow outgoing
	sudo ufw allow ssh
	sudo ufw --force enable
	echo

	# Cloning Gooby from Github

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

	# Finalizing

	source /opt/Gooby/menus/variables.sh

	echo "${GREEN}"
	echo "--------------------------------------------------"
	echo " Server initialization and dependencies complete!"
	echo " Type ${WHITE}gooby${GREEN} to continue installation."
	echo " Visit ${LGREEN}techperplexed.blogspot.com${GREEN} for instructions"
	echo "--------------------------------------------------"
	echo "${STD}"

else

	echo
	echo "--------------------------------------------------"
	echo " No worries. You can install Gooby at any time"
	echo "--------------------------------------------------"
	echo

fi
