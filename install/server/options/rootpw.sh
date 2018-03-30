#!/bin/bash

function="change the root password"

/install/meta/instbeg.sh

# Begin code

  clear
  echo -e "Use a password generator to create a very strong root password"
  echo ""
  sudo -s passwd

# End code

/install/meta/instend.sh
