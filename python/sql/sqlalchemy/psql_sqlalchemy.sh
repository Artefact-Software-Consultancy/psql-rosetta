#! /usr/bin/env python3
#
# Example: Connecting Python/SQLAlchemy on UNIX and Linux to Actian Zen/Pervasive.SQL
#

import sqlalchemy
#import pyodbc
from sqlalchemy import *

# pip3 install sqlalchemy-pervasive
#import imp
#psql = imp.load_source('pervasive', '/opt/sqlalchemy-pervasive/sqlalchemy-pervasive/sqlalchemy_pervasive/')

dsn='DEMODATA'
enginetype='pervasive' # dialect
#dbdriver='pyodbc'
dbdriver='pervasive'

#connectionstring = enginetype + "+" + dbdriver + "://" + dsn
connectionstring = 'pervasive://' + dsn

engine =  create_engine(connectionstring)
connection = engine.connect()

'''
result = connection.execute("select * from person")
for row in result:
     print "Person:", row["Last_Name"], " , ", row['First_Name']
'''
#result = connection.execute("SELECT Xf$Name FROM X$File")
#print ("Tables found in DSN=%s :" % dsn)
result = connection.execute("SELECT COUNT(*) FROM Person")
print ("Number of people found in table 'Person' : ")
for row in result:
    print(row[0])

result.close()
connection.close()
