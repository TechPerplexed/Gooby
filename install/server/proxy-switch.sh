#!/bin/bash

clear

EXPLAINTASK

CONFIRMATION

if [[ ${REPLY} =~ ^[Yy]$ ]]; then

	GOAHEAD

	clear

	echo
	echo " Coming soon! Stay tuned..."
	echo

	TASKCOMPLETE

else

	CANCELTHIS

fi

PAUSE
