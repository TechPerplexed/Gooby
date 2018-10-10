#!/bin/bash

MENU="Additional Tasks"

# ---------
# Variables
# ---------

source /opt/GooPlex/menus/variables.sh
clear

# ------------
# Menu Options
# ------------

# Update GooPlex
SERVER(){
	PERFORM="update"
	TASK="GooPlex"
	source /opt/GooPlex/install/misc/update.sh
}

# Plex Backup
PBACKUP(){
	PERFORM="backup"
	TASK="Plex and Tautulli to Google"
	source /opt/GooPlex/install/misc/plex-backup.sh
}


# Plex Restore
PRESTORE(){
	PERFORM="restore"
	TASK="Plex and Tautulli database"
	source /opt/GooPlex/install/misc/plex-restore.sh
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
	echo -e " ${CYAN}"
	MENUSTART
	echo -e " ${CYAN}A${STD} - Update GooPlex"
	echo -e " ${CYAN}B${STD} - Backup Plex and Tautulli"
	echo -e " ${CYAN}C${STD} - Restore Plex and Tautulli"
	echo -e " ${WHITE}Z${STD} - EXIT to Main Menu"
	echo -e " ${CYAN}"
	MENUEND
}

# ------------
# Read Choices
# ------------

read_options(){
	local choice
	read -n 1 -s -r -p "Choose option: " choice
	case $choice in
		[Aa]) SERVER ;;
		[Bb]) PBACKUP ;;
		[Cc]) PRESTORE ;;
		[Zz]) QUIT ;;
		*) echo -e "${LRED}Please select a valid option${STD}" && sleep 2
	esac
}
 
# ----------
# Finalizing
# ----------

MENUFINALIZE
