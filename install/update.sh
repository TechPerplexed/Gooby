#!/bin/bash

FUNCTION="Update GooPlex"

# ---------
# Variables
# ---------

source /opt/GooPlex/menus/variables.sh
clear

# -----------
# Main script
# -----------

cd ~
sudo rm -r /opt/GooPlex
sudo git clone https://github.com/TechPerplexed/GooPlex /opt/GooPlex
sudo chmod +x /opt/GooPlex/install/*
sudo rsync -a /opt/GooPlex/install/gooplex /bin
sudo chmod 755 /bin/gooplex

clear

# -----------
# Explanation
# -----------

echo -e "${LMAGENTA}"
echo -e "------------------------------------------------"
echo -e " GooPlex has been updated to the latest version "
echo -e "------------------------------------------------"
echo -e "${STD}"

PAUSE
