#!/bin/bash

clear

# ------------
# Menu Options
# ------------

# Install
INSTALL(){
	PERFORM="install"
	source /opt/GooPlex/install/apps/${TASK}-${PERFORM}.sh
}

# Update
UPDATE(){
	PERFORM="update"
	source /opt/GooPlex/install/apps/${TASK}-${PERFORM}.sh
}

# Remove
REMOVE(){
	PERFORM="remove"
	source /opt/GooPlex/install/apps/${TASK}-${PERFORM}.sh
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
	echo -e " ${LPURPLE}"
	MENUSTART
	echo -e " ${LPURPLE}I${STD} - Install $TASK"
	echo -e " ${LPURPLE}U${STD} - Update $TASK"
	echo -e " ${LPURPLE}R${STD} - Remove $TASK"
	echo -e " ${WHITE}Z${STD} - EXIT to Main Menu"
	echo -e " ${LPURPLE}"
	MENUEND
}

# ------------
# Read Choices
# ------------

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

# ----------
# Finalizing
# ----------

MENUFINALIZE
