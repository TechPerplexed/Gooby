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

PAUSE(){
  echo ""
  read -t 10 -n 1 -s -r -p "All done! Press Enter to return to the menu..."
  echo ""
}

ALREADYINSTALLED(){
  echo ""
  echo -e "--------------------------------------------------"
  echo -e " ${TASK} appears to be installed already"
  echo -e " Returning to menu..."
  echo -e "--------------------------------------------------"
  echo ""
}

EXPLAINTASK(){
  echo -e "--------------------------------------------------"
  echo -e " This will ${PERFORM} $TASK}"
  echo -e "--------------------------------------------------"
  echo ""
}

CONFIRMATION(){
  read -p "Are you sure you want to ${PERFORM} ${TASK} (y/N)? " -n 1 -r
  echo ""
}

GOAHEAD(){
  echo -e "You chose to ${PERFORM} ${TASK}"
}

CANCELTHIS(){
  echo -e "You chose ${YELLOW}not${STD} to ${PERFORM} ${TASK}"
}
