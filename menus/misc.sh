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

COLOUR=${CYAN}

show_menus() {
	MENUSTART
	echo " ${COLOUR}A${STD} - Update Gooby"
	echo " ${COLOUR}B${STD} - Trigger Uploading"
	echo " ${COLOUR}C${STD} - System Cleanup"
	echo " ${COLOUR}D${STD} - Create Backup"
	echo " ${COLOUR}E${STD} - Restore Backup"
	echo " ${WHITE}Z${STD} - EXIT to Main Menu"
	echo " ${COLOUR}"
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
