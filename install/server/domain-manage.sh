#!/bin/bash

clear

EXPLAINTASK

CONFIRMATION

if [[ ${REPLY} =~ ^[Yy]$ ]]; then

	GOAHEAD

	[[ -e $CONFIGS/.config/mydomain ]] && echo "Your domain is currently set to $(cat $CONFIGS/.config/mydomain)"

	read -p "Your new domain: " SETURL

	if [[ -z "$SETURL" ]]; then

		echo "No input entered... no changes made!"

	else

		echo "$SETURL" > $CONFIGS/.config/mydomain

		MYDOMAIN=$(cat $CONFIGS/.config/mydomain)

		echo "Your new domain is set to $MYDOMAIN"
		echo "Remember to point it to IP address $PUBLICIP"

		TASKCOMPLETE

	fi

else

	CANCELTHIS

fi

PAUSE
