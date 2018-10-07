#!/bin/bash

which rclone > /tmp/checkapp.txt
clear

if [ ! -s /tmp/checkapp.txt ]; then

	NOTINSTALLED

else

	EXPLAINTASK

	CONFIRMATION

	if [[ ${REPLY} =~ ^[Yy]$ ]]; then

		GOAHEAD

		# Close ports

		#na

		# Dependencies
		
		sudo apt-get upgrade -y && sudo apt-get upgrade -y

		# Main script

		sudo rm /usr/bin/rclone
		sudo rm /usr/local/share/man/man1/rclone.1

		# Removing Services

		sudo systemctl stop rclone.service
		sudo systemctl disable rclone.service
		sudo rm /etc/systemd/system/rclone.service
		sudo systemctl daemon-reload

		# Cleaning up folders

		clear
		
		CONFIRMDELETE

		echo -e "${YELLOW}"
		echo -e "--------------------------------------------------"
		echo -e " Delete the following folders?"
		echo -e " /home/plexuser/uploads"
		echo -e " /home/plexuser/.config/rclone"
		echo -e "--------------------------------------------------"
		echo -e "${STD}"

		read -e -p "Yes or No? " -i "N" choice
		
		case "$choice" in
			y|Y ) rm -r /home/plexuser/uploads; rm -r /home/plexuser/.config/rclone ;;
			* ) echo "Folders not deleted" ;;
		esac

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm /tmp/checkapp.txt
PAUSE
