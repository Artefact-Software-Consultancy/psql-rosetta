#!/usr/bin/env ruby

require "odbc"
require "sequel"

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

$query = 'SELECT * FROM Person'

# https://www.connectionstrings.com/pervasive/
# windows: see ODBC Manager
# linux (unixodbc): odbcinst -q -d and odbcinst -q -s
# mac: see linux?

puts "Ruby ODBC access using ODBC through Sequel : DSN-based" + "\n"

# DNS-less coonnection
#connectionstring = "DRIVER={" + $driver + "};SERVER=" + $server + ";dbq=@" + $dbname + ";"
connectionstring = "DSN=demodata"

puts "ConnectionString : #{connectionstring}"

# https://sequel.jeremyevans.net/rdoc/files/doc/opening_databases_rdoc.html
$db = Sequel.odbc(:drvconnect => connectionstring) # , :user => db_user, :password => db_pass)
$ds = $db[$query]
puts "Query: " + $query
puts "Count of records : #{$ds.count}"