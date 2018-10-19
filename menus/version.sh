#!/bin/bash

MENU="GooPlex Version"
source /opt/GooPlex/menus/variables.sh

# Menu Options

MASTER(){
	UVERSION=Master
	/opt/GooPlex/install/misc/GooPlex-update.sh
}

LEGACY(){
	UVERSION=Legacy
	/opt/GooPlex/install/misc/GooPlex-update.sh
}

DEVELOPER(){
	UVERSION-Developer
	/opt/GooPlex/install/misc/GooPlex-update.sh
}

QUIT(){
	MENUVISIT
	exit
}

# Display menu

show_menus() {
	clear
	echo " ${GREEN}"
	
	echo "--------------------------------------------------"
	echo " W E L C O M E   T O  T H E  N E W  G O O P L E X"
	echo " Please select which version you want to use"
	echo "--------------------------------------------------"
	echo " $MENU"
	echo " ${STD}"
	
	echo " ${GREEN}A${STD} - NEW version (you will need a domain)"
	echo " ${GREEN}B${STD} - Legacy (if you used GooPlex before)"
	echo " ${GREEN}C${STD} - Developer (bleeding edge suffering)"
	echo " ${LRED}Q${STD} - QUIT $FUNCTION"
	echo " ${GREEN}"
	MENUEND
}

# Read Choices

read_options(){
	local choice
	read -n 1 -s -r -p "Choose option: " choice
	case $choice in
		[Aa]) MASTER ;;
		[Bb]) LEGACY ;;
		[Cc]) DEVELOPER ;;
		[Qq]) QUIT ;;
		*) echo "${LRED}Please select a valid option${STD}" && sleep 2
	esac
}

MENUFINALIZE
