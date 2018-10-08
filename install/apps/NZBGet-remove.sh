#!/bin/bash

ls /opt/nzbget > /tmp/checkapp.txt
clear

if [ ! -s /tmp/checkapp.txt ]; then

	NOTINSTALLED

else

	EXPLAINTASK

	CONFIRMATION

	if [[ ${REPLY} =~ ^[Yy]$ ]]; then

		GOAHEAD

		# Dependencies

		RUNPATCHES

		# Close ports

		sudo ufw delete allow 6789

		# Main script

		sudo apt-get -y remove --auto-remove nzbget

		# Removing Services

		sudo rsync -a /opt/GooPlex/scripts/nzbget.service /etc/systemd/system/nzbget.service
		sudo systemctl enable nzbget.service
		sudo systemctl daemon-reload
		sudo systemctl start nzbget.service

		# Cleaning up folders

		clear

		CONFIRMDELETE

		echo -e "${YELLOW}"
		echo -e "--------------------------------------------------"
		echo -e " Delete the user configurations (y/N)?"
		echo -e "--------------------------------------------------"
		echo -e "${STD}"

		read -e -p "Yes or No? " -i "N" choice

		case "$choice" in
			y|Y ) sudo apt-get -y purge --auto-remove nzbget ;;
			* ) echo "Configurations not deleted" ;;
		esac

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm /tmp/checkapp.txt
PAUSE
