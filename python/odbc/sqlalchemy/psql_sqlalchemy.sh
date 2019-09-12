#! /usr/bin/env python
#
# Example: Connecting Python/SQLAlchemy on UNIX and Linux to Actian Zen/Pervasive.SQL
#

import sqlalchemy
import pyodbc
from sqlalchemy import *

#import imp
#psql = imp.load_source('pervasive', '/home/pi/github/sqlalchemy-pervasive/sqlalchemy_pervasive/')

dsn='DEMODATA'
enginetype='pervasive' # dialect
dbdriver='pyodbc'

#connectionstring = enginetype + "+" + dbdriver + "://" + dsn
connectionstring = 'pervasive://' + dsn

engine =  create_engine(connectionstring)
connection = engine.connect()

'''
result = connection.execute("select * from person")
for row in result:
     print "Person:", row["Last_Name"], " , ", row['First_Name']
'''
result = connection.execute("SELECT Xf$Name FROM X$File")
print ("Tables found in DSN=%s :" % dsn)
for row in result:
    print row[0]

result.close()
connection.close()
