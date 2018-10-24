#!/bin/bash

which rclone > $CONFIGS/.config/checkapp.txt
clear

if [ ! -s $CONFIGS/.config/checkapp.txt ]; then

	echo "${YELLOW}"
	echo "--------------------------------------------------"
	echo " You will need to install and configure Rclone"
	echo " Before you can restore the backup!"
	echo "--------------------------------------------------"
	echo "${STD}"

else

	EXPLAINTASK

	CONFIRMATION

	if [[ ${REPLY} =~ ^[Yy]$ ]]; then

		GOAHEAD

		echo "Restoring the backup can take several hours"
		echo "Please don't exit the terminal until it's done!"
		echo ""
		read -e -p "Host name to restore: " -i "$(hostname)" filename
		read -e -p "File date to restore: " -i "$(date +%F)" filedate

		echo "${LMAGENTA}Copying from Google drive...${STD}"

		/usr/bin/rclone copy Gdrive:/Backup/$filename/$filedate.tar.gz /tmp --checksum --drive-chunk-size=64M

		if [ -e "/tmp/$filedate.tar.gz" ]; then

		echo "${LBLUE}Backup file downloaded, proceeding...${STD}"

		else

			clear
			echo ""
			echo "${LRED}$filename/$filedate.tar.gz not found on Google!${STD}"
			echo "Please try again"
			echo "Exiting script..."
			echo ""
			PAUSE
			exit

		fi

		echo "${GREEN}Restoring files...${STD}"

		cd $CONFIGS/Docker
		/usr/local/bin/docker-compose down
		cd "${CURDIR}"

		sudo mv $CONFIGS/ /tmp/GooPlex/
		sudo tar -xf /tmp/$filedate.tar.gz -C /

		sudo chown $USER:$USER ${CONFIGS}
		sudo chown $USER:$USER ${HOME}

		cd $CONFIGS/Docker
		source /opt/GooPlex/install/misc/environment-build.sh rebuild
		/usr/local/bin/docker-compose up -d --remove-orphans ${@:2}
		cd "${CURDIR}"

		echo "${CYAN}Finished restoring${STD}"
		echo ""
		echo ""
		echo "${WHITE}Make sure${STD} you check if your services are running properly before you remove the old files!"
		echo ""
		read -n 1 -s -r -p "Remove old files (Y/n)? " -i "" choice
		echo ""

		case "$choice" in
			y|Y ) sudo rm -r /tmp/GooPlex;;
			* ) echo "Your old installation files are available at /tmp until you reboot"; echo "";;
		esac

		sudo rm /tmp/$filedate.*

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm $CONFIGS/.config/checkapp.txt
PAUSE
