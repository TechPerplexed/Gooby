#!/bin/bash

MENU="Additional Tasks"
source /opt/GooPlex/menus/variables.sh

# Menu Options

GOOPLEX(){
	PERFORM="update"
	TASK="GooPlex"
	source /opt/GooPlex/install/misc/${TASK}-${PERFORM}.sh
}

USERSETTINGS(){
	PERFORM="review"
	TASK="Parameters"
	source /opt/GooPlex/install/misc/${TASK}-${PERFORM}.sh
}

PBACKUP(){
	PERFORM="backup"
	TASK="GooPlex"
	source /opt/GooPlex/install/misc/${TASK}-${PERFORM}.sh
}

PRESTORE(){
	PERFORM="restore"
	TASK="GooPlex"
	source /opt/GooPlex/install/misc/${TASK}-${PERFORM}.sh
}

QUIT(){
	exit
}

# Display menu

show_menus() {
	clear
	echo -e " ${CYAN}"
	MENUSTART
	echo -e " ${CYAN}A${STD} - Update GooPlex"
	echo -e " ${CYAN}B${STD} - Review user parameters"
	echo -e " ${CYAN}C${STD} - Backup Plex and Tautulli"
	echo -e " ${CYAN}D${STD} - Restore Plex and Tautulli"
	echo -e " ${WHITE}Z${STD} - EXIT to Main Menu"
	echo -e " ${CYAN}"
	MENUEND
}

# Read Choices

read_options(){
	local choice
	read -n 1 -s -r -p "Choose option: " choice
	case $choice in
		[Aa]) GOOPLEX ;;
		[Bb]) USERSETTINGS ;;
		[Cc]) PBACKUP ;;
		[Dd]) PRESTORE ;;
		[Zz]) QUIT ;;
		*) echo -e "${LRED}Please select a valid option${STD}" && sleep 2
	esac
}

MENUFINALIZE
