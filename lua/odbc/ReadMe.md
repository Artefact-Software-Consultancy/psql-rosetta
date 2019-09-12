# Accessing data using ODBC from Lua

Three options exists:
* [LuaODBC](https://github.com/moteus/lua-odbc/)
* [LuaSQL](http://keplerproject.github.io/luasql/)
* [Dado](http://www.ccpa.puc-rio.br/software/dado/)
From a quick glance Dado sits on top of LuaSQL which in turn sits on LuaODBC.
LuaSQL seems to most common one.

## Native
This can be done using [LuaODBC](https://github.com/moteus/lua-odbc/)
Not implemented. Properly documented. Not the most popular way to access databases.

## LuaSQL
[LuaSQL](http://keplerproject.github.io/luasql/)
This is the preferred way to access not natively supported databases such as Pervasive.SQL.
Two examples have been included: DSN based and DSN-less.

## Dado
[Dado](http://www.ccpa.puc-rio.br/software/dado/)
Not implemented.
