#!/usr/bin/env python

import pyodbc

dsn="DEMODATA"
cnxn = pyodbc.connect("DSN=" + dsn)
cursor = cnxn.cursor()
cursor.tables()
rows = cursor.fetchall()
print ("Tables found in DSN=%s :" % dsn) 
for row in rows:
	print row.table_name

