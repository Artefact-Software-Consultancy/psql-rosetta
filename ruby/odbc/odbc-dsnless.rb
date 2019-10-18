#!/usr/bin/env ruby

require "odbc"

# http://www.ch-werner.de/rubyodbc/
# https://github.com/localytics/odbc_adapter
# http://www.iodbc.org/dataspace/doc/iodbc/wiki/iodbcWiki/IODBCRubyHOWTO
# https://www.easysoft.com/developer/languages/ruby/rails.html
# https://engineering.ezcater.com/the-long-long-journey-of-connecting-to-snowflake-with-ruby

#$driver='Pervasive ODBC Client Interface'
$driver='Pervasive ODBC Interface'
$server='localhost'
$dbuser=''
$dbpass=''
$dbname='demodata'

$query = 'SELECT COUNT(*) FROM Person'

# https://www.connectionstrings.com/pervasive/
# windows: see ODBC Manager
# linux (unixodbc): odbcinst -q -d and odbcinst -q -s
# mac: see linux?

puts "Ruby ODBC access using native ODBC : DSN-less" + "\n"

# DNS-less coonnection
connectionstring = "DRIVER={" + $driver + "};SERVER=" + $server + ";dbq=@" + $dbname + ";"

puts "Connectstring: #{connectionstring}" + "\n"

# http://www.ch-werner.de/rubyodbc/odbc.html
con = ODBC::Database.new.drvconnect(connectionstring) or die "Unable to connect: " + ODBC::error + "\n"

puts "Connected to: " + con.connected?.to_s + "\n"

# count elements in recordset
stmt = con.run($query) or die "Unable to execute query: " + ODBC::error + "\n"
rs = stmt.fetch_all
$cnt = rs[0]

puts "Row count on table Person: #{$cnt} " + "\n"

con.disconnect