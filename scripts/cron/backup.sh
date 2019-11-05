#!/bin/bash
if pidof -o %PPID -x "$(basename $0)"; then
	echo Already running!
	exit 1
fi

source /opt/Gooby/menus/variables.sh
source $CONFIGS/Docker/.env

# Make sure there's a place to store backup index for full versus differential
mkdir -p ${CONFIGVARS}/snapshots
SNAPSHOTS=${CONFIGVARS}/snapshots

rmove() {
	# This function handles moving a file from the local storage to Google.  It will display
	# the original path as well as the target and file size upon completion.
	SOURCE=${1}
	TARGET=${2}
	SOURCEDIR=$(dirname "${SOURCE}")
	SOURCEFILE=$(basename "${SOURCE}")
	BYTES=$(stat --printf="%s" "${SOURCE}")
	echo -n "${TARGET} @ "
	/bin/sizer ${BYTES}
	echo $(date '+%F %H:%M:%S'),START,1,${BYTES} "# ${SOURCE}" >> ${APILOG}
	/usr/bin/rclone rc operations/movefile _async=true srcFs=Local: srcRemote=${SOURCE} dstFs=${RCLONESERVICE}: dstRemote=${TARGET} --user ${RCLONEUSERNAME} --pass ${RCLONEPASSWORD} > /dev/null
}

cd ${HOME}
echo Creating backup - please be patient...; echo
# Dump the user's CRONTAB to the local home directory so that it can be included in the backup.
sudo crontab -u ${USER} -l > /home/${USER}/cron
# Create the home folder backup.
echo -n "/tmp/${SERVER}-backup.tar.gz --> "
sudo tar -cpf /tmp/${SERVER}-backup.tar.gz \
	--use-compress-program=pigz \
	--exclude=.cache \
	--exclude=/home/${USER}/Downloads \
	/home/${USER} > /dev/null 2>&1
sudo chown ${USERID}:${GROUPID} /tmp/${SERVER}-*.tar.gz
rmove "/tmp/${SERVER}-backup.tar.gz" "/Backup/${SERVER}/${SERVER}-backup.tar.gz"

cd ${CONFIGS}

FILES=${CONFIGS}/*
# Loop through each filename / directory name in the Configs directory
for f in ${FILES}
do
	FILENAME="$(basename "${f}")"
	echo -n "${f} --> "
	if [[ -f "${f}" ]]
	then
		# This is a file, not a directory.  So, we're just going to copy it to Google
		# as is (no tar/zip).
		cp "${f}" /tmp/
		rmove "/tmp/${FILENAME}" "/Backup/${SERVER}/Gooby/${FILENAME}"
	else
		# This is a directory so we're going to pack it up into /tmp and then ship
		# it off to Google drive.
		if [[ -f "${SNAPSHOTS}/${FILENAME}.snar" ]]
		then
			# We already have a snar, which means that this is a differential
			FULL=0
			cp "${SNAPSHOTS}/${FILENAME}.snar" "${SNAPSHOTS}/${FILENAME}.bak"
			FILENAME2="${FILENAME}-diff"
		else
			# No snar found, so we're doing the full backup
			FULL=1
			FILENAME2="${FILENAME}-full"
		fi
		sudo tar --listed-incremental "${SNAPSHOTS}/${FILENAME}.snar" \
			-cpf "/tmp/${FILENAME2}.tar.gz" \
			--use-compress-program=pigz \
			--exclude=.cache \
			"${FILENAME}" > /dev/null 2>&1
		sudo chown ${USERID}:${GROUPID} "/tmp/${FILENAME2}.tar.gz" "${SNAPSHOTS}/${FILENAME}.snar"
		if [[ ${FULL} -eq 0 ]]
		then
			# If this is a differential, we want to remember the original so that
			# future differential backups are based on the original, not the previous
			# differential
			mv "${SNAPSHOTS}/${FILENAME}.bak" "${SNAPSHOTS}/${FILENAME}.snar"
		else
			# This is a full so remove any previous differential
			echo -n "Removing outdated DIFF for ${FILENAME} --> "
			/usr/bin/rclone rc operations/deletefile _async=true fs=${RCLONESERVICE}: remote="/Backup/${SERVER}/Gooby/${FILENAME}-diff.tar.gz"  --user ${RCLONEUSERNAME} --pass ${RCLONEPASSWORD} > /dev/null

		fi
		rmove "/tmp/${FILENAME2}.tar.gz" "/Backup/${SERVER}/Gooby/${FILENAME2}.tar.gz"
		# cp "${SNAPSHOTS}/${FILENAME}.snar" /tmp/
		# rmove "/tmp/${FILENAME}.snar" "/Backup/${SERVER}/Gooby/snapshots/${FILENAME}.snar"
	fi
done

rm /home/${USER}/cron
