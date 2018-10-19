#!/bin/bash

PERFORM="create"
TASK="a new user"

source /opt/GooPlex/menus/variables.sh

EXPLAINTASK

echo "You are logged in as $USER"
echo "You will need to $PERFORM $TASK"

CONFIRMATION

if [[ ${REPLY} =~ ^[Yy]$ ]]; then

	read -e -p "${YELLOW}Desired username${STD}: " -i "" PU

	sudo -s adduser $PU

	sudo -s usermod -a -G sudo $PU
	sudo -s echo -e "$PU\tALL=(ALL)\tNOPASSWD:ALL" > /etc/sudoers.d/$PU
	sudo -s chmod 0440 /etc/sudoers.d/$PU

	clear
	echo -e "${GREEN}"
	echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo -e " You should now be switched to ${YELLOW}${PU}${GREEN}"
	echo -e "    Type ${WHITE}gooplex${GREEN} to access the menu."
	echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo -e "${STD}"

	su $PU

else

	CANCELTHIS
	MENUVISIT
	exit 0

fi

PAUSE
