#!/bin/bash

clear

EXPLAINTASK

CONFIRMATION

if [[ ${REPLY} =~ ^[Yy]$ ]]; then

	GOAHEAD

	OLDDOMAIN=$(cat ${CONFIGVARS}/mydomain)
	echo "Your domain is currently set to ${OLDDOMAIN}"

	read -p "Your new domain: " SETURL

	if [[ -z "${SETURL}" ]]; then

		echo "No input entered... no changes made!"

	else

		echo "${SETURL}" > ${CONFIGVARS}/mydomain

		MYDOMAIN=$(cat ${CONFIGVARS}/mydomain)

		echo ""
		echo "Just a moment while your new domain is being installed..."
		echo ""
		cd ${CONFIGS}/Docker
		sudo sed -i "s/${OLDDOMAIN}/${MYDOMAIN}/g" ${CONFIGS}/Docker/traefik/traefik.toml

		/usr/local/bin/docker-compose down
		source /opt/Gooby/install/misc/environment-build.sh rebuild
		/usr/local/bin/docker-compose up -d --remove-orphans
		cd "${CURDIR}"
		clear
		source ${CONFIGS}/Docker/.env

		echo
		echo "Your new domain is set to ${MYDOMAIN}"
		echo "Remember to point it to IP address ${IP}"

		TASKCOMPLETE

	fi

else

	CANCELTHIS

fi

PAUSE
