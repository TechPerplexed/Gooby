#!/bin/bash

if [ ! -e $CONFIGS/Docker/.env ]; then /opt/Gooby/install/server/server-init.sh; fi

source $CONFIGS/Docker/.env

# Menu Options

INSTALL(){
	PERFORM="install"
	source /opt/Gooby/install/apps/${PERFORM}-$APPTYPE.sh
}

UPDATE(){
	PERFORM="update"
	source /opt/Gooby/install/apps/${PERFORM}-$APPTYPE.sh
}

REMOVE(){
	PERFORM="remove"
	source /opt/Gooby/install/apps/${PERFORM}-$APPTYPE.sh
}

QUIT(){
	exit
}

# Display menu

show_menus() {
	clear
	echo " ${LPURPLE}"
	MENUSTART
	echo " ${LPURPLE}I${STD} - Install ${TASK}"
	echo " ${LPURPLE}U${STD} - Update ${TASK}"
	echo " ${LPURPLE}R${STD} - Remove ${TASK}"
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
		*) echo "${LRED}Please select a valid option${STD}" && sleep 2
	esac
}

MENUFINALIZE
