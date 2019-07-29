#!/bin/bash

source $CONFIGS/Docker/.env
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

		mkdir -p /tmp/goobyrestore
		RESTOREFOLDER=/tmp/goobyrestore

		echo " Restoring the backup can take several hours"
		echo " Please don't exit the terminal until it's done!"
		echo
		read -e -p " Host name to restore: " -i "${SERVER}" SERVERNAME
		echo
		echo " App name to restore: (for example, ${WHITE}Docker${STD} or ${WHITE}Plex${STD})"
		echo " You can find your app names in ${RCLONESERVICE}:/Backup/${SERVER}/Gooby"
		echo " You can type ${WHITE}all${STD} for all apps,"
		echo " Or ${WHITE}home${STD} for restoring your /home/${USER} directory"
		echo
		read -e -p " App to restore: " -i "all" APPNAME

		echo
		echo " ${LMAGENTA}Copying from Google drive...${STD}"

		if APPNAME=all; then

			/usr/bin/rclone --stats-one-line -P copy ${RCLONESERVICE}:/Backup/${SERVER}/Gooby/* ${RESTOREFOLDER} --checksum --drive-chunk-size=64M

		elif APPNAME=home; then

			/usr/bin/rclone --stats-one-line -P copy ${RCLONESERVICE}:/Backup/${SERVER}/${SERVER}-backup.tar.gz ${RESTOREFOLDER} --checksum --drive-chunk-size=64M

		else

			/usr/bin/rclone --stats-one-line -P copy ${RCLONESERVICE}:/Backup/${SERVER}/Gooby/${APPNAME}.* ${RESTOREFOLDER} --checksum --drive-chunk-size=64M

		fi

		ls -A ${RESTOREFOLDER} > $CONFIGS/.config/checkapp

		if [ -s $CONFIGS/.config/checkapp ]; then

			echo; echo "${LBLUE}Backup file downloaded, proceeding...${STD}"

		else

			clear
			echo
			echo " ${LRED}File(s) not found on Google!${STD}"
			echo
			echo " Please try again!"
			echo " Exiting script..."
			echo

			sudo rm -r ${RESTOREFOLDER}
			rm $CONFIGS/.config/checkapp.txt

			PAUSE
			exit

		fi

		if APPNAME=all; then

			echo
			echo " ${YELLOW}Taking containers down...${STD}"

			cd $CONFIGS/Docker
			/usr/local/bin/docker-compose down
			cd "${CURDIR}"

			echo
			echo " ${GREEN}Restoring files...${STD}"

			sudo mv $CONFIGS/ /tmp/Gooby/

			tar -xpf ${RESTOREFOLDER}/*-full.tar.gz -C /
			tar --incremental -xpf *-diff.tar.gz

			sudo chown $USER:$USER ${CONFIGS}

			cd $CONFIGS/Docker
			source /opt/Gooby/install/misc/environment-build.sh rebuild
			/usr/local/bin/docker-compose up -d --remove-orphans ${@:2}
			cd "${CURDIR}"

		elif APPNAME=home; then

			echo
			echo " ${GREEN}Restoring files...${STD}"

			tar -xpf ${RESTOREFOLDER}/*-full.tar.gz -C /
			sudo chown $USER:$USER ${HOME}

		else

			cd $CONFIGS/Docker
			/usr/local/bin/docker-compose down
			cd "${CURDIR}"

			echo
			echo " ${GREEN}Restoring files...${STD}"

			sudo mv $CONFIGS/${APPNAME} /tmp/Gooby/
			tar -xpf ${RESTOREFOLDER}/${APPNAME}-full.tar.gz -C /
			tar --incremental -xpf ${APPNAME}-diff.tar.gz

			sudo chown $USER:$USER ${CONFIGS}
			sudo chown $USER:$USER ${HOME}

			cd $CONFIGS/Docker
			source /opt/Gooby/install/misc/environment-build.sh rebuild
			/usr/local/bin/docker-compose up -d --remove-orphans ${@:2}
			cd "${CURDIR}"

		fi

		echo
		echo " ${CYAN}Finished restoring${STD}"
		echo
		echo
		echo " ${WHITE}Make sure${STD} you check if your services are"
		echo "running properly before you remove the old files!"
		echo
		read -n 1 -s -r -p " Remove old files (Y/n)? " -i "" choice
		echo

		case "$choice" in
			y|Y ) sudo rm -r /tmp/Gooby;;
			* ) echo Your old installation files are available; echo at /tmp/Gooby until you reboot; echo;;
		esac

		sudo rm -r ${RESTOREFOLDER}

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm $CONFIGS/.config/checkapp.txt
PAUSE
