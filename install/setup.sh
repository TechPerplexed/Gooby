#!/bin/bash

sudo rsync -a /opt/GooPlex/install/gooplex /bin
chmod 755 /bin/gooplex
gooplex
