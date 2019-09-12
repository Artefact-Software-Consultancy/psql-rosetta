#!/usr/bin/env lua
db = require "luasql.odbc"

dbname='demodata'
dbuser=''
dbpass=''
dbquery='SELECT COUNT(*) FROM Person'

local env = db.odbc()
local conn = env:connect(dbname, dbuser, dbpass)
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
