#!/bin/bash

MENU="Additional Tasks"
source /opt/Gooby/menus/variables.sh

# Menu Options

GOOBY(){
	PERFORM="update"
	TASK="Gooby"
	source /opt/Gooby/install/misc/${TASK}-${PERFORM}.sh
}

UPLOAD(){
	PERFORM="trigger"
	TASK="upload"
	source /opt/Gooby/install/misc/${TASK}-${PERFORM}.sh
}

RCLEAN(){
	PERFORM="cleanup"
	TASK="system"
	source /opt/Gooby/install/misc/${TASK}-${PERFORM}.sh
}

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

QUIT(){
	exit
}

# Display menu

show_menus() {
	clear
	echo " ${CYAN}"
	MENUSTART
	echo " ${CYAN}A${STD} - Update Gooby"
	echo " ${CYAN}B${STD} - Trigger Uploading"
	echo " ${CYAN}C${STD} - System Cleanup"
	echo " ${CYAN}D${STD} - Create Backup"
	echo " ${CYAN}E${STD} - Restore Backup"
	echo " ${WHITE}Z${STD} - EXIT to Main Menu"
	echo " ${CYAN}"
	MENUEND
}

# Read Choices

read_options(){
	local CHOICE
	read -n 1 -s -r -p "Choose option: " CHOICE
	case ${CHOICE} in
		[Aa]) GOOBY ;;
		[Bb]) UPLOAD ;;
		[Cc]) RCLEAN ;;
		[Dd]) BACKUP ;;
		[Ee]) RESTORE ;;
		[Zz]) QUIT ;;
		*) echo "${LRED}Please select a valid option${STD}" && sleep 1
	esac
}

MENUFINALIZE
