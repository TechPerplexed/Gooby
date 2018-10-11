#!/bin/bash

MENU="Maintain Server"

# ---------
# Variables
# ---------

source /opt/GooPlex/menus/variables.sh
clear

# ------------
# Menu Options
# ------------

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

# Exit
QUIT(){
	exit
}

# ------------
# Display menu
# ------------

show_menus() {
	clear
	echo -e " ${YELLOW}"
	MENUSTART
	echo -e " ${YELLOW}A${STD} - Update server with latest patches"
	echo -e " ${YELLOW}B${STD} - Set server timezone"
	echo -e " ${YELLOW}C${STD} - -"
	echo -e " ${YELLOW}D${STD} - -"
	echo -e " ${YELLOW}E${STD} - Server Upgrade - Danger zone!"
	echo -e " ${WHITE}Z${STD} - EXIT to Main Menu"
	echo -e " ${YELLOW}"
	MENUEND
}

# ------------
# Read Choices
# ------------

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
		*) echo -e "${LRED}Please select a valid option${STD}" && sleep 2
	esac
}
 
# ----------
# Finalizing
# ----------

MENUFINALIZE
