#!/bin/bash

ls /opt/plexupdate > /tmp/checkapp.txt
clear

if [ ! -s /tmp/checkapp.txt ]; then

	NOTINSTALLED

else

	EXPLAINTASK

	CONFIRMDELETE

	if [[ ${REPLY} =~ ^[Yy]$ ]]; then

		GOAHEAD

		# Close ports

		sudo ufw delete allow 32400

		# Main script

		sudo dpkg --purge plexmediaserver
		sudo rm -r /opt/plexupdate

		# Cleaning up folders

		clear

		echo -e "${YELLOW}"
		echo -e "--------------------------------------------------"
		echo -e " Delete the Plex database and libraries (y/N)?"
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
