#!/bin/bash

clear

EXPLAINTASK

CONFIRMATION

if [[ ${REPLY} =~ ^[Yy]$ ]]; then

	GOAHEAD
    
	sudo dpkg-reconfigure tzdata
	echo
	echo "Your timezone is now set to ${CYAN}$( cat /etc/timezone )${STD}"
	echo

	TASKCOMPLETE

else

	CANCELTHIS

fi

PAUSE
