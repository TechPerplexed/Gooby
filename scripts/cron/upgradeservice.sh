#!/bin/bash

VERSION=2.2.2b

CONFIGVARS=${CONFIGS}/Docker/.config
sudo mkdir -p ${CONFIGVARS}
sudo chown -R ${USER}:${USER} ${CONFIGS}/Docker
touch ${CONFIGVARS}/version

if [ "$(cat ${CONFIGVARS}/version)" == ${VERSION} ]; then

	echo "${GREEN}Your system has already been upgraded to v${VERSION}... skipping upgrade${STD}"; echo

else

	echo "${LYELLOW}Upgrading to v${VERSION}... just a moment${STD}"; echo; sleep 2

	# Pull latest Docker Compose

	COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep 'tag_name' | cut -d\" -f4)
	sudo sh -c "curl -L https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose"
	sudo chmod +x /usr/local/bin/docker-compose
	
	# Parameterize everything
	
	[[ ! -f ${CONFIGVARS}/media ]] && echo "/mnt/google" > ${CONFIGVARS}/media
	[[ ! -f ${CONFIGVARS}/rclonemount ]] && echo "/mnt/rclone" > ${CONFIGVARS}/rclonemount
	[[ ! -f ${CONFIGVARS}/rclonepassword ]] && echo "Go0by" > ${CONFIGVARS}/rclonepassword
	[[ ! -f ${CONFIGVARS}/rcloneusername ]] && echo "gooby" > ${CONFIGVARS}/rcloneusername
	[[ ! -f ${CONFIGVARS}/localfiles ]] && echo "/mnt/local" > ${CONFIGVARS}/localfiles
	[[ ! -f ${CONFIGVARS}/uploads ]] && echo "/mnt/uploads" > ${CONFIGVARS}/uploads

	# Replace MOUNTTO with MEDIA in MergerFS service

	cat /etc/systemd/system/mergerfs.service | grep "MEDIA" > /dev/null
	if ! [[ ${?} -eq 0 ]]; then
		sudo sed -i "s/MOUNTTO/MEDIA/g" /etc/systemd/system/mergerfs.service
	fi

	# Replace UNSYNCED with LOCALFILES in MergerFS service

	cat /etc/systemd/system/mergerfs.service | grep "UNSYNCED" > /dev/null
	if ! [[ ${?} -eq 0 ]]; then
		sudo sed -i "s/UNSYNCED/LOCALFILES/g" /etc/systemd/system/mergerfs.service
	fi

	# Finalizing upgrade

	echo; echo "${GREEN}Upgrade to v${VERSION} complete... proceeding${STD}"; echo

fi

echo ${VERSION} > ${CONFIGVARS}/version
