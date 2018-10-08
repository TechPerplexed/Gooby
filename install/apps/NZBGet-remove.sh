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

		sudo apt-get remove --auto-remove nzbget

		# Removing Services

		sudo systemctl stop nzbget.service
		sudo systemctl disable nzbget.service
		sudo rm /etc/systemd/system/nzbget.service
		sudo systemctl daemon-reload

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
