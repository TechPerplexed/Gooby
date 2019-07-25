#!/bin/bash
if pidof -o %PPID -x "$(basename $0)"; then
	echo Already running!
	exit 1
fi

source /opt/Gooby/menus/variables.sh
source $CONFIGS/Docker/.env

SERVER=$(hostname)
APILOG="${LOGS}/api.log"

# Make sure there's a place to store backup index for full versus differential
mkdir -p ${HOME}/backup/snapshots
SNAPSHOTS="${HOME}/backup/snapshots"

rmove() {
	SOURCE=${1}
	TARGET=${2}
	SOURCEDIR=$(dirname "${SOURCE}")
	SOURCEFILE=$(basename "${SOURCE}")
	BYTES=$(stat --printf="%s" "${SOURCE}")
	echo "${TARGET} @ ${BYTES} Bytes"
	echo $(date '+%F %H:%M:%S'),START,1,${BYTES} "# ${SOURCE}" >> ${APILOG}
	/usr/bin/rclone rc operations/movefile _async=true srcFs=Local: srcRemote=${SOURCE} dstFs=${RCLONESERVICE}: dstRemote=${TARGET} --user ${RCLONEUSERNAME} --pass ${RCLONEPASSWORD} > /dev/null
}

cd ${HOME}
echo Creating backup
sudo crontab -u ${USER} -l > /home/${USER}/backup/cron
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
for f in ${FILES}
do
	FILENAME="$(basename "${f}")"
	echo -n "${f} --> "
	if [[ ${f: -3} == 'tar' ]] || [[ ${f: -3} == ".gz" ]] || [[ ${f: -3} == "bz2" ]]
	then
		cp "${f}" /tmp/
		rmove "/tmp/${FILENAME}" "/Backup/${SERVER}/Gooby/${FILENAME}"
	else
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
			# Future differential backups are based on the original, not the previous
			# Differential
			mv "${SNAPSHOTS}/${FILENAME}.bak" "${SNAPSHOTS}/${FILENAME}.snar"
		fi
		rmove "/tmp/${FILENAME2}.tar.gz" "/Backup/${SERVER}/Gooby/${FILENAME2}.tar.gz"
		cp "${SNAPSHOTS}/${FILENAME}.snar" /tmp/
		rmove "/tmp/${FILENAME}.snar" "/Backup/${SERVER}/Gooby/snapshots/${FILENAME}.snar"
	fi
done
