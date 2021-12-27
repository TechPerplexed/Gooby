#!/bin/bash

# Stay tuned - expected sometime in 2022

# Let's sneak in a new parameter

[[ ! -f ${CONFIGVARS}/rootmount ]] && echo "/mnt" > ${CONFIGVARS}/rootmount
