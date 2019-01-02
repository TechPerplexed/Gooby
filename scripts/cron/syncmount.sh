#!/bin/bash
if pidof -o %PPID -x "$(basename $0)"; then
	echo Already running!
	exit 1
fi

source ~/.bashrc ~/.profile
source /var/local/Gooby/Docker/.env

PID=${$}
CDIR=/var/local/Gooby/Docker
ENV=${CDIR}/.env

# Load existing variables and use them as defaults, if available

source ${ENV}

AGE=2		# How many minutes old a file must be before copying/deleting
LOG=${LOGS}/mounter-sync.log

echo Starting sync at $(date) | tee -a ${LOG}

# Identify files needing to be copied

find ${UPLOADS}/ ! -path "*Downloads*" -type f -mmin +${AGE} | sed 's|'${UPLOADS}'||' | sort > /tmp/filesmissing

# Copy files

if [[ -s /tmp/filesmissing ]]
then
	echo Copying files | tee -a ${LOG}
	cat /tmp/filesmissing | tee -a ${LOG}
	echo Files to copy: $(cat /tmp/filesmissing |wc -l) | tee -a ${LOG}
	echo /usr/bin/rclone move ${UPLOADS} ${RCLONESERVICE}:${RCLONEFOLDER} --checkers 3 --fast-list --tpslimit 2 --delete-during --delete-excluded --checksum --transfers 3 --drive-chunk-size=16M --exclude "Downloads/**" --min-age ${AGE}m
	/usr/bin/rclone move ${UPLOADS} ${RCLONESERVICE}:${RCLONEFOLDER} --checkers 3 --fast-list --tpslimit 2 --delete-during --delete-excluded --checksum --transfers 3 --drive-chunk-size=16M --exclude "Downloads/**" --min-age ${AGE}m
else
	echo Nothing to copy | tee -a ${LOG}
fi

# Cleanup letovers

rm /tmp/filesmissing
cd ${UPLOADS}
find . -type d -empty -delete
mkdir -p ${UPLOADS} ${UPLOADS}/Downloads
echo Finished at $(date) | tee -a ${LOG}
echo --------------------------------------------------- | tee -a ${LOG}
