#!/bin/bash

clear

EXPLAINAPP

echo "${YELLOW}"
echo "--------------------------------------------------"
echo " Create a backup of your user settings"
echo " It can be found in your Google Backup folder"
echo "--------------------------------------------------"
echo "${STD}"

CONFIRMATION

if [[ ${REPLY} =~ ^[Yy]$ ]]; then

	GOAHEAD

	BACKUP=/tmp/$(date +%F).tar.gz

	echo -e "The backup can take several hours, depending on the size"
	echo -e "Please don't exit the terminal until it's done!"
	echo ""

	echo -e "${LMAGENTA}Creating backup file...${STD}"

	sudo tar -cf ${BACKUP} \
	$CONFIGS \
	--exclude-caches-all

	sudo chown $USER:$USER ${BACKUP}

	echo -e "${LMAGENTA}Copying to Google...${STD}"

	/usr/bin/rclone copy ${BACKUP} Gdrive:/Backup/$(hostname) --checksum --drive-chunk-size=64M
	sudo rm ${BACKUP}

	sudo chown $USER:$USER ${CONFIGS}
	sudo chown $USER:$USER ${HOME}

	echo -e "${WHITE}Done!${STD}"

	TASKCOMPLETE

else

	CANCELTHIS

fi
