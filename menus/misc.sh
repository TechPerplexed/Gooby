#!/bin/bash

MENU="Additional Tasks"
source /opt/Gooby/menus/variables.sh

# Menu Options

BACKUP(){
	PERFORM="create"
	TASK="backup"
	source /opt/Gooby/install/misc/${TASK}-${PERFORM}.sh
}

RESTORE(){
	PERFORM="restore"
	TASK="backup"
	source /opt/Gooby/install/misc/${TASK}-${PERFORM}.sh
}

RCLEAN(){
	PERFORM="cleanup"
	TASK="system"
	source /opt/Gooby/install/misc/${TASK}-${PERFORM}.sh
}

GOOBY(){
	PERFORM="update"
	TASK="Gooby"
	source /opt/Gooby/install/misc/${TASK}-${PERFORM}.sh
}

QUIT(){
	exit
}

# Display menu

show_menus() {
	clear
	echo " ${CYAN}"
	MENUSTART
	echo " ${CYAN}A${STD} - Create Backup"
	echo " ${CYAN}B${STD} - Restore Backup"
	echo " ${CYAN}C${STD} - System Cleanup"
	echo " ${CYAN}D${STD} - Update Gooby"	
	echo " ${WHITE}Z${STD} - EXIT to Main Menu"
	echo " ${CYAN}"
	MENUEND
}

# Read Choices

read_options(){
	local choice
	read -n 1 -s -r -p "Choose option: " choice
	case $choice in
		[Aa]) BACKUP ;;
		[Bb]) RESTORE ;;
		[Cc]) RCLEAN ;;
		[Dd]) GOOBY ;;
		[Zz]) QUIT ;;
		*) echo "${LRED}Please select a valid option${STD}" && sleep 2
	esac
}

MENUFINALIZE
