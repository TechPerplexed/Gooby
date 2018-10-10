#!/bin/bash

FUNCTION="Other Applications"

# ---------
# Variables
# ---------

source /opt/GooPlex/menus/variables.sh
clear

# ------------
# Menu Options
# ------------

# Netdata
NETDATA(){
	TASK="Netdata"
	source /opt/GooPlex/menus/apps.sh
}

# Organizr
ORGANIZR(){
	TASK="Organizr"
	source /opt/GooPlex/menus/apps.sh
}

# Ombi
OMBI(){
	TASK="Ombi"
	source /opt/GooPlex/menus/apps.sh
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
	echo -e " ${LPURPLE}"
	MENUSTART
	echo -e " ${LPURPLE}A${STD} - Netdata"
	echo -e " ${LPURPLE}B${STD} - Organizr"
	echo -e " ${LPURPLE}C${STD} - Ombi"
	echo -e " ${WHITE}Z${STD} - EXIT to Main Menu"
	echo -e " ${LPURPLE}"
	MENUEND
}

# ------------
# Read Choices
# ------------

read_options(){
	local choice
	read -n 1 -s -r -p "Choose option: " choice
    case $choice in
		[Aa]) NETDATA ;;
		[Bb]) ORGANIZR ;;
		[Cc]) OMBI ;;
		[Zz]) QUIT ;;
		*) echo -e "${LRED}Please select a valid option${STD}" && sleep 2
	esac
}
 
# ----------
# Finalizing
# ----------

MENUFINALIZE
