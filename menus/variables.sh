#!/bin/bash

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

ALREADYINSTALLED(){
  echo -e "${YELLOW}"
  echo -e "--------------------------------------------------"
  echo -e " ${TASK} appears to be installed"
  echo -e "--------------------------------------------------"
  echo -e "${STD}"
}

NOTINSTALLED(){
  echo -e "${YELLOW}"
  echo -e "--------------------------------------------------"
  echo -e " ${TASK} is not installed yet"
  echo -e "--------------------------------------------------"
  echo -e "${STD}"
}

EXPLAINTASK(){
  echo -e "${CYAN}"
  echo -e "--------------------------------------------------"
  echo -e " This will ${PERFORM} ${TASK}"
  echo -e "--------------------------------------------------"
  echo -e "${STD}"
}

CONFIRMATION(){
  echo -e "${YELLOW}"
  echo -e "--------------------------------------------------"
  echo -e " Are you sure you want to ${PERFORM} ${TASK} (y/N)? "
  echo -e "--------------------------------------------------"
  echo -e "${STD}"
  read -p "--->" -n 1 -r
}

GOAHEAD(){
  echo -e "${LMAGENTA}"
  echo -e "--------------------------------------------------"
  echo -e " You chose to ${PERFORM} $TASK}"
  echo -e "--------------------------------------------------"
  echo -e "${STD}"
}

TASKCOMPLETE(){
  echo -e "${LMAGENTA}"
  echo -e "--------------------------------------------------"
  echo -e " ${PERFORM} $TASK completed"
  echo -e "--------------------------------------------------"
  echo -e "${STD}"
}

CANCELTHIS(){
  echo -e "${YELLOW}"
  echo -e "--------------------------------------------------"
  echo -e " You chose not to ${PERFORM} ${TASK}"
  echo -e "--------------------------------------------------"
  echo -e "${STD}"
}

PAUSE(){
  echo -e "${GREEN}"
  echo -e "--------------------------------------------------"
  echo -e " All done! Press Enter to return to the menu... "
  echo -e "--------------------------------------------------"
  echo -e "${STD}"
  read -t 10 -n 1 -s -r -p "-->"
  echo ""
}
