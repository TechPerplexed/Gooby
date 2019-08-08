#!/bin/bash

source $CONFIGS/Docker/.env
which rclone > $CONFIGS/.config/checkapp.txt
clear

if [ ! -s $CONFIGS/.config/checkapp.txt ]; then

	echo "${YELLOW}"
	echo "--------------------------------------------------"
	echo " You will need to install and configure"
	echo " Rclone before you can restore the backup!"
	echo "--------------------------------------------------"
	echo "${STD}"

else

	EXPLAINTASK

	CONFIRMATION

	if [[ ${REPLY} =~ ^[Yy]$ ]]; then

		GOAHEAD

		mkdir -p /tmp/goobyrestore
		RESTOREFOLDER=/tmp/goobyrestore
		OLDFILES=/tmp/Gooby

		echo " Restoring the backup can take several hours"
		echo " please don't exit the terminal until it's done!"
		echo
		read -e -p " Server to restore: " -i "${SERVER}" SERVER
		echo
		echo " App name to restore: (for example, ${LYELLOW}Docker${STD} or ${LYELLOW}Plex${STD})"
		echo " You can find your app names in ${RCLONESERVICE}:/Backup/${SERVER}/Gooby"
		echo " You can type ${LYELLOW}All${STD} for all apps,"
		echo " Or ${LYELLOW}Home${STD} for restoring your /home/${USER} directory"
		echo
		read -e -p " App to restore: " -i "All" APPNAME
		shopt -s nocasematch

		echo
		echo " ${LMAGENTA}Copying ${APPNAME} backup from ${RCLONESERVICE}...${STD}"

		case "${APPNAME}" in

			all )

				/usr/bin/rclone --stats-one-line -P copy ${RCLONESERVICE}:/Backup/${SERVER}/Gooby --include '*' ${RESTOREFOLDER} --checksum --drive-chunk-size=64M

				[ ! -f ${RESTOREFOLDER}/*-full.tar.gz ] && echo " ${LRED}${APPNAME} backup not found on ${RCLONESERVICE}!${STD}"; PAUSE; exit
				
				echo
				echo " ${LBLUE}${APPNAME} backup downloaded, proceeding...${STD}"
				echo

				echo
				echo " ${YELLOW}Taking containers down...${STD}"

				cd $CONFIGS/Docker
				/usr/local/bin/docker-compose down
				cd "${CURDIR}"

				echo
				echo " ${GREEN}Restoring files...${STD}"
				echo

				sudo mv $CONFIGS/ ${OLDFILES}
				
				tar -xpvf ${RESTOREFOLDER}/*-full.tar.gz ${CONFIGS}
				[ -f ${RESTOREFOLDER}/*-diff.tar.gz ] && tar --incremental -xpvf *-diff.tar.gz ${CONFIGS}

				sudo chown $USER:$USER ${CONFIGS}

				cd $CONFIGS/Docker
				source /opt/Gooby/install/misc/environment-build.sh rebuild
				/usr/local/bin/docker-compose up -d --remove-orphans ${@:2}
				cd "${CURDIR}"

			;;

			home )

				/usr/bin/rclone --stats-one-line -P copy ${RCLONESERVICE}:/Backup/${SERVER}/${SERVER}-backup.tar.gz ${RESTOREFOLDER} --checksum --drive-chunk-size=64M

				[ ! -f ${RESTOREFOLDER}/${SERVER}-backup.tar.gz ] && echo; echo " ${LRED}Sorry, no backup found on ${RCLONESERVICE}!${STD}"; PAUSE; exit

				echo
				echo " ${GREEN}Restoring Gooby...${STD}"
				echo

				tar -xpvf ${RESTOREFOLDER}/${SERVER}-backup.tar.gz -C /
				sudo chown $USER:$USER ${HOME}

			;;

			* )

				echo "+ ${APPNAME}*" > $CONFIGS/.config/checkapp.txt
				echo "- *" >> $CONFIGS/.config/checkapp.txt
				/usr/bin/rclone --stats-one-line -P copy ${RCLONESERVICE}:/Backup/${SERVER}/Gooby --ignore-case --filter-from $CONFIGS/.config/checkapp.txt ${RESTOREFOLDER} --checksum --drive-chunk-size=64M

				[ ! -f ${RESTOREFOLDER}/*-full.tar.gz ] && echo " ${LRED}${APPNAME} backup not found on ${RCLONESERVICE}!${STD}"; rm $CONFIGS/.config/checkapp.txt; PAUSE; exit

				cd $CONFIGS/Docker
				/usr/local/bin/docker-compose down
				cd "${CURDIR}"

				echo
				echo " ${GREEN}Restoring ${APPNAME}...${STD}"
				echo

				sudo mv $CONFIGS/${APPNAME}/ ${OLDFILES}

				tar -xpvf ${RESTOREFOLDER}/*-full.tar.gz ${CONFIGS}
				[ -f ${RESTOREFOLDER}/*-diff.tar.gz ] && tar --incremental -xpvf *-diff.tar.gz ${CONFIGS}

				sudo chown $USER:$USER ${CONFIGS}

				cd $CONFIGS/Docker
				source /opt/Gooby/install/misc/environment-build.sh rebuild
				/usr/local/bin/docker-compose up -d --remove-orphans ${@:2}
				cd "${CURDIR}"

			;;

		esac

		echo
		echo " ${CYAN}Finished restoring ${APPNAME}${STD}"
		echo

		echo
		echo " ${WHITE}Make sure${STD} you check if your services are"
		echo " running properly before you remove the old installation!"
		echo
		read -n 1 -s -r -p " Remove old installation files (Y/n)? " -i "" choice
		echo

		case "$choice" in
			y|Y ) sudo rm -r ${OLDFILES};;
			* ) echo " Your old installation files are available"; echo " at ${OLDFILES} until you reboot"; echo;;
		esac

		sudo rm -r ${RESTOREFOLDER}

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm $CONFIGS/.config/checkapp.txt

PAUSE
