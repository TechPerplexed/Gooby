#!/bin/bash
if pidof -o %PPID -x "$(basename $0)"; then
	echo Already running!
	exit 1
fi

source /var/home/Gooby/Docker/.env

PID=${$}
AGE=2		# How many minutes old a file must be before copying/deleting
SYNCTIME=5	# How many minutes does it take your mount to notice a change (max)
LOG=${HOME}/logs/mounter-sync.log
COMMANDS=${HOME}/logs/commands.sh
META=".unionfs-fuse"
SUFFIX="_HIDDEN~"

echo Starting sync at $(date) | tee -a ${LOG}

# Identify files needing to be copied

find ${UPLOADS} ! -path "*Downloads*" ! -path *${META}* -type f -mmin +${AGE} | sed 's|${UPLOADS}||' | sort > $CONFIGS/.config/filesmissing

# Copy files

if [[ -s $CONFIGS/.config/filesmissing ]]
then
	echo Copying files | tee -a ${LOG}
	cat $CONFIGS/.config/filesmissing | tee -a ${LOG}
	echo Files to copy: $(cat $CONFIGS/.config/filesmissing |wc -l) | tee -a ${LOG}
	/usr/bin/rclone move ${UPLOADS} ${RCLONESERVICE}:${RCLONEFOLDER} --checkers 3 --fast-list --tpslimit 3 --delete-during --delete-excluded --checksum --transfers 3 --drive-chunk-size=16M --files-from $CONFIGS/.config/filesmissing -v
else
	echo Nothing to copy | tee -a ${LOG}
fi

# Cleanup letovers

rm $CONFIGS/.config/filesmissing
cd ${UPLOADS}
find . -type d -empty -delete
echo Finished at $(date) | tee -a ${LOG}
echo --------------------------------------------------- | tee -a ${LOG}
