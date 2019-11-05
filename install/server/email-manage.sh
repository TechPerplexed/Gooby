#!/bin/bash

clear

EXPLAINTASK

CONFIRMATION

if [[ ${REPLY} =~ ^[Yy]$ ]]; then

	GOAHEAD

	[[ -e ${CONFIGVARS}/myemail ]] && echo "Your email address is currently set to $(cat ${CONFIGVARS}/myemail)"

	read -p "Your new email address: " SETMAIL

	if [[ -z "$SETMAIL" ]]; then

		echo "No input entered... no changes made!"

	else

		echo "$SETMAIL" > ${CONFIGVARS}/myemail

		MYEMAIL=$(cat ${CONFIGVARS}/myemail)
		
		/opt/Gooby/install/misc/environment-build.sh rebuild
		source $CONFIGS/Docker/.env

		echo "Your new email address is set to $MYEMAIL"

		TASKCOMPLETE

	fi

else

	CANCELTHIS

fi

PAUSE
