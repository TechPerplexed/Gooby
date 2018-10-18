#!/bin/bash

clear

EXPLAINTASK

echo "${LRED}"
echo "--------------------------------------------------"
echo " DANGER ZONE - EXTREME CAUTION!!!"
echo " You are about to switch back to"
echo " the original branch of GooPlex"
echo " There is NO downgrade path!!"
echo " Many functions won't work any longer."
echo " Please only downgrade if you haven't"
echo " made any changes yet!"
echo "--------------------------------------------------"
echo "${STD}"

CONFIRMATION

if [[ ${REPLY} =~ ^[Yy]$ ]]; then

	clear
	sudo rm -r /opt/GooPlex
	sudo git clone -b legacy https://github.com/TechPerplexed/GooPlex /opt/GooPlex
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
