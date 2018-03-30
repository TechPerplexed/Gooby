#!/bin/bash

FUNCTION="update VPS and prepare server"

# ---------
# Variables
# ---------

source /opt/GooPlex/install/variables.sh
clear

# Explanation

echo -e "This update only needs to be performed ${WHITE}once${STD}!"
echo ""

# Confirmation

read -p "Are you sure you want to $FUNCTION (y/N)? " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]
then

# -----------
# Main script
# -----------

echo "Soon"

# ----------
# Finalizing
# ----------

else

  echo -e "You chose ${YELLOW}not${STD} to $FUNCTION"

fi

PAUSE
