#!/bin/bash

clear

EXPLAINTASK

CONFIRMATION

if [[ ${REPLY} =~ ^[Yy]$ ]]; then

	GOAHEAD
    
	sudo dpkg-reconfigure tzdata

	TASKCOMPLETE

else

	CANCELTHIS

fi

PAUSE
