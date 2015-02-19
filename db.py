#!/usr/bin/python

import os
import glob
import time
from datetime import datetime, date

import csv



def read_file (file_name):
   db = {}
   with open(file_name, 'rb') as csvfile:
      dbreader = csv.reader(csvfile)
      for row in dbreader	:
         db[row[0]] = row[1]
   return db
         
def get(key):
   db = read_file('user.csv')
   return db[key]
   
