#!/usr/bin/env ruby

require "rubygems"
require "odbc"
#require "dbi"

db_name='demodata'
db_user=''
db_pass=''
db_query='SELECT * FROM Person'

db_cstr='Driver={PervasiveSQL};ServerName=localhost;dbq=@demodata;'

#library(DBI)
# check:  odbcinst -j
con <- dbConnect(odbc::odbc(),
  driver = "PervasiveSQL",
  database = db_name) #,
#  uid = "",
#  pwd = "",
#  host = "localhost",
#  port = 1583 )

rs <- dbSendQuert(db_query)
# retrieve the first 100 results
f100 <- dbFetch(rs, n=100)
