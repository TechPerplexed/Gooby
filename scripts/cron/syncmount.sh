#!/bin/bash
if pidof -o %PPID -x "$(basename $0)"; then
	echo Already running!
	exit 1
fi

source /opt/Gooby/menus/variables.sh
source $CONFIGS/Docker/.env

# Check to see if anything needs to be cached locally.  Doing this before the sync allows new files to be copied locally first.

[ -f $HOME/bin/localcache ] && $HOME/bin/localcache

# Load existing variables and use them as defaults, if available

AGE=2	# How many minutes old a file must be before copying/deleting
LOG=${LOGS}/mounter-sync.log
APILOG=${LOGS}/api.log

# Conservative options (slower but safe)
#OPTIONS="--checkers 3 --fast-list --tpslimit 2 --delete-during --delete-excluded --checksum --transfers 5 --drive-chunk-size=16M -v"

# Turbo options (faster but could interfere with processes)
OPTIONS="--checkers 5 --fast-list --tpslimit 5 --delete-during --delete-excluded --checksum --transfers 8 --drive-chunk-size=16M -v"

TEMPFILE="/tmp/filesmissing"

echo Starting sync at $(date) | tee -a ${LOG}

# Fix dates in the future

find ${UPLOADS}/ ! -path "*Downloads*" -type f -mmin -0 -exec touch "{}" -d "$(date -d "-5 minutes")" \;

# Identify files needing to be copied

find ${UPLOADS}/ ! -path "*Downloads*" -type f -mmin +${AGE} | sed 's|'${UPLOADS}'||' | sort > ${TEMPFILE}
BYTES=$(find ${UPLOADS}/ ! -path "*Downloads*" -type f -mmin +${AGE} -exec du -bc {} + | grep total$ | cut -f1 | awk '{ total += $1 }; END { print total }')

# Copy files

if [[ -s ${TEMPFILE} ]]
then
	echo Copying files | tee -a ${LOG}
	cat ${TEMPFILE} | tee -a ${LOG}
	FILECOUNT=$(cat ${TEMPFILE} |wc -l)
	echo Files to copy: ${FILECOUNT} | tee -a ${LOG}
	echo Bytes to copy: ${BYTES} | tee -a ${LOG}
	echo $(date '+%F %H:%M:%S'),START,${FILECOUNT},${BYTES} >> ${APILOG}
	/usr/bin/rclone move ${UPLOADS} ${RCLONESERVICE}:${RCLONEFOLDER} --files-from ${TEMPFILE} ${OPTIONS}
	echo $(date '+%F %H:%M:%S'),STOP,${FILECOUNT},${BYTES} >> ${APILOG}
else
	echo Nothing to copy | tee -a ${LOG}
fi

# Cleanup letovers

rm ${TEMPFILE}
cd ${UPLOADS}
find . -type d -empty -delete
mkdir -p ${UPLOADS} ${UPLOADS}/Downloads
echo Finished at $(date) | tee -a ${LOG}
echo --------------------------------------------------- | tee -a ${LOG}
