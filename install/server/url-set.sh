#!/bin/bash

clear

EXPLAINTASK

CONFIRMATION

if [[ ${REPLY} =~ ^[Yy]$ ]]; then

	GOAHEAD
    
	echo "Coming soon!"

	TASKCOMPLETE

else

	CANCELTHIS

fi

PAUSE
