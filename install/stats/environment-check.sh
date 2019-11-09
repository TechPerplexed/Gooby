#!/bin/bash

MENU="Check Environment"

source ${CONFIGS}/Docker/.env

clear
echo "Fetching your settings..."

# Menu Options

QUIT(){
	exit
}

# Display menu

COLOUR=${LBLUE}

show_menus() {
	MENUSTART
	echo -n " OS Version        : ${COLOUR}" ; lsb_release -ds 2>/dev/null || cat /etc/*release 2>/dev/null | head -n1 || uname -om ; echo -n "${STD}" ; echo -n "${STD}"
	echo " Server Name       : ${COLOUR}${SERVER}${STD}"
	echo " Timezone          : ${COLOUR}${TIMEZONE}${STD}"
	echo " Domain            : ${COLOUR}${MYDOMAIN}${STD}"
	echo " Email Address     : ${COLOUR}${MYEMAIL}${STD}"
	echo " IP Address        : ${COLOUR}${IP}${STD}"
	echo " Proxy Version     : ${COLOUR}${PROXYVERSION^^}${STD}"
	echo " Gooby Version     : ${COLOUR}${VERSION}${STD}"
	echo
	echo " Media Location    : ${COLOUR}/Media${STD}"
	echo " Download Location : ${COLOUR}/Media/Downloads${STD}"
	echo
	echo " ${WHITE}Z${STD} - EXIT to Main Menu"
	echo " ${COLOUR}"
	MENUEND
}

# Read Choices

read_options(){
	local CHOICE
	read -n 1 -s -r -p "Choose option: " CHOICE
	case ${CHOICE} in
		[Zz]) QUIT ;;
		*) echo "${LRED}Please select a valid option${STD}" && sleep 1
	esac
}

MENUFINALIZE
