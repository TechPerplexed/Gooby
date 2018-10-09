#!/bin/bash

PERFORM="create"
TASK="a new user"

source /opt/GooPlex/menus/variables.sh

# Confirmation

clear
echo "${CYAN}"
echo "----------------------------------------------"
echo -e " You are logged in as root"
echo -e " You'd want to create a user!"
echo -e " What name do you want?"
echo "----------------------------------------------"
echo "${STD}"

CONFIRMATION

if [[ ${REPLY} =~ ^[Yy]$ ]]; then

	# Create user

	read -e -p "${YELLOW}Your username${STD} (Enter to accept): " -i "plexuser" PU

	if [ "$PU" != "plexuser" ]; then
		echo ""
		echo "I'm in the process of creating a new GooPlex."
		echo "For now, it's only possible to create the user 'plexuser'"
		echo "Stay tuned for a future update that makes it possible"
		echo "to choose $PU as your user name!"
		echo ""
		PU=plexuser
	fi

	sudo -s adduser $PU

	sudo -s usermod -a -G sudo $PU
	sudo -s echo -e "$PU\tALL=(ALL)\tNOPASSWD:ALL" > /etc/sudoers.d/$PU
	sudo -s chmod 0440 /etc/sudoers.d/$PU

	clear
	echo -e "${GREEN}"
	echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo -e " You should now be switched to ${YELLOW}${PU}{GREEN} "
	echo -e "    Type ${WHITE}gooplex${GREEN} to access the menu."
	echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo -e "${STD}"

	su $PU

	# Finalizing

else

	CANCELTHIS
	MENUVISIT
	exit 0

fi

PAUSE
