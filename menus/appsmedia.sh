#!/bin/bash

MENU="Media Applications"

# ---------
# Variables
# ---------

source /opt/GooPlex/menus/variables.sh
clear

# ------------
# Menu Options
# ------------

# Rclone
RCLONE(){
	TASK="Rclone"
	source /opt/GooPlex/menus/apps.sh
}

# Plex
PLEX(){
	TASK="Plex"
	source /opt/GooPlex/menus/apps.sh
}

# Tautulli
TAUTULLI(){
	TASK="Tautulli"
	source /opt/GooPlex/menus/apps.sh
}

# Emby
EMBY(){
	TASK="Emby"
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
	echo -e " ${LPURPLE}A${STD} - Rclone"
	echo -e " ${LPURPLE}B${STD} - Plex"
	echo -e " ${LPURPLE}C${STD} - Tautulli"
	echo -e " ${LPURPLE}D${STD} - Emby"
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
		[Aa]) RCLONE ;;
		[Bb]) PLEX ;;
		[Cc]) TAUTULLI ;;
		[Dd]) EMBY ;;      
		[Zz]) QUIT ;;
		*) echo -e "${LRED}Please select a valid option${STD}" && sleep 2
	esac
}
 
# ----------
# Finalizing
# ----------

MENUFINALIZE
