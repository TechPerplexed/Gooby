#!/bin/bash

MENU="Additional Tasks"
source /opt/GooPlex/menus/variables.sh

# Menu Options

GOOPLEX(){
	PERFORM="update"
	TASK="GooPlex"
	source /opt/GooPlex/install/misc/${TASK}-${PERFORM}.sh
}

CHECKENV(){
	PERFORM="check"
	TASK="environment"
	source /opt/GooPlex/install/misc/${TASK}-${PERFORM}.sh
}

BACKUP(){
	PERFORM="create"
	TASK="backup"
	source /opt/GooPlex/install/misc/${TASK}-${PERFORM}.sh
}

RESTORE(){
	PERFORM="restore"
	TASK="backup"
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
	echo " ${CYAN}A${STD} - Update GooPlex"
	echo " ${CYAN}B${STD} - Check Environment"
	echo " ${CYAN}C${STD} - Create Backup"
	echo " ${CYAN}D${STD} - Restore Backup"
	echo " ${WHITE}Z${STD} - EXIT to Main Menu"
	echo " ${CYAN}"
	MENUEND
}

# Read Choices

read_options(){
	local choice
	read -n 1 -s -r -p "Choose option: " choice
	case $choice in
		[Aa]) GOOPLEX ;;
		[Bb]) CHECKENV ;;
		[Cc]) BACKUP ;;
		[Dd]) RESTORE ;;
		[Zz]) QUIT ;;
		*) echo "${LRED}Please select a valid option${STD}" && sleep 2
	esac
}

MENUFINALIZE
