#!/bin/bash
# git clone https://github.com/taylorhogan/nonna nonna
# get the latest from git

rm pull-new.sh

git pull

chmod +x pull-new.sh

#install the new crontab
crontab crontab.txt




