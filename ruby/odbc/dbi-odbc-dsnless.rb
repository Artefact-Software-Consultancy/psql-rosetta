#!/usr/bin/env ruby

#require "odbc"
#require "dbd"
require "dbi" # gems needed: dbi, dbd-odbc, ruby-odbc

# http://www.ch-werner.de/rubyodbc/
# https://github.com/localytics/odbc_adapter
# http://www.iodbc.org/dataspace/doc/iodbc/wiki/iodbcWiki/IODBCRubyHOWTO
# https://www.easysoft.com/developer/languages/ruby/rails.html
# https://engineering.ezcater.com/the-long-long-journey-of-connecting-to-snowflake-with-ruby
# https://anthonylewis.com/2011/03/08/exploring-odbc-with-ruby-dbi/

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

puts "Ruby ODBC access using ODBC through DBI : DSN-less" + "\n"

# DNS-less connection
connectionstring = "Driver={" + $driver + "};Server=" + $server + ";dbq=@" + $dbname + ";"

puts "ConnectionString : #{connectionstring}"

begin
    dbh = DBI.connect("DBI:ODBC:" + connectionstring)
    sth = dbh.prepare($query)
    sth.execute
    rows = sth.fetch_all
    puts "Number of people in Person table: #{rows.size}" + "\n"
rescue DBI::DatabaseError => e
   puts "An error occurred"
   puts "Error code:    #{e.err}"
   puts "Error message: #{e.errstr}"
ensure
   # disconnect from server
   sth.finish if sth
   dbh.disconnect if dbh
end