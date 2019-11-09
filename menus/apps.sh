#!/bin/bash

if [ ! -e ${CONFIGS}/Docker/.env ]; then /opt/Gooby/install/server/server-init.sh; fi

source ${CONFIGS}/Docker/.env

# Menu Options

INSTALL(){
	PERFORM="install"
	source /opt/Gooby/install/apps/${PERFORM}-${APPTYPE}.sh
}

REMOVE(){
	PERFORM="remove"
	source /opt/Gooby/install/apps/${PERFORM}-${APPTYPE}.sh
}

SECURE(){
	PERFORM="secure"
	source /opt/Gooby/install/apps/${PERFORM}-${APPTYPE}.sh
}

QUIT(){
	exit
}

# Display menu

COLOUR=${LPURPLE}

show_menus() {
	MENUSTART
	echo " ${COLOUR}I${STD} - Install ${TASK}"
	echo " ${COLOUR}R${STD} - Remove ${TASK}"
	echo " ${COLOUR}S${STD} - Secure ${TASK}"
	echo " ${WHITE}Z${STD} - EXIT to Main Menu"
	echo " ${COLOUR}"
	MENUEND
}

# Read Choices

read_options(){
	local CHOICE
	read -n 1 -s -r -p "Choose option: " CHOICE
	case ${CHOICE} in
		[Ii]) INSTALL ;;
		[Rr]) REMOVE ;;
		[Ss]) SECURE ;;
		[Zz]) QUIT ;;
		*) echo "${LRED}Please select a valid option${STD}" && sleep 1
	esac
}

MENUFINALIZE
