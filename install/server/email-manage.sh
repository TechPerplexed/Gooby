#!/bin/bash

EXPLAINTASK

CONFIRMATION

if [[ ${REPLY} =~ ^[Yy]$ ]]; then

	GOAHEAD

	[[ -s $CONFIGS/.config/setemail ]] && echo "Your email address is currently set to $EMAIL" || echo "You have not set an email address yet." 

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
