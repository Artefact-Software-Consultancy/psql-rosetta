#!/usr/bin/env lua
-- https://github.com/moteus/lua-odbc
db = require "luasql.odbc"

dbname='demodata' -- DSN
dbuser=''
dbpass=''
dbquery='SELECT COUNT(*) FROM Person'

-- will not work until this is resolved?
-- https://github.com/keplerproject/luasql/issues/96
dsn="{Driver='Pervasive ODBC Interface'};ServerName='localhost';dbq='@demodata'"

local env = db.odbc()
local conn = env:connect(dsn)
print(env,conn)

cursor,errorString = conn:execute(dbquery)
print(cursor,errorstring)

-- https://keplerproject.github.io/luasql/manual.html
-- row = cursor:fetch({}, "a")
row = cursor:fetch()
while row do
    print(string.format("Count: %s", row))
    -- row = cursor:fetch(row, "a")
    row = cursor:fetch()
end

cursor:close()
conn:close()
env:close()
