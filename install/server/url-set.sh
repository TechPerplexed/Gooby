#!/bin/bash

clear

EXPLAINTASK

CONFIRMATION

if [[ ${REPLY} =~ ^[Yy]$ ]]; then

	GOAHEAD

	sudo mkdir -p $CONFIGS/.config
	sudo chown -R $USER:$USER $CONFIGS

	[[ -s $CONFIGS/.config/seturl ]] && echo "Your URL is currently set to $URL" || echo "Your URL is currently set to $PUBLICIP"

	read -p "New url: " SETURL

	if [[ -z "$SETURL" ]]; then

		echo "No input entered... no changes made!"

	else

		echo "$SETURL" > $CONFIGS/.config/seturl

		URL=$( cat $CONFIGS/.config/seturl )

		echo "Your new URL is set to $URL"
		echo "Remember to point it to IP address $PUBLICIP"

		TASKCOMPLETE

	fi

else

	CANCELTHIS

fi

PAUSE
