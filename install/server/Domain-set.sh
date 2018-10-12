#!/bin/bash

clear

EXPLAINTASK

CONFIRMATION

if [[ ${REPLY} =~ ^[Yy]$ ]]; then

	GOAHEAD

	[[ -s $CONFIGS/.config/seturl ]] && echo "Your URL is currently set to $URL" || echo "You have not set an URL yet"

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
