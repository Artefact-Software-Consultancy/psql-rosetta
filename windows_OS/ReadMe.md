# Scripts which can be run from the commandline in Windows

## psODBCTest.ps1
PowerShell script to connect to (Remote) Actian Pervasive.SQL server
using an existing DSN (beware of 32 vs 64 bit!):
 .\psODBCTest.ps1 raspi RaspiDemodata64 client
 remote server: raspi
 RaspiDemodata64: 64-bit System DSN (Driver: Pervasive ODBC Interface) on local Windows 10 64-bit Pro machine

## psODBCTest2.ps1
PowerShell script to connect to (Remote) Actian Pervasive.SQL server
DSN-less ODBC connection (no issues with 32 vs 64 bit!)
 .\psODBCTest2.ps1 raspi Demodata
 Remote server: raspi
 Remote DSN/Named Database: Demodata

## psPSQLTest.ps1
Simple Powershell script example to connect to 'demodata' database on localhost using 'Pervasive.Data.SqlClient'.


## psodbc.sp1
Powershell script example of DSN-based with fixed remote host ODBC connection script. Ignore and use psODBCTest.ps1 or, even better, psODBCTest2.ps1, instead.

## pspcddl.bat
Windows batch script using the Windows specific pvddl binary.
See also: https://docs.actian.com/psql/psqlv13/#page/uguide%2Fuguide.pvddl.htm


