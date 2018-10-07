#!/bin/bash

clear

# Explanation

echo -e "${CYAN}"
echo -e "--------------------------------------------------"
echo -e " This will ${PERFORM} ${TASK}"
echo -e " You can run this as often as you like!"
echo -e "--------------------------------------------------"
echo -e "${STD}"

CONFIRMATION

if [[ ${REPLY} =~ ^[Yy]$ ]]; then

	# Main script

	clear
	cd ~
	sudo rm -r /opt/GooPlex
	sudo git clone https://github.com/TechPerplexed/GooPlex /opt/GooPlex
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
