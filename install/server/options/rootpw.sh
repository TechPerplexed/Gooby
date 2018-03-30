#!/bin/bash

function="change the root password"

# ------------
# Begin script
# ------------

source /opt/GooPlex/install/meta/instbeg.sh

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
