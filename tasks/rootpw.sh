#!/bin/bash

FUNCTION="change the root password"

# ---------
# Variables
# ---------

source /opt/GooPlex/install/variables.sh

# Confirmation

clear
read -p "Are you sure you want to $FUNCTION (y/N)? " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]
then

# -----------
# Main script
# -----------

# Explanation

clear
echo -e "Create a ${CYAN}very strong${STD} root password"
echo -e "The best way is to use a ${CYAN}password generator${STD}"
echo -e "Then make sure to store your password in a ${CYAN}safe place${STD}"
echo ""

# Execution

sudo -s passwd

# ----------
# Finalizing
# ----------

else

  echo -e "You chose ${YELLOW}not${STD} to $FUNCTION"

fi
