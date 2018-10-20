#!/bin/bash

clear

EXPLAINTASK

CONFIRMATION

if [[ ${REPLY} =~ ^[Yy]$ ]]; then

	clear
	sudo rm -r /opt/GooPlex
	sudo git clone -b develop https://github.com/TechPerplexed/GooPlex /opt/GooPlex
	sudo chmod +x -R /opt/GooPlex/install
	sudo chmod +x -R /opt/GooPlex/menus
	sudo rsync -a /opt/GooPlex/install/gooplex /bin
	sudo chmod 755 /bin/gooplex

	clear

	TASKCOMPLETE

else

	CANCELTHIS

fi

PAUSE
