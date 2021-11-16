#!/bin/bash

VERSION=2.2.3

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
	
	# Everything will be a variable soon
	
	[[ ! -f ${CONFIGVARS}/media ]] && echo "/mnt/google" > ${CONFIGVARS}/media
	[[ ! -f ${CONFIGVARS}/mediadata ]] && echo "Media" > ${CONFIGVARS}/mediadata
	[[ ! -f ${CONFIGVARS}/rclonemount ]] && echo "/mnt/rclone" > ${CONFIGVARS}/rclonemount
	[[ ! -f ${CONFIGVARS}/rclonepassword ]] && echo "Go0by" > ${CONFIGVARS}/rclonepassword
	[[ ! -f ${CONFIGVARS}/rcloneusername ]] && echo "gooby" > ${CONFIGVARS}/rcloneusername
	[[ ! -f ${CONFIGVARS}/unsynced ]] && echo "/mnt/local" > ${CONFIGVARS}/unsynced
	[[ ! -f ${CONFIGVARS}/uploads ]] && echo "/mnt/uploads" > ${CONFIGVARS}/uploads

	# Finalizing upgrade

	echo; echo "${GREEN}Upgrade to v${VERSION} complete... proceeding${STD}"; echo

fi

echo ${VERSION} > ${CONFIGVARS}/version
