#!/bin/bash

source /opt/Gooby/menus/variables.sh
source $CONFIGS/Docker/.env
BACKUP=/tmp/$(date +%F).tar.gz

echo
echo "${LMAGENTA}Creating backup file...${STD}"
echo

sudo tar -cf ${BACKUP} $CONFIGS --exclude-caches-all
sudo chown $USER:$USER ${BACKUP}

echo
echo "${GREEN}Copying to Google...${STD}"
echo

/usr/bin/rclone copy ${BACKUP} $RCLONESERVICE:/Backup/$(hostname) --checksum --drive-chunk-size=64M
sudo rm ${BACKUP}
