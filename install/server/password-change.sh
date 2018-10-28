#!/bin/bash

clear

EXPLAINTASK

CONFIRMATION

if [[ ${REPLY} =~ ^[Yy]$ ]]; then

	GOAHEAD
    
		clear

		echo
		read -n 1 -s -r -p "Change password for your user $USER ${YELLOW}(U)${STD} or root ${YELLOW}(R)?${STD} " -i "" choice
		echo

		case "$choice" in
			u|U ) passwd ;;
			r|R ) echo "Coming soon" ;;
			* ) echo "No passwords changed" ;;
		esac

	TASKCOMPLETE

else

	CANCELTHIS

fi

PAUSE
