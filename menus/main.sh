#!/bin/bash

MENU="Main Menu"
source /opt/Gooby/menus/variables.sh

# Menu Options

server(){
	/opt/Gooby/menus/server.sh
}

media(){
	/opt/Gooby/menus/appsmedia.sh
}

download(){
	/opt/Gooby/menus/appsdownload.sh
}

other(){
	/opt/Gooby/menus/appsother.sh
}

misc(){
	/opt/Gooby/menus/misc.sh
}

stats(){
	/opt/Gooby/menus/stats.sh
}

quit(){
	MENUVISIT
	exit
}

# Display menu

COLOUR=${GREEN}

show_menus() {
	clear
	MENUSTART
	echo " ${GREEN}A${STD} - Maintain Server"
	echo " ${GREEN}B${STD} - Media Applications"
	echo " ${GREEN}C${STD} - Download Applications"
	echo " ${GREEN}D${STD} - Other Applications"
	echo " ${GREEN}E${STD} - Additional Tasks"
	echo " ${GREEN}F${STD} - Various Statistics"
	echo " ${LRED}Q${STD} - QUIT ${FUNCTION}"
	echo " ${GREEN}"
	MENUEND
}

# Read Choices

read_options(){
	local CHOICE
	read -n 1 -s -r -p "Choose option: " CHOICE
	case ${CHOICE} in
		[Aa]) server ;;
		[Bb]) media ;;
		[Cc]) download ;;
		[Dd]) other ;;
		[Ee]) misc ;;
		[Ff]) stats ;;
		[Qq]) quit ;;
		*) echo "${LRED}Please select a valid option${STD}" && sleep 1
	esac
}

MENUFINALIZE
