#!/bin/bash

MENU="GooPlex Menu"
source /opt/GooPlex/menus/variables.sh

# Menu Options

server(){
	/opt/GooPlex/menus/server.sh
}

media(){
	/opt/GooPlex/menus/appsmedia.sh
}

download(){
	/opt/GooPlex/menus/appsdownload.sh
}

other(){
	/opt/GooPlex/menus/appsother.sh
}

misc(){
	/opt/GooPlex/menus/misc.sh
}

quit(){
	MENUVISIT
	exit
}

# Display menu

show_menus() {
	clear
	echo " ${GREEN}"
	MENUSTART
	echo " ${GREEN}A${STD} - Maintain Server"
	echo " ${GREEN}B${STD} - Media Applications"
	echo " ${GREEN}C${STD} - Download Applications"
	echo " ${GREEN}D${STD} - Other Applications"
	echo " ${GREEN}E${STD} - Additional Tasks"
	echo " ${LRED}Q${STD} - QUIT $FUNCTION"
	echo " ${GREEN}"
	MENUEND
}

# Read Choices

read_options(){
	local choice
	read -n 1 -s -r -p "Choose option: " choice
	case $choice in
		[Aa]) server ;;
		[Bb]) media ;;
		[Cc]) download ;;
		[Dd]) other ;;
		[Ee]) misc ;;
		[Qq]) quit ;;
		*) echo "${LRED}Please select a valid option${STD}" && sleep 2
	esac
}

MENUFINALIZE
