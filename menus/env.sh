#!/bin/bash

# Menu Options

CHECK(){
	PERFORM="check"
	source /opt/GooPlex/install/misc/${TASK}-${PERFORM}.sh
}

UPDATE(){
	PERFORM="update"
	source /opt/GooPlex/install/misc/${TASK}-${PERFORM}.sh
}

REMOVE(){
	PERFORM="remove"
	source /opt/GooPlex/install/misc/${TASK}-${PERFORM}.sh
}

QUIT(){
	exit
}

# Display menu

show_menus() {
	clear
	echo " ${LPURPLE}"
	MENUSTART
	echo " ${LPURPLE}I${STD} - Set or Check $TASK"
	echo " ${LPURPLE}U${STD} - Update $TASK"
	echo " ${LPURPLE}R${STD} - Remove $TASK"
	echo " ${WHITE}Z${STD} - EXIT to Main Menu"
	echo " ${LPURPLE}"
	MENUEND
}

# Read Choices

read_options(){
	local choice
	read -n 1 -s -r -p "Choose option: " choice
	case $choice in
		[Ii]) CHECK ;;
		[Uu]) UPDATE ;;
		[Rr]) REMOVE ;;
		[Zz]) QUIT ;;
		*) echo "${LRED}Please select a valid option${STD}" && sleep 2
	esac
}

MENUFINALIZE
