#!/bin/bash

FUNCTION="Install/Update Applications"

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
  /opt/GooPlex/install/apps/rclone.sh
}

# Plex
PLEX(){
  /opt/GooPlex/install/apps/plex.sh
}

# Tautulli
TAUTULLI(){
  /opt/GooPlex/install/apps/tautulli.sh
}

# Sonarr
SONARR(){
  /opt/GooPlex/install/apps/sonarr.sh
}

# Radarr
RADARR(){
  /opt/GooPlex/install/apps/radarr.sh
}

# Deluge
DELUGE(){
  /opt/GooPlex/install/apps/deluge.sh
}

# Netdata
NETDATA(){
  /opt/GooPlex/install/apps/netdata.sh
}

# Organizr
ORGANIZR(){
  /opt/GooPlex/install/apps/organizr.sh
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
  echo -e " $FUNCTION "
  echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo -e " ${STD}"
  echo -e " ${LPURPLE}A${STD} - Rclone"
  echo -e " ${LPURPLE}B${STD} - Plex"
  echo -e " ${LPURPLE}C${STD} - Tautulli"
  echo -e " ${LPURPLE}D${STD} - Sonarr"
  echo -e " ${LPURPLE}E${STD} - Radarr"
  echo -e " ${LPURPLE}F${STD} - Deluge"
  echo -e " ${LPURPLE}G${STD} - Netdata"
  echo -e " ${LPURPLE}H${STD} - Organizr"
  echo -e " ${LRED}Z${STD} - Exit $FUNCTION"
  echo -e ""
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
      [Dd]) SONARR ;;
      [Ee]) RADARR ;;
      [Ff]) DELUGE ;;
      [Gg]) NETDATA ;;
      [Hh]) ORGANIZR ;;
      [Zz]) QUIT ;;
      *) echo -e "${RED}Please select a valid option${STD}" && sleep 2
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
