#!/bin/bash

MENU="Media Applications"
source /opt/Gooby/menus/variables.sh

# Menu Options

RCLONE(){
	TASK=Rclone
	APP=rclone
	APPTYPE=rclone
	source /opt/Gooby/menus/apps.sh
}

PLEX(){
	TASK=Plex
	APP=plex
	APPTYPE=app
	APPLOC=21-plex
	OLDLOC=/var/lib/plexmediaserver/
	source /opt/Gooby/menus/apps.sh
}

TAUTULLI(){
	TASK=Tautulli
	APP=tautulli
	APPTYPE=app
	APPLOC=25-tautulli
	OLDLOC=/opt/Tautulli/
	source /opt/Gooby/menus/apps.sh
}

EMBY(){
	TASK=Emby
	APP=emby
	APPTYPE=app
	APPLOC=22-emby
	OLDLOC=/var/lib/emby/
	source /opt/Gooby/menus/apps.sh
}

JELLYFIN(){
	TASK=Jellyfin
	APP=jellyfin
	APPTYPE=app
	APPLOC=23-jellyfin
	OLDLOC=/var/lib/jellyfin/
	source /opt/Gooby/menus/apps.sh
}

QUIT(){
	exit
}

# Display menu

COLOUR=${LPURPLE}

show_menus() {
	MENUSTART
	echo " ${COLOUR}A${STD} - Rclone"
	echo " ${COLOUR}B${STD} - Plex"
	echo " ${COLOUR}C${STD} - Tautulli"
	echo " ${COLOUR}D${STD} - Emby"
	echo " ${COLOUR}E${STD} - Jellyfin"
	echo " ${WHITE}Z${STD} - EXIT to Main Menu"
	echo " ${COLOUR}"
	MENUEND
}

# Read Choices

read_options(){
	local CHOICE
	read -n 1 -s -r -p "Choose option: " CHOICE
	case ${CHOICE} in
		[Aa]) RCLONE ;;
		[Bb]) PLEX ;;
		[Cc]) TAUTULLI ;;
		[Dd]) EMBY ;;
		[Ee]) JELLYFIN ;;
		[Zz]) QUIT ;;
		*) echo "${LRED}Please select a valid option${STD}" && sleep 1
	esac
}

MENUFINALIZE
