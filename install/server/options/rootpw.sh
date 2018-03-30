#!/bin/bash

function="change the root password"

#!/bin/bash

# ----------------
# Define variables
# ----------------

source /opt/GooPlex/install/meta/colors.sh

# Confirmation

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
echo -e "Create a ${GREEN}very strong${STD} root password"
echo -e "The best way is to use a ${CYAN}password generator${STD}"
echo -e "Then make sure to store your password in a ${RED}safe place${STD}"
echo ""

# Execution

sudo -s passwd

# ----------
# Finalizing
# ----------

else

  echo -e "You chose ${YELLOW}not${STD} to $function"

fi
