#!/bin/bash

clear

EXPLAINTASK

CONFIRMATION

if [[ ${REPLY} =~ ^[Yy]$ ]]; then

	GOAHEAD

	[[ -s $CONFIGS/.config/seturl ]] && echo "Your domain is currently set to $URL" || echo "You have not set a domain yet"

	read -p "New URL (domain address): " SETURL

	if [[ -z "$SETURL" ]]; then

		echo "No input entered... no changes made!"

	else

		echo "$SETURL" > $CONFIGS/.config/seturl

		URL=$( cat $CONFIGS/.config/seturl )

		echo "Your new domain is set to $URL"
		echo "Remember to point it to IP address $PUBLICIP"

		TASKCOMPLETE

	fi

else

	CANCELTHIS

fi

PAUSE
