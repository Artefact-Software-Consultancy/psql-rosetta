#!/usr/bin/env python

import pyodbc

#drvconn="DRIVER=Pervasive ODBC Client;ServerName=localhost;dbq=@demodata;" 
drvconn="DRIVER=PervasiveSQL;ServerName=localhost;dbq=@demodata;" 
# check /etc/odbcinst.ini & /etc/odbc.ini using "odbcinst -q -d" or "odbcinst -q -s"

dsn="DEMODATA"
cnxn = pyodbc.connect(drvconn)
cursor = cnxn.cursor()
cursor.tables()
rows = cursor.fetchall()
print ("Connection: %s " % drvconn)
print ("Tables found in DSN=%s :" % dsn) 
for row in rows:
	print row.table_name

