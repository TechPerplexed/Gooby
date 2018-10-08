#!/bin/bash

ls /var/lib/emby > /tmp/checkapp.txt
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

		sudo ufw delete allow 8096

		# Main script
		
		clear
		sudo apt-get remove --auto-remove emby-server -y

		# Cleaning up folders

		clear

		CONFIRMDELETE
		
		echo -e "${YELLOW}"
		echo -e "--------------------------------------------------"
		echo -e " Delete the Emby database and libraries (y/N)?"
		echo -e " /var/lib/emby/"
		echo -e "--------------------------------------------------"
		echo -e "${STD}"
		
		read -e -p "Yes or No? " -i "N" choice
		
		
		case "$choice" in
			y|Y ) sudo rm -r /var/lib/emby ;;
			* ) echo "Folder not deleted" ;;
		esac

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm /tmp/checkapp.txt
PAUSE
