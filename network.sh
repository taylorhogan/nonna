#!/bin/bash


while true ; do
   if ifconfig wlan0 | grep -q "inet addr:" ; then
      sleep 60
   else
   	  DATE=$(date)
      echo $DATE " Network connection down! Attempting reconnection." >>log.txt
      ifup --force wlan0
      sleep 10
   fi
done
