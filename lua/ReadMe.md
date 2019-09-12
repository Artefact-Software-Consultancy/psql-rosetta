# Language: Lua

## Language specific/general/preferred access methods:

An overview can be found here: [Database Access @ Lua Users Wiki](http://lua-users.org/wiki/DatabaseAccess)
No native support for Pervasive.SQL so ODBC remains as an option.
Three options exists:
* [LuaODBC](https://github.com/moteus/lua-odbc/)
* [LuaSQL](http://keplerproject.github.io/luasql/)
* [Dado](http://www.ccpa.puc-rio.br/software/dado/)
From a quick glance Dado sits on top of LuaSQL which in turn sits on LuaODBC.
LuaSQL seems to most common one.

### Warning
The combination Lua & Pervasive.SQL is highly exotic. Chances are even ODBC access can lead to unexpected results as nothing is properly tested.

## Support by Actian?
No. No native client/driver etc is provided. 

## Actian Access Methods
See in general: https://docs.actian.com/psql/PSQLv13/index.html
Or detailed: https://docs.actian.com/psql/PSQLv13/welcome/libwelcome.htm#ww143297

| Access Method        | library availability | implementation  | to do |
| --- | --- | --- | --- |
| Btrieve API          | no                   |                 |       |
| Btrieve 2 API native | no                   |                 |       |
| Btrieve 2 API SWIG   | no                   |                 |       |
| SQL native           | no                   |                 |       |
| ODBC                 | yes *                | done            |       |
| ODBC DSN-less        | yes **               | done            |       |
| ADO.NET              | ?                    |                 |       |
| JDBC                 | ?                    |                 |       |
| JDBC-ODBC-bridge     | ?                    |                 |       |
| Java Persistence API | no                   |                 |       |
| OLE DB               | ?                    |                 |       |
| ActiveX              | no                   |                 |       |
| DTI                  | no                   |                 |       |
| DTO                  | no                   |                 |       |

To do:
1 : write code
2 : (further) test code
3 : code clean up
4 : document code
5 : extend / improve code

library availability notes:
See above

Notes to table:
* ODBC
  * LuaSQL ODBC : done

* ODBC DSN-less
  * LuaSQL ODBC : done
