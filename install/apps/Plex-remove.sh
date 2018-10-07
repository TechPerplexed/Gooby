#!/bin/bash

ls /var/lib/plexmediaserver > /tmp/checkapp.txt
clear

if [ ! -s /tmp/checkapp.txt ]; then

	NOTINSTALLED

else

	EXPLAINTASK

	CONFIRMATION

	if [[ ${REPLY} =~ ^[Yy]$ ]]; then

		GOAHEAD

		# Close ports

		sudo ufw delete allow 32400

		# Dependencies

		sudo apt-get upgrade -y && sudo apt-get upgrade -y

		# Main script

		sudo dpkg -r plexmediaserver
		
		# Cleaning up folders

		clear
		
		CONFIRMDELETE
		
		echo -e "${YELLOW}"
		echo -e "--------------------------------------------------"
		echo -e " Delete the Plex database and libraries (y/N)?"
		echo -e " /var/lib/plexmediaserver/"
		echo -e "--------------------------------------------------"
		echo -e "${STD}"
		
		read -e -p "Yes or No? " -i "N" choice
		
		
		case "$choice" in
			y|Y ) sudo rm -r /var/lib/plexmediaserver ;;
			* ) echo "Folder not deleted" ;;
		esac

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm /tmp/checkapp.txt
PAUSE
