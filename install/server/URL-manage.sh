#!/bin/bash

clear

EXPLAINTASK

CONFIRMATION

if [[ ${REPLY} =~ ^[Yy]$ ]]; then

	GOAHEAD

# Menu Options

INSTALL(){
	echo "coming soon"
}

UPDATE(){
	echo "coming soon"
}

REMOVE(){
	echo "coming soon"
}

QUIT(){
	exit
}

# Display menu

show_menus() {
	clear
	echo " ${CYAN}"
	MENUSTART
	[[ -s $CONFIGS/.config/seturl ]] && echo "Your URL is currently set to $URL" || echo "You have not set an URL yet"
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
		[Ii]) INSTALL ;;
		[Uu]) UPDATE ;;
		[Rr]) REMOVE ;;
		[Zz]) QUIT ;;
		*) echo "${LRED}Please select a valid option${STD}" && sleep 2
	esac
}

MENUFINALIZE

else

	CANCELTHIS

fi

PAUSE
