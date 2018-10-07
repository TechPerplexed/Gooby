#!/bin/bash

which emby > /tmp/checkapp.txt
clear

if [ -s /tmp/checkapp.txt ]; then

  ALREADYINSTALLED

else

  EXPLAINTASK
  
  CONFIRMATION

  if [[ ${REPLY} =~ ^[Yy]$ ]]; then

    GOAHEAD

    # ----------
    # Open ports
    # ----------

    sudo ufw allow 32400

    # ------------
    # Dependencies
    # ------------

    sudo apt-get upgrade -y && sudo apt-get upgrade -y

    # -----------
    # Main script
    # -----------

    cd /tmp
    clear
    echo -e "Please read the options carefully"
    echo ""
    bash -c "$(wget -qO - https://raw.githubusercontent.com/mrworf/plexupdate/master/extras/installer.sh)"
    cd ~

	TASKCOMPLETE

  else

    CANCELTHIS

  fi

fi

rm /tmp/checkapp.txt
PAUSE
