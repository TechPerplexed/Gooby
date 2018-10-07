#!/bin/bash

ls /opt/OrganizrInstaller > /tmp/checkapp.txt
clear

if [ -s /tmp/checkapp.txt ]; then

	ALREADYINSTALLED

else

	EXPLAINTASK

	CONFIRMATION

	if [[ ${REPLY} =~ ^[Yy]$ ]]; then

		GOAHEAD

		# Open ports

		sudo ufw allow 80

		# Dependencies

		sudo apt-get upgrade -y && sudo apt-get upgrade -y

		# Main script

		sudo git clone https://github.com/elmerfdz/OrganizrInstaller /opt/OrganizrInstaller
		cd /opt/OrganizrInstaller/ubuntu/oui
		clear
		sudo bash ou_installer.sh
		cd ~

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm /tmp/checkapp.txt
PAUSE
