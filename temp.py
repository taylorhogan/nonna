#!/usr/bin/python


import os
import glob
import time
from datetime import datetime, date


def read_temp_raw():
    f = open(device_file, 'r')
    lines = f.readlines()
    f.close()
    return lines
 
def read_temp():
    lines = read_temp_raw()
    while lines[0].strip()[-3:] != 'YES':
        time.sleep(0.2)
        lines = read_temp_raw()
    equals_pos = lines[1].find('t=')
    if equals_pos != -1:
        temp_string = lines[1][equals_pos+2:]
        temp_c = float(temp_string) / 1000.0
        temp_f = temp_c * 9.0 / 5.0 + 32.0
        return  temp_f
	

def debug (context):
    t = datetime.today()
    f = open("/home/pi/temp/debug.txt","a") 
    f.write(str(t) + "," + context + "\n")
    f.close() 
	
	

os.system('modprobe w1-gpio')
os.system('modprobe w1-therm')


base_dir = '/sys/bus/w1/devices/'
device_folder = glob.glob(base_dir + '28*')[0]
device_file = device_folder + '/w1_slave'

# Loop until users quits with CTRL-C
print "starting"
while True :       
	
	now_temp = read_temp()	
	
	t = datetime.today()
	f = open("/home/pi/temp/temp.csv","a") 
	f.write(t.strftime("%Y-%m-%d %H:%M") + "," + str(now_temp) + "\n")
	f.close() 
	
	time.sleep(5 * 60)
