#!/bin/bash

clear

EXPLAINTASK

CONFIRMATION

if [[ ${REPLY} =~ ^[Yy]$ ]]; then

	GOAHEAD
    
	sudo dpkg-reconfigure tzdata
	echo ""
	echo "Your timezone is now set to ${CYAN}$TIMEZONE${STD}"

	TASKCOMPLETE

else

	CANCELTHIS

fi

PAUSE
