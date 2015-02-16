#!/usr/bin/python

import RPi.GPIO as GPIO
import time
from datetime import datetime, date 
from stathat import StatHat


GPIO.setmode(GPIO.BCM)
 
#last pin
GPIO_PIR = 7 
 

 
# Set pin as input
GPIO.setup(GPIO_PIR,GPIO.IN)      # Echo
 
Current_State  = 0
Previous_State = 0

sh = StatHat()
 
try:
 
  print "Waiting for PIR to settle ..."
 
  # Loop until PIR output is 0
  while GPIO.input(GPIO_PIR)==1:
    Current_State  = 0
 
  print "  Ready"
 
  # Loop until users quits with CTRL-C
  while True :
 
    # Read PIR state
    Current_State = GPIO.input(GPIO_PIR)
 
    if Current_State==1 and Previous_State==0:
      # PIR is triggered
      print "  Motion detected!"
      t = datetime.today()
      f = open("/home/pi/temp/motion.csv","a") 
      f.write(t.strftime("%Y-%m-%d %H:%M:%S") + "," + "1" + "\n")
      f.close() 
      # Record previous state
      Previous_State=1
      time.sleep (60 * 5) # wait 5 minutes after motion to look for more motion
      
      
    elif Current_State==0 and Previous_State==1:
      # PIR has returned to ready state
      print "  Ready"
      t = datetime.today()
      f = open("/home/pi/temp/motion.csv","a") 
      f.write(t.strftime("%Y-%m-%d %H:%M:%S") + "," + "0" + "\n")
      f.close() 
      Previous_State=0
      
 
    # Wait for half second
    time.sleep(.5)
 
except KeyboardInterrupt:
  print "  Quit"
  # Reset GPIO settings
  GPIO.cleanup()

