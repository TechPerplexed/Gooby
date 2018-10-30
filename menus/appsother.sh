#!/bin/bash

MENU="Other Applications"
source /opt/Gooby/menus/variables.sh

# Menu Options

NETDATA(){
	TASK=Netdata
	APP=netdata
	APPTYPE=app
	APPLOC=02-netdata
	OLDLOC=/noupgradepathprovided
	source /opt/Gooby/menus/apps.sh
}

ORGANIZR(){
	TASK=Organizr
	APP=organizr
	APPTYPE=app
	APPLOC=03-organizr
	OLDLOC=/noupgradepathprovided
	source /opt/Gooby/menus/apps.sh
}

OMBI(){
	TASK=Ombi
	APP=ombi
	APPTYPE=app
	APPLOC=60-ombi
	OLDLOC=/opt/Ombi/
	source /opt/Gooby/menus/apps.sh
}

PORTAINER(){
	TASK=Portainer
	APP=portainer
	APPTYPE=app
	APPLOC=60-ombi
	OLDLOC=/noupgradepathprovided
	source /opt/Gooby/menus/apps.sh
}

QUIT(){
	exit
}

# Display menu

show_menus() {
	clear
	echo " ${LPURPLE}"
	MENUSTART
	echo " ${LPURPLE}A${STD} - Netdata"
	echo " ${LPURPLE}B${STD} - Organizr"
	echo " ${LPURPLE}C${STD} - Ombi"
	echo " ${LPURPLE}D${STD} - Portainer"
	echo " ${WHITE}Z${STD} - EXIT to Main Menu"
	echo " ${LPURPLE}"
	MENUEND
}

# Read Choices

read_options(){
	local choice
	read -n 1 -s -r -p "Choose option: " choice
    case $choice in
		[Aa]) NETDATA ;;
		[Bb]) ORGANIZR ;;
		[Cc]) OMBI ;;
		[Dd]) PORTAINER ;;
		[Zz]) QUIT ;;
		*) echo "${LRED}Please select a valid option${STD}" && sleep 2
	esac
}
 
MENUFINALIZE
