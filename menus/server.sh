#!/bin/bash

MENU="Maintain Server"
source /opt/Gooby/menus/variables.sh

# Menu Options

DOMAIN(){
	PERFORM="manage"
	TASK="domain"
	source /opt/Gooby/install/server/${TASK}-${PERFORM}.sh
}

EMAILADDR(){
	PERFORM="manage"
	TASK="email"
	source /opt/Gooby/install/server/${TASK}-${PERFORM}.sh
}

TZONE(){
	PERFORM="manage"
	TASK="timezone"
	source /opt/Gooby/install/server/${TASK}-${PERFORM}.sh
}

UPGRADE(){
	PERFORM="upgrade"
	TASK="OS"
	source /opt/Gooby/install/server/${TASK}-${PERFORM}.sh
}

PROXYSWITCH(){
	PERFORM="switch"
	TASK="proxy"
	source /opt/Gooby/install/server/${TASK}-${PERFORM}.sh
}

QUIT(){
	exit
}

# Display menu

COLOUR=${YELLOW}

show_menus() {
	MENUSTART
	echo " ${COLOUR}A${STD} - Manage Domain Name"
	echo " ${COLOUR}B${STD} - Manage Email Address"
	echo " ${COLOUR}C${STD} - Set Timezone"
	echo " ${COLOUR}D${STD} - Server Upgrade - Danger zone!"
	echo " ${COLOUR}E${STD} - Switch Proxy"
	echo " ${WHITE}Z${STD} - EXIT to Main Menu"
	echo " ${COLOUR}"
	MENUEND
}

# Read Choices

read_options(){
	local CHOICE
	read -n 1 -s -r -p "Choose option: " CHOICE
	case ${CHOICE} in
		[Aa]) DOMAIN ;;
		[Bb]) EMAILADDR ;;
		[Cc]) TZONE ;;
		[Dd]) UPGRADE ;;
		[Ee]) PROXYSWITCH ;;
		[Zz]) QUIT ;;
		*) echo "${LRED}Please select a valid option${STD}" && sleep 1
	esac
}

MENUFINALIZE
