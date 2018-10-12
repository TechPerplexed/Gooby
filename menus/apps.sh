#!/bin/bash

# Menu Options

INSTALL(){
	PERFORM="install"
	source /opt/GooPlex/install/apps/${TASK}-${PERFORM}.sh
}

UPDATE(){
	PERFORM="update"
	source /opt/GooPlex/install/apps/${TASK}-${PERFORM}.sh
}

REMOVE(){
	PERFORM="remove"
	source /opt/GooPlex/install/apps/${TASK}-${PERFORM}.sh
}

QUIT(){
	exit
}

# Display menu

show_menus() {
	clear
	echo " ${LPURPLE}"
	MENUSTART
	echo " ${LPURPLE}I${STD} - Install $TASK"
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
		[Ii]) INSTALL ;;
		[Uu]) UPDATE ;;
		[Rr]) REMOVE ;;
		[Zz]) QUIT ;;
		*) echo -e "${LRED}Please select a valid option${STD}" && sleep 2
	esac
}

MENUFINALIZE
