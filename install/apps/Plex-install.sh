#!/bin/bash

ls /var/lib/plexmediaserver > /tmp/checkapp.txt
ls /opt/plexupdate >> /tmp/checkapp.txt
clear

if [ -s /tmp/checkapp.txt ]; then

	ALREADYINSTALLED

else

	EXPLAINTASK

	CONFIRMATION

	if [[ ${REPLY} =~ ^[Yy]$ ]]; then

		GOAHEAD

		# Dependencies

		RUNPATCHES

		# Open ports

		sudo ufw allow 32400

		# Main script

		cd /tmp
		clear
		echo -e "${YELLOW}Please read the options carefully${STD}"
		echo ""
		bash -c "$(wget -qO - https://raw.githubusercontent.com/mrworf/plexupdate/master/extras/installer.sh)"
		sudo rm /tmp/plexmediaserver*
		cd ~

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm /tmp/checkapp.txt
PAUSE
