#!/bin/bash

sudo chown -R plexuser:plexuser /opt/GooPlex
sudo rsync -a /opt/GooPlex/install/gooplex /bin
sudo chmod +x /bin/gooplex

gooplex
