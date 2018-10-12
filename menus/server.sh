#!/bin/bash

MENU="Maintain Server"
source /opt/GooPlex/menus/variables.sh

# Menu Options

PATCHES(){
	PERFORM="apply"
	TASK="patches"
	source /opt/GooPlex/install/server/${TASK}-${PERFORM}.sh
}

TIMEZONE(){
	PERFORM="set"
	TASK="timezone"
	source /opt/GooPlex/install/server/${TASK}-${PERFORM}.sh
}

SETURL(){
	PERFORM="set"
	TASK="url"
	source /opt/GooPlex/install/server/${TASK}-${PERFORM}.sh
}

SETEMAIL(){
	PERFORM="set"
	TASK="email"
	source /opt/GooPlex/install/server/${TASK}-${PERFORM}.sh
}

UPGRADE(){
	PERFORM="upgrade"
	TASK="version"
	source /opt/GooPlex/install/server/${TASK}-${PERFORM}.sh
}

QUIT(){
	exit
}

# Display menu

show_menus() {
	clear
	echo " ${YELLOW}"
	MENUSTART
	echo " ${YELLOW}A${STD} - Update server with latest patches"
	echo " ${YELLOW}B${STD} - Set server timezone"
	echo " ${YELLOW}C${STD} - Set server URL (web address)"
	echo " ${YELLOW}D${STD} - Set email address for certificats"
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
		[Bb]) TIMEZONE ;;
		[Cc]) SETURL ;;
		[Dd]) SETEMAIL ;;
		[Ee]) UPGRADE ;;
		[Zz]) QUIT ;;
		*) echo "${LRED}Please select a valid option${STD}" && sleep 2
	esac
}

MENUFINALIZE
