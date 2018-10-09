#!/bin/bash

MENU="GooPlex Menu"

# ---------
# Variables
# ---------

source /opt/GooPlex/menus/variables.sh
clear

# ------------
# Menu Options
# ------------

# Maintain Server
server(){
	/opt/GooPlex/menus/server.sh
}

# Install Media
media(){
	/opt/GooPlex/menus/appsmedia.sh
}

# Install Media
download(){
	/opt/GooPlex/menus/appsdownload.sh
}

# Install Other
other(){
	/opt/GooPlex/menus/appsother.sh
}

# Additional Options
misc(){
	/opt/GooPlex/menus/misc.sh
}

# Exit
quit(){
	MENUVISIT
	exit
}

# ------------
# Display menu
# ------------

show_menus() {
	clear
	echo -e " ${GREEN}"
	MENUSTART
	echo -e " ${GREEN}A${STD} - Maintain Server"
	echo -e " ${GREEN}B${STD} - Media Applications"
	echo -e " ${GREEN}C${STD} - Download Applications"
	echo -e " ${GREEN}D${STD} - Other Applications"
	echo -e " ${GREEN}E${STD} - Additional Tasks"
	echo -e " ${LRED}Q${STD} - QUIT $FUNCTION"
	echo -e "${GREEN}"
	MENUEND
}

# ------------
# Read Choices
# ------------

read_options(){
	local choice
	read -n 1 -s -r -p "Choose option: " choice
	case $choice in
		[Aa]) server ;;
		[Bb]) media ;;
		[Cc]) download ;;
		[Dd]) other ;;
		[Ee]) misc ;;
		[Qq]) quit ;;
		*) echo -e "${LRED}Please select a valid option${STD}" && sleep 2
	esac
}

# ----------
# Finalizing
# ----------

MENUFINALIZE
