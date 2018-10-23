#!/bin/bash

clear

EXPLAINTASK

CONFIRMATION

if [[ ${REPLY} =~ ^[Yy]$ ]]; then

	GOAHEAD

	[[ -e $CONFIGS/.config/myemail ]] && echo "Your email address is currently set to $(cat $CONFIGS/.config/myemail)"

	read -p "Your new email address: " SETMAIL

	if [[ -z "$SETMAIL" ]]; then

		echo "No input entered... no changes made!"

	else

		echo "$SETMAIL" > $CONFIGS/.config/myemail

		MYEMAIL=$(cat $CONFIGS/.config/myemail)
		
		/opt/Gooby/install/misc/environment-build.sh rebuild
		source $CONFIGS/Docker/.env

		echo "Your new email address is set to $MYEMAIL"

		TASKCOMPLETE

	fi

else

	CANCELTHIS

fi

PAUSE
