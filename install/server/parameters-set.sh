#!/bin/bash

MENU="Set and review parameters"
source /opt/GooPlex/menus/variables.sh

# Menu Options

IP(){
	PERFORM="update"
	TASK="GooPlex"
	source /opt/GooPlex/install/misc/${TASK}-${PERFORM}.sh
}

WWW(){
	PERFORM="review"
	TASK="Parameters"
	source /opt/GooPlex/install/misc/${TASK}-${PERFORM}.sh
}

MAIL(){
	PERFORM="backup"
	TASK="GooPlex"
	source /opt/GooPlex/install/misc/${TASK}-${PERFORM}.sh
}

TZONE(){
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
	echo " ${CYAN}"
	MENUSTART
	echo " ${CYAN}A${STD} - ${CYAN}$USER${STD}"
	echo " ${CYAN}E${STD} - Update or review server IP address"
	echo " ${CYAN}C${STD} - Update or review URL"
	echo " ${CYAN}D${STD} - Update or review email address"
	echo " ${CYAN}B${STD} - Update or review timezone settings"
	echo " ${WHITE}Z${STD} - EXIT to Main Menu"
	echo " ${CYAN}"
	MENUEND
}

# Read Choices

read_options(){
	local choice
	read -n 1 -s -r -p "Choose option: " choice
	case $choice in
		[Aa]) IP ;;
		[Bb]) WWW ;;
		[Cc]) MAIL ;;
		[Dd]) TZONE ;;
		[Zz]) QUIT ;;
		*) echo "${LRED}Please select a valid option${STD}" && sleep 2
	esac
}

MENUFINALIZE
