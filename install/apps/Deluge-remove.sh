#!/bin/bash

which deluged > /tmp/checkapp.txt
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

		sudo ufw delete allow 8112

		# Main script

		sudo apt-get -y remove --purge \
			deluged \
			deluge-webui \
			deluge-console

		# Removing Services

		sudo systemctl stop deluged.service
		sudo systemctl stop deluge-web.service

		sudo systemctl disable deluged.service
		sudo systemctl disable deluge-web.service

		sudo rm /etc/systemd/system/deluged.service
		sudo rm /etc/systemd/system/deluge-web.service

		sudo systemctl daemon-reload

		# Cleaning up folders

		clear
		
		CONFIRMDELETE
		
		echo -e "${YELLOW}"
		echo -e "--------------------------------------------------"
		echo -e " Delete the following folder (y/N)?"
		echo -e " /home/plexuser/downloads"
		echo -e "--------------------------------------------------"
		echo -e "${STD}"
		
		read -e -p "Yes or No? " -i "N" choice
		
		
		case "$choice" in
			y|Y ) sudo rm -r /home/plexuser/download ;;
			* ) echo "Folder not deleted" ;;
		esac

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm /tmp/checkapp.txt
PAUSE
