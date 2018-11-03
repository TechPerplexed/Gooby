#!/bin/bash
if pidof -o %PPID -x "$(basename $0)"; then
	echo Already running!
	exit 1
fi

source ~/.bashrc ~/.profile

PID=${$}
OMNI=/var/local/Gooby/Docker

LOCAL=/mnt/upload
DEST1=Gdrive
AGE=2		# How many minutes old a file must be before copying/deleting
SYNCTIME=5	# How many minutes does it take your mount to notice a change (max)
LOG=${HOME}/logs/mounter-sync.log
COMMANDS=${HOME}/logs/commands.sh
META=".unionfs-fuse"
SUFFIX="_HIDDEN~"

echo Starting sync at $(date) | tee -a ${LOG}

# Identify files needing to be copied

find ${LOCAL} ! -path "*Downloads*" ! -path *${META}* -type f -mmin +${AGE} | sed 's|/mnt/upload/||' | sort > /tmp/filesmissing

# Copy files

if [[ -s /tmp/filesmissing ]]
then
	echo Copying files | tee -a ${LOG}
	cat /tmp/filesmissing | tee -a ${LOG}
	echo Files to copy: $(cat /tmp/filesmissing |wc -l) | tee -a ${LOG}
	#/usr/bin/rclone move ${LOCAL} ${DEST1}: --tpslimit 4 --bwlimit 20M --delete-during --delete-excluded --checksum --transfers 8 --drive-chunk-size=16M --files-from /tmp/filesmissing -v
	/usr/bin/rclone move ${LOCAL} ${DEST1}: --checkers 3 --fast-list --tpslimit 3 --delete-during --delete-excluded --checksum --transfers 3 --drive-chunk-size=16M --files-from /tmp/filesmissing -v
else
	echo Nothing to copy | tee -a ${LOG}
fi

# Cleanup letovers

rm /tmp/filesmissing
cd ${LOCAL}
find . -type d -empty -delete
#mkdir -p ${LOCAL}/Plex
echo Finished at $(date) | tee -a ${LOG}
echo --------------------------------------------------- | tee -a ${LOG}
