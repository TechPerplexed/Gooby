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

    echo ""
    echo -e "Coming soon!"
	
    TASKCOMPLETE

  else

    CANCELTHIS

  fi

fi

rm /tmp/checkapp.txt
PAUSE
