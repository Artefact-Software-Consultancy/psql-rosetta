#!/usr/bin/env ruby

require "rubygems"
require "sequel"

$db_name='demodata'
$db_user=''
$db_pass=''
$db_query='SELECT * FROM Person'

$db_connstr='Driver={/usr/local/psql/lib64/libodbcci.so};ServerName=localhost;dbq=@demodata;'

$db = Sequel.odbc($db_connstr) # , :user => db_user, :password => db_pass)
$ds = $db[$b_query]
puts "Count of records : " + $ds.count
