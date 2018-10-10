#!/bin/bash

MENU="Download Applications"

# ---------
# Variables
# ---------

source /opt/GooPlex/menus/variables.sh
clear

# ------------
# Menu Options
# ------------

# Sonarr
SONARR(){
	TASK="Sonarr"
	source /opt/GooPlex/menus/apps.sh
}

# Radarr
RADARR(){
	TASK="Radarr"
	source /opt/GooPlex/menus/apps.sh
}

# Deluge
DELUGE(){
	TASK="Deluge"
	source /opt/GooPlex/menus/apps.sh
}

# NZBGet
NZBGET(){
	TASK="NZBGet"
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
	echo -e " ${LPURPLE}A${STD} - Sonarr"
	echo -e " ${LPURPLE}B${STD} - Radarr"
	echo -e " ${LPURPLE}C${STD} - Deluge"
	echo -e " ${LPURPLE}D${STD} - NZBGet"
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
		[Aa]) SONARR ;;
		[Bb]) RADARR ;;
		[Cc]) DELUGE ;;
		[Dd]) NZBGET ;;
		[Gg]) ORGANIZR ;;
		[Zz]) QUIT ;;
		*) echo -e "${LRED}Please select a valid option${STD}" && sleep 2
	esac
}

# ----------
# Finalizing
# ----------

MENUFINALIZE
