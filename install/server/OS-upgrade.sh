#!/bin/bash

clear

echo -e "--------------------------------------------------"
echo -e " ~~~ ${RED}DANGER ZONE!!!${STD} ~~~"
echo -e " This will upgrade your OS software"
echo -e " ${YELLOW}CAUTION!!!${STD} Make SURE you have a backup!"
echo -e "--------------------------------------------------"
echo ""

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
	sudo apt install update-manager-core -y
	sudo do-release-upgrade

	TASKCOMPLETE

else

	CANCELTHIS

fi

PAUSE
