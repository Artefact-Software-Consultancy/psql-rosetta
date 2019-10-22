# Visual Basic .NET

Obviously the name is a give away: Visual ...
So the obvious thing to do is use Components.
Pervasive.SQL has ActiveX components to access the Btrieve API.
Alternatively you can use the Btrieve API from code.
A more generic approach would be to use ODBC.

The situation sketch above was true since about the late nineties with Visual Basic 4 or 5 onwards.

New is the arrival of the CLI version of .NET Core which includes support for Visual Basic, C# and F#.

# odbc-dsn.vb
Simple code without error checking developed and tested under Linux commandline.
Uses the DSN=demodata; so adjust in code if required.

## Linux
vbnc odbc-dsn.vb results in odbc-dsn.exe which must be made executable using chmod +x

## Windows
Should work under Windows as well. Not tested yet.

# odbc-dsn-less.vb
Simple code without error checking developed and tested under Linux commandline.
Assumes a Driver named "PervasiveSQL" and a database named "demodata"; so adjust in code if required.

## Linux
vbnc odbc-dsn.vb results in odbc-dsn.exe which must be made executable using chmod +x

## Windows
Should work under Windows as well. Not tested yet.

# To Do
* test on Windows
* write example code using the ActiveX compontents : used to be provided in the SDK
* write example code using the Btrieve API : used to be provided in the SDK
* write example code using a datagrid using ODBC. Or make a reference to it: there will most likely be plenty examples on the net

# Links
* (http://vb.net-informations.com/ado.net/vb.net-ado.net-tutorial.htm)

