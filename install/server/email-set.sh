#!/bin/bash

clear

EXPLAINTASK

CONFIRMATION

if [[ ${REPLY} =~ ^[Yy]$ ]]; then

	GOAHEAD

	sudo mkdir -p $CONFIGS/.config
	sudo chown -R $USER:$USER $CONFIGS

	if [ ! -f $CONFIGS/.config/setemail ]; then

		echo "You have not set an email address yet"

	else

		echo "Your email address is currently set to $EMAIL"

	fi

	read -p "New email address: " SETEMAIL

	if [[ -z "$SETEMAIL" ]]; then

		echo "No input entered... no changes made!"

	else

		echo "$SETEMAIL" > $CONFIGS/.config/setemail

		EMAIL=$( cat $CONFIGS/.config/setemail )

		echo "Your new email address is set to $EMAIL"

		TASKCOMPLETE

	fi

else

	CANCELTHIS

fi

PAUSE
