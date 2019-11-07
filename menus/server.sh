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

show_menus() {
	clear
	echo " ${YELLOW}"
	MENUSTART
	echo " ${YELLOW}A${STD} - Manage Domain Name"
	echo " ${YELLOW}B${STD} - Manage Email Address"
	echo " ${YELLOW}C${STD} - Set Timezone"
	echo " ${YELLOW}D${STD} - Server Upgrade - Danger zone!"
	echo " ${YELLOW}E${STD} - Switch Proxy - Coming soon"
	echo " ${WHITE}Z${STD} - EXIT to Main Menu"
	echo " ${YELLOW}"
	MENUEND
}

# Read Choices

read_options(){
	local choice
	read -n 1 -s -r -p "Choose option: " choice
	case $choice in
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
