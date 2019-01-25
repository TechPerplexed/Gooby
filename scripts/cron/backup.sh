#!/bin/bash
if pidof -o %PPID -x "$(basename $0)"; then
	echo Already running!
	exit 1
fi

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

APILOG=$LOGS/api.log

BYTES=$(find /tmp -name '${BACKUP}' -exec du -bc {} + | grep total$ | cut -f1 | awk '{ total += $1 }; END { print total }')
echo $(date '+%F %H:%M:%S'),START,1,${BYTES} >> ${APILOG}
/usr/bin/rclone copy ${BACKUP} $RCLONESERVICE:/Backup/$(hostname) --checksum --drive-chunk-size=64M
echo $(date '+%F %H:%M:%S'),STOP,1,${BYTES} >> ${APILOG}

sudo rm ${BACKUP}
