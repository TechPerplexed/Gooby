#!/bin/bash

ls /opt/Tautulli > /tmp/checkapp.txt
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

		sudo ufw delete allow 8181

		# Main script

		sudo rm -r /opt/Tautulli_old
		sudo mv /opt/Tautulli /opt/Tautulli_old

		# Removing Services

		sudo systemctl stop tautulli.service
		sudo systemctl disable tautulli.service
		sudo rm /etc/systemd/system/tautulli.service
		sudo systemctl daemon-reload

		# Cleaning up folders

		clear
		
		CONFIRMDELETE
		
		echo -e "${YELLOW}"
		echo -e "--------------------------------------------------"
		echo -e " Delete the user stats folder (y/N)?"
		echo -e " The location is /opt/Tautulli_old"
		echo -e "--------------------------------------------------"
		echo -e "${STD}"
		
		read -e -p "Yes or No? " -i "N" choice
		
		
		case "$choice" in
			y|Y ) sudo rm -r /opt/Tautulli_old ;;
			* ) echo "Folder not deleted" ;;
		esac

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm /tmp/checkapp.txt
PAUSE
