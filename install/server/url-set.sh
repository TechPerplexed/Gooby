#!/bin/bash

clear

EXPLAINTASK

CONFIRMATION

if [[ ${REPLY} =~ ^[Yy]$ ]]; then

	GOAHEAD

	sudo mkdir -p $CONFIGS/.config
	sudo chown -R $USER:$USER $CONFIGS

	if [ ! -f $CONFIGS/.config/seturl ]; then

		echo "You have not set an URL yet"

	else

		echo "Your URL is currently set to $URL"

	fi

	read -p "New url: " SETURL

	if [[ -z "$SETURL" ]]; then

		echo "No input entered... no changes made!"

	else

		echo "$SETURL" > $CONFIGS/.config/seturl

		URL=$( cat $CONFIGS/.config/seturl )

		echo "Your new URL is set to $URL"

		TASKCOMPLETE

	fi

else

	CANCELTHIS

fi

PAUSE
