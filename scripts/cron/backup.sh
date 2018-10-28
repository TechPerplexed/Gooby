#!/bin/bash

source /opt/Gooby/menus/variables.sh

echo -e "${LMAGENTA}Creating backup file...${STD}"

sudo tar -cf ${BACKUP} $CONFIGS --exclude-caches-all

sudo chown $USER:$USER ${BACKUP}

echo -e "${GREEN}Copying to Google...${STD}"

/usr/bin/rclone copy ${BACKUP} Gdrive:/Backup/$(hostname) --checksum --drive-chunk-size=64M
sudo rm ${BACKUP}

sudo chown $USER:$USER ${CONFIGS}
sudo chown $USER:$USER ${HOME}
