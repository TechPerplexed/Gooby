#!/bin/bash

clear

EXPLAINTASK

CONFIRMATION

if [[ ${REPLY} =~ ^[Yy]$ ]]; then

	GOAHEAD

	BACKUP=/tmp/$(date +%F).tar.gz

	echo -e "The backup can take several hours"
	echo -e "Please don't exit the terminal until it's done!"
	echo ""

	echo -e "${LMAGENTA}Creating backup file...${STD}"

	sudo crontab -u $USER -l > $CONFIGS/.config/cron
	sudo tar -cf ${BACKUP} \
	$CONFIGS \
	--exclude-caches-all

	sudo chown $USER:$USER ${BACKUP}

	echo -e "${LMAGENTA}Copying to Google...${STD}"

	/usr/bin/rclone copy ${BACKUP} Gdrive:/Backup/$(hostname) --checksum --drive-chunk-size=64M
	sudo rm ${BACKUP}

	sudo chown $USER:$USER ${CONFIGS}
	sudo chown $USER:$USER ${HOME}

	clear
	echo "${YELLOW}"
	echo "--------------------------------------------------"
	echo " Done! The backup can be found"
	echo " In your Google Backup folder"
	echo "--------------------------------------------------"
	echo "${STD}"

	TASKCOMPLETE

else

	CANCELTHIS

fi

PAUSE
