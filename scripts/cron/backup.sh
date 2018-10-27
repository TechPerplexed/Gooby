#!/bin/bash

source /opt/Gooby/menus/variables.sh
BACKUP=/tmp/$(date +%F).tar.gz
sudo tar -cf ${BACKUP} $CONFIGS --exclude-caches-all
sudo chown $USER:$USER ${BACKUP}
/usr/bin/rclone copy ${BACKUP} Gdrive:/Backup/$(hostname) --checksum --drive-chunk-size=64M
sudo rm ${BACKUP}
sudo chown $USER:$USER ${CONFIGS}
sudo chown $USER:$USER ${HOME}
