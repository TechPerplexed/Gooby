#!/bin/bash

clear

EXPLAINTASK

CONFIRMATION

if [[ ${REPLY} =~ ^[Yy]$ ]]; then

	GOAHEAD
    
		clear

		echo
		echo "Change password for your user $USER ${YELLOW}(U)${STD}"
		read -n 1 -s -r -p "or root ${YELLOW}(R)?${STD} " -i "" choice

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
