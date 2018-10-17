#!/bin/bash

clear

EXPLAINTASK

echo "${LRED}"
echo "--------------------------------------------------"
echo " DANGER ZONE - EXTREME CAUTION!!!"
echo " You are about to switch to"
echo " the development branch of GooPlex"
echo " There is NO upgrade path!!"
echo " Many functions won't work yet."
echo " Be prepared for some bleeding edge suffering ;)"
echo " Only use this on a test server!"
echo "--------------------------------------------------"
echo "${STD}"

CONFIRMATION

if [[ ${REPLY} =~ ^[Yy]$ ]]; then

	clear
	cd ~
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
