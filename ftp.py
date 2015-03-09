#!/usr/bin/python

from ftplib import FTP
import db

print 'public_html/' + db.get('house') 



	ftp = FTP('www.infinitemonkeymachine.com')   # connect to host, default port
	ftp.login("thogan","sazerac14me")               

	ftp.cwd('public_html/nemo')   

	file = open ("/home/pi/temp/temp.csv")
	ftp.storbinary ('STOR ' + 'temp.csv', file)
	file.close() 
	
	file = open ("/home/pi/temp/motion.csv")
	ftp.storbinary ('STOR ' + 'motion.csv', file)
	file.close()

	ftp.quit() 

	

