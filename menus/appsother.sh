#!/bin/bash

MENU="Other Applications"
source /opt/Gooby/menus/variables.sh

# Menu Options

NETDATA(){
	TASK=Netdata
	APP=netdata
	APPTYPE=app
	APPLOC=62-netdata
	OLDLOC=/noupgradepathprovided
	source /opt/Gooby/menus/apps.sh
}

ORGANIZR(){
	TASK=Organizr
	APP=organizr
	APPTYPE=app
	APPLOC=11-organizr
	OLDLOC=/noupgradepathprovided
	source /opt/Gooby/menus/apps.sh
}

OMBI(){
	TASK=Ombi
	APP=ombi
	APPTYPE=app
	APPLOC=12-ombi
	OLDLOC=/opt/Ombi/
	source /opt/Gooby/menus/apps.sh
}

PORTAINER(){
	TASK=Portainer
	APP=portainer
	APPTYPE=app
	APPLOC=14-portainer
	OLDLOC=/noupgradepathprovided
	source /opt/Gooby/menus/apps.sh
}

APACHE(){
	TASK=Apache
	APP=apache
	APPTYPE=app
	APPLOC=81-phpapache
	OLDLOC=/noupgradepathprovided
	source /opt/Gooby/menus/apps.sh
}

QUIT(){
	exit
}

# Display menu

COLOUR=${LPURPLE}

show_menus() {
	MENUSTART
	echo " ${COLOUR}A${STD} - Netdata"
	echo " ${COLOUR}B${STD} - Organizr"
	echo " ${COLOUR}C${STD} - Ombi"
	echo " ${COLOUR}D${STD} - Portainer"
	echo " ${COLOUR}E${STD} - PHP Apache"
	echo " ${WHITE}Z${STD} - EXIT to Main Menu"
	echo " ${COLOUR}"
	MENUEND
}

# Read Choices

read_options(){
	local CHOICE
	read -n 1 -s -r -p "Choose option: " CHOICE
    case ${CHOICE} in
		[Aa]) NETDATA ;;
		[Bb]) ORGANIZR ;;
		[Cc]) OMBI ;;
		[Dd]) PORTAINER ;;
		[Ee]) APACHE ;;
		[Zz]) QUIT ;;
		*) echo "${LRED}Please select a valid option${STD}" && sleep 1
	esac
}
 
MENUFINALIZE
