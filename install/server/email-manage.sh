#!/bin/bash

clear

EXPLAINTASK

CONFIRMATION

if [[ ${REPLY} =~ ^[Yy]$ ]]; then

	GOAHEAD

	OLDEMAIL=$(cat ${CONFIGVARS}/myemail)

	echo "Your email address is currently set to ${OLDEMAIL}"

	read -p "Your new email address: " SETMAIL

	if [[ -z "${SETMAIL}" ]]; then

		echo "No input entered... no changes made!"

	else

		echo "${SETMAIL}" > ${CONFIGVARS}/myemail

		MYEMAIL=$(cat ${CONFIGVARS}/myemail)

		sudo sed -i "s/${OLDEMAIL}/${MYEMAIL}/g" ${CONFIGS}/Docker/traefik/traefik.toml

		/opt/Gooby/install/misc/environment-build.sh rebuild
		source ${CONFIGS}/Docker/.env

		echo; echo "Your new email address is set to ${MYEMAIL}"

		TASKCOMPLETE

	fi

else

	CANCELTHIS

fi

PAUSE
