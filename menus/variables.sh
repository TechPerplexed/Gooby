#!/bin/bash

VERSION="2-alpha"
CONFIGS=/var/local/GooPlex
COMMAND=${1,,}
CURDIR=$(pwd)

# Define colors

STD=$(echo -en '\033[0m')
RED=$(echo -en '\033[00;31m')
GREEN=$(echo -en '\033[00;32m')
YELLOW=$(echo -en '\033[00;33m')
BLUE=$(echo -en '\033[00;34m')
MAGENTA=$(echo -en '\033[00;35m')
PURPLE=$(echo -en '\033[00;35m')
CYAN=$(echo -en '\033[00;36m')
LIGHTGRAY=$(echo -en '\033[00;37m')
LRED=$(echo -en '\033[01;31m')
LGREEN=$(echo -en '\033[01;32m')
LYELLOW=$(echo -en '\033[01;33m')
LBLUE=$(echo -en '\033[01;34m')
LMAGENTA=$(echo -en '\033[01;35m')
LPURPLE=$(echo -en '\033[01;35m')
LCYAN=$(echo -en '\033[01;36m')
WHITE=$(echo -en '\033[01;37m')

# Define choices

RUNPATCHES(){
	sudo apt-get update
	sudo apt-get upgrade -y
	# sudo apt-get dist-upgrade -y
	# sudo apt autoremove -y
	# sudo apt autoclean
	# sudo apt-get autoremove
}

MENUSTART(){
	echo "--------------------------------------------------"
	echo " G O O P L E X - Visit techperplexed.ga"
	echo "--------------------------------------------------"
	echo " $MENU"
	echo " ${STD}"
}

MENUEND(){
	echo "--------------------------------------------------"
	echo " ${STD}"
}

MENUFINALIZE(){
	trap '' SIGINT SIGQUIT SIGTSTP
	while true
	do
	show_menus
	read_options
	done
}

MENUVISIT(){
	clear
	echo ""
	echo "--------------------------------------------------"
	echo " Visit the menu any time by typing '${WHITE}gooplex${STD}'"
	echo "--------------------------------------------------"
	echo ""
}

ALREADYINSTALLED(){
	echo "${YELLOW}"
	echo "--------------------------------------------------"
	echo " ${TASK} appears to be installed"
	echo "--------------------------------------------------"
	echo "${STD}"
}

NOTINSTALLED(){
	echo "${YELLOW}"
	echo "--------------------------------------------------"
	echo " ${TASK} is not installed yet"
	echo "--------------------------------------------------"
	echo "${STD}"
}

APPINSTALLED(){
	echo "${YELLOW}"
	echo "--------------------------------------------------"
	echo " ${TASK} is now installed"
	echo " You can reach it through this URL:"
	echo " $PUBLICIP:$PORT"
	# echo " This will soon be $URL/$APP"
	echo "--------------------------------------------------"
	echo "${STD}"
}

NOAPPUPDATE(){
	echo "${LRED}"
	echo "--------------------------------------------------"
	echo " ${TASK} cannot be updated through this menu"
	echo " You can update it from the web interface itself"
	echo "--------------------------------------------------"
	echo "${STD}"
}

EXPLAINTASK(){
	clear
	echo "${CYAN}"
	echo "--------------------------------------------------"
	echo " This will ${PERFORM} ${TASK}"
	echo "--------------------------------------------------"
	echo "${STD}"
}

EXPLAINAPP(){
	clear
	echo "${CYAN}"
	echo "--------------------------------------------------"
	echo " This will ${PERFORM} ${TASK}"
	echo " This will cause a few seconds of downtime"
	echo "--------------------------------------------------"
	echo "${STD}"
}

CONFIRMATION(){
	echo "${YELLOW}"
	echo "--------------------------------------------------"
	echo " Are you sure you want to ${PERFORM} ${TASK} (y/N)? "
	echo "--------------------------------------------------"
	echo "${STD}"
	read -t 60 -n 1 -s -r -p " ---> "
	echo ""
}

CONFIRMDELETE(){
	echo "${LRED}"
	echo "--------------------------------------------------"
	echo " DANGER ZONE - EXTREME CAUTION!!!"
	echo " Are you really really sure?"
	echo " You are about to ${PERFORM} ${TASK}"
	echo " Including user settings and databases"
	echo " Make sure you have a backup first!"
	echo " Proceed? (y/N)?"
	echo "--------------------------------------------------"
	echo "${STD}"
	read -t 60 -n 1 -s -r -p " ---> "
	echo ""
}

GOAHEAD(){
	echo "${LMAGENTA}"
	echo "--------------------------------------------------"
	echo " Starting ${PERFORM} ${TASK}"
	echo "--------------------------------------------------"
	echo "${STD}"
}

TASKCOMPLETE(){
	echo "${LMAGENTA}"
	echo "--------------------------------------------------"
	echo " ${PERFORM} ${TASK} completed"
	echo "--------------------------------------------------"
	echo "${STD}"
}

CANCELTHIS(){
	echo "${YELLOW}"
	echo "--------------------------------------------------"
	echo " Cancelling ${PERFORM} ${TASK}"
	echo "--------------------------------------------------"
	echo "${STD}"
}

PAUSE(){
	echo "${GREEN}"
	echo "--------------------------------------------------"
	echo " All done! Press Enter to return to the menu"
	echo "--------------------------------------------------"
	echo "${STD}"
	read -t 60 -n 1 -s -r -p " ---> "
	echo ""
}
