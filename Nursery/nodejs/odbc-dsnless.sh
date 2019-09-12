#!/bin/sh
export CONNECTION_STRING='Driver=PervasiveSQL;ServerName=localhost;dbq=@demodata;'
/usr/bin/nodejs ./odbc-dsnless.js
