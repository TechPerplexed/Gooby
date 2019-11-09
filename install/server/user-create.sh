#!/bin/bash

MENU="Create User"
PERFORM="create"
TASK="a new user"

source /opt/Gooby/menus/variables.sh

EXPLAINTASK

echo "You are logged in as ${USER}"
echo "You will need to ${PERFORM} ${TASK}"

CONFIRMATION

if [[ ${REPLY} =~ ^[Yy]$ ]]; then

	read -e -p "${YELLOW}Desired username${STD}: " -i "yourname" PU

	sudo -s adduser ${PU}

	sudo -s usermod -a -G sudo ${PU}
	sudo -s echo -e "${PU}\tALL=(ALL)\tNOPASSWD:ALL" > /etc/sudoers.d/${PU}
	sudo -s chmod 0440 /etc/sudoers.d/${PU}

	COLOUR=${YELLOW}

	MENUSTART
	echo " You should now be switched to ${COLOUR}${PU}${STD}"
	echo " Type ${COLOUR}gooby${STD} to access the menu."
	echo " ${COLOUR}"
	MENUEND
	su ${PU}

else

	CANCELTHIS
	MENUVISIT
	exit 0

fi

PAUSE
