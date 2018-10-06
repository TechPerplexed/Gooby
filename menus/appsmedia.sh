#!/bin/bash

FUNCTION="Manage Applications"

# ---------
# Variables
# ---------

source /opt/GooPlex/menus/variables.sh
clear

# ------------
# Menu Options
# ------------

# Rclone
RCLONE(){
  FUNCTION="Rclone"
  source /opt/GooPlex/menus/apps.sh
}

# Plex
PLEX(){
  FUNCTION="Plex"
  source /opt/GooPlex/menus/apps.sh
}

# Tautulli
TAUTULLI(){
  FUNCTION="Tautulli"
  source /opt/GooPlex/menus/apps.sh
}

# Emby
EMBY(){
  FUNCTION="Emby"
  source /opt/GooPlex/menus/apps.sh
}

# Exit
QUIT(){
  exit
}

# ------------
# Display menu
# ------------

show_menus() {
  clear
  echo -e " ${LPURPLE}"
  echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo -e " G O O P L E X - Visit techperplexed.ga "
  echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo -e " $FUNCTION "
  echo -e " ${STD}"
  echo -e " ${LPURPLE}A${STD} - Rclone"
  echo -e " ${LPURPLE}B${STD} - Plex"
  echo -e " ${LPURPLE}C${STD} - Tautulli"
  echo -e " ${LPURPLE}D${STD} - Emby"
  echo -e " ${WHITE}Z${STD} - EXIT to Main Menu"
  echo -e " ${LPURPLE}"
  echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo -e " ${STD}"
}

# ------------
# Read Choices
# ------------

read_options(){
  local choice
    read -p "Choose option: " choice
    case $choice in
      [Aa]) RCLONE ;;
      [Bb]) PLEX ;;
      [Cc]) TAUTULLI ;;
      [Dd]) EMBY ;;      
      [Zz]) QUIT ;;
      *) echo -e "${LRED}Please select a valid option${STD}" && sleep 2
    esac
}
 
# ----------
# Finalizing
# ----------

trap '' SIGINT SIGQUIT SIGTSTP

while true
do 
  show_menus
  read_options
done
