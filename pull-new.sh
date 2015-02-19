#!/bin/bash
#
# git clone https://github.com/taylorhogan/nonna nonna
# sudo chmod +x pull-new.sh

# get the latest from git

git checkout pull-new.sh

git pull

chmod +x pull-new.sh

#install the new crontab
crontab crontab.txt




