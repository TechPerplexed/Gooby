#!/bin/bash

which plex > /tmp/checkapp.txt
clear

if [ ! -s /tmp/checkapp.txt ]; then

  NOTINSTALLED

else

  EXPLAINTASK

  CONFIRMATION

  if [[ ${REPLY} =~ ^[Yy]$ ]]; then

    GOAHEAD

    /opt/plexupdate/extras/installer.sh

    TASKCOMPLETE

  else

    CANCELTHIS

  fi

fi

rm /tmp/checkapp.txt
PAUSE
