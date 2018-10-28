#!/bin/bash

MENU="Maintain Server"
source /opt/Gooby/menus/variables.sh

# Menu Options

PATCHES(){
	PERFORM="password"
	TASK="change"
	source /opt/Gooby/install/server/${TASK}-${PERFORM}.sh
}

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

QUIT(){
	exit
}

# Display menu

show_menus() {
	clear
	echo " ${YELLOW}"
	MENUSTART
	echo " ${YELLOW}A${STD} - Update Server with Latest Patches"
	echo " ${YELLOW}B${STD} - Manage Domain Name"
	echo " ${YELLOW}C${STD} - Manage Email Address"
	echo " ${YELLOW}D${STD} - Set Timezone"
	echo " ${YELLOW}E${STD} - Server Upgrade - Danger zone!"
	echo " ${WHITE}Z${STD} - EXIT to Main Menu"
	echo " ${YELLOW}"
	MENUEND
}

# Read Choices

read_options(){
	local choice
	read -n 1 -s -r -p "Choose option: " choice
	case $choice in
		[Aa]) PATCHES ;;
		[Bb]) DOMAIN ;;
		[Cc]) EMAILADDR ;;
		[Dd]) TZONE ;;
		[Ee]) UPGRADE ;;
		[Zz]) QUIT ;;
		*) echo "${LRED}Please select a valid option${STD}" && sleep 2
	esac
}

MENUFINALIZE
