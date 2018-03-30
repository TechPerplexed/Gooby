#!/bin/bash

function="change the root password"

# ------------
# Begin script
# ------------

STD='\033[0m'
RED='\033[00;31m'
GRN='\033[00;32m'
YLW='\033[00;33m'
BLU='\033[00;34m'

pause(){
  read -p "Press [Enter] key to return to the menu..." fackEnterKey
}

# --------------
# Confirm action
# --------------

clear
read -p "Are you sure you want to $function (y/N)? " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]
then

# -----------
# Main script
# -----------

# Explanation

clear
echo -e "Create a ${GRN}very strong${STD} root password"
echo -e "The best way is to use a ${BLU}password generator${STD}"
echo -e "Then make sure to store your password in a ${RED}safe place${STD}"
echo ""

# Execution

sudo -s passwd

# ----------
# Finalizing
# ----------

else

  echo -e "You chose ${YLW}1not${STD} to $function"

fi
