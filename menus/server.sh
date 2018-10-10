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

# Update Server
UPDATE(){
	PERFORM="initialize"
	TASK="server"
	source /opt/GooPlex/install/server/vpsupdate.sh
}

# Update Server
PATCHES(){
	PERFORM="update"
	TASK="server patches"
	source /opt/GooPlex/install/server/vpspatches.sh
}

# Update Server
UPGRADE(){
	PERFORM="upgrade"
	TASK="Ubuntu"
	source /opt/GooPlex/install/server/vpsupgrade.sh
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
	echo -e " ${YELLOW}A${STD} - Initialize Server"
	echo -e " ${YELLOW}B${STD} - Run Server Update"
	echo -e " ${YELLOW}C${STD} - Server Upgrade - Danger zone!"
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
		[Aa]) UPDATE ;;
		[Bb]) PATCHES ;;
		[Cc]) UPGRADE ;;
		[Zz]) QUIT ;;
		*) echo -e "${LRED}Please select a valid option${STD}" && sleep 2
	esac
}
 
# ----------
# Finalizing
# ----------

MENUFINALIZE
