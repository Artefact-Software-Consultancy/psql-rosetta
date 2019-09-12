#! /usr/bin/env python
#
# Example: Connecting Python/SQLAlchemy on UNIX and Linux to Actian Zen/Pervasive.SQL
#
# See also: https://pypi.org/project/sqlalchemy-pervasive/

import sys
import sqlalchemy
import pyodbc
from sqlalchemy import *
from sqlalchemy.connectors.pyodbc import *

#import imp
#psql = imp.load_source('pervasive', '/home/pi/github/sqlalchemy-pervasive/sqlalchemy_pervasive/')

#import pkg_resources
#pkg_resources.require("sqlalchemy-pervasive")

#import sqlalchemy.dialects.pervasive

# list all dialects
#print("SQLAlchemy dialects available:")
#dia = sys.modules['sqlalchemy.dialects']
#print(dia)

#import urllib
#ce="DRIVER=PervasiveSQL;SERVERNAME=localhost;DBQ=demodata"
#params = urllib.parse.quote_plus(ce)

dsn='DEMODATA'
enginetype='pervasive' # dialect
dbdriver='pyodbc'

dbhost='localhost'
dbname='demodata'
odbcdrv='PervasiveSQL' # see /etc/odbcinst.ini by querying: odbcinst -q -d

odbcdrv=odbcdrv.replace(' ','+')
#ce=enginetype + '+' + dbdriver + '://' + dbhost + '/' + dbname + '?' + 'driver=' + odbcdrv 
#ce=enginetype + '://' + dbhost + '/' + dbname + '?' + 'driver=' + odbcdrv 
#ce=enginetype + '://' + dbhost + '/' + '\@' + dbname + '?' + 'driver=' + odbcdrv 
ce=enginetype + '://' + dbhost + '/' + dbname + '?' + 'driver=' + odbcdrv + "&" + "dbq=" + dbname
# weird: I have to ditch the driver, however the whole connection string is weird:
# - current working connectionstring has the dbname specified twice
# - it seems custom to specify the dialect although a driver is specified which should be sufficient
#   but this is ok following docs like:
#   - https://docs.sqlalchemy.org/en/13/dialects/mysql.html#module-sqlalchemy.dialects.mysql.pyodbc
#   - https://docs.sqlalchemy.org/en/13/dialects/mssql.html#pass-through-exact-pyodbc-string 


#connectionstring = enginetype + "+" + dbdriver + "://" + dsn
#connectionstring = 'pervasive://' + dsn
#ce=enginetype + "+" + dbdriver + "://localhost/demodata?driver=PervasiveSQL"
print(ce)
connectionurl = sqlalchemy.engine.url.make_url(ce)

#engine =  create_engine(connectionstring)
#connection = engine.connect()

#connector = PyODBCConnector()
#connection = connector.create_connect_args(connectionurl)

#engine = create_engine(connectionurl)
#engine = create_engine(enginetype + "+" + dbdriver + ":///?odbc_connect=%s"% params)
engine = create_engine(ce)
connection = engine.connect()

print(connection)

'''
result = connection.execute("select * from person")
for row in result:
     print "Person:", row["Last_Name"], " , ", row['First_Name']
'''
result = connection.execute("SELECT Xf$Name FROM X$File")
print ("Tables found in DSN=%s :" % dsn)
for row in result:
    print(row[0])

result.close()
connection.close()
