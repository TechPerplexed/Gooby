#!/bin/bash

clear

EXPLAINTASK

CONFIRMATION

if [[ ${REPLY} =~ ^[Yy]$ ]]; then

	GOAHEAD
    
	sudo apt-get update
	sudo apt-get upgrade -y
	sudo apt-get dist-upgrade -y
	sudo apt autoremove -y
	sudo apt autoclean
	sudo apt-get autoremove

	TASKCOMPLETE

else

	CANCELTHIS

fi

PAUSE
