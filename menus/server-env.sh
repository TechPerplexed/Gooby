#!/bin/bash

# Menu Options

SET(){
	PERFORM="install"
	source /opt/GooPlex/install/server/${TASK}-${PERFORM}.sh
}

UPDATE(){
	PERFORM="update"
	source /opt/GooPlex/install/server/${TASK}-${PERFORM}.sh
}

REMOVE(){
	PERFORM="remove"
	source /opt/GooPlex/install/server/${TASK}-${PERFORM}.sh
}

QUIT(){
	exit
}

# Display menu

show_menus() {
	clear
	echo " ${CYAN}"
	MENUSTART
	echo " ${CYAN}S${STD} - Set $TASK"
	echo " ${CYAN}U${STD} - Update $TASK"
	echo " ${CYAN}R${STD} - Remove $TASK"
	echo " ${WHITE}Z${STD} - EXIT to Main Menu"
	echo " ${CYAN}"
	MENUEND
}

# Read Choices

read_options(){
	local choice
	read -n 1 -s -r -p "Choose option: " choice
	case $choice in
		[Ss]) SET ;;
		[Uu]) UPDATE ;;
		[Rr]) REMOVE ;;
		[Zz]) QUIT ;;
		*) echo "${LRED}Please select a valid option${STD}" && sleep 2
	esac
}

MENUFINALIZE
