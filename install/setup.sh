#!/bin/bash

sudo rsync -a /opt/GooPlex/install/gooplex /bin
sudo chmod +x /bin/gooplex

gooplex
