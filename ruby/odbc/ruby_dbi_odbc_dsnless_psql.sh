#!/usr/bin/env ruby

require "rubygems"
require "dbi"

db_name='demodata'
db_user=''
db_pass=''
db_query='SELECT COUNT(*) FROM Person'

db_cstr='Driver={PervasiveSQL};ServerName=localhost;dbq=@demodata;'

begin
	dbh = DBI.connect('DBI:ODBC:' + db_cstr) # , db_user, db_pass)
	psh = dbh.prepare(db_query)

	psh.execute
	while rec = psh.fetch do
		puts rec.join(", ")
	end
rescue DBI::DatabaseError => e
	puts "A database error occurred"
	puts "Error code :    #{e.err}"
	puts "Error message : #{e.errstr}"
ensure
	# disconnect
	dbh.disconnect if dbh
end

