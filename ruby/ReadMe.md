# Language: Ruby

## Language specific/general/preferred access methods:

* odbc : <http://www.ch-werner.de/rubyodbc>
* sequel : <http://sequel.jeremyevans.net>
* dbd / dbi : <https://github.com/erikh/ruby-dbi>
* datamapper / dataobjects : <https://github.com/datamapper/do>

Only Sequel seems to be not an abandoned project.

Also see: [The Ruby Toolbox SQL Database Adapters](https://www.ruby-toolbox.com/categories/SQL_Database_Adapters)

## Support by Actian?
No. No native client/driver/wrapper etc is provided. No documentation can be found.

### Preferred method?
ODBC does not seem to be a preferred method of accessing databases from Ruby. The homepage of the GEM/project supports that idea. Combined with the fact that Ruby is not officially supported by Actian chances are one can have unexpected results and can run into untested situations and unsupported calls, datatypes, etc.


### Warning
The combination Ruby & Pervasive.SQL is highly exotic. Chances are even ODBC access can lead to unexpected results as nothing is properly tested.

## Support by Actian?
No. No native client/driver etc is provided. 

## Actian Access Methods
See in general: [Pervasive.SQL Documentation](https://docs.actian.com/psql/PSQLv13/index.html)
Or detailed: [Overview of Pervasive.SQL Data Access methods](https://docs.actian.com/psql/PSQLv13/welcome/libwelcome.htm#ww143310)

| Access Method        | library availability | implementation | to do |
| --- | --- | --- | --- |
| Btrieve API          | no                   |                |       |
| Btrieve 2 API native | no                   |                |       |
| Btrieve 2 API SWIG   | no                   |                |       |
| SQL native           | no                   |                |       |
| ODBC                 | yes *                | done           |       |
| ODBC DSN-less        | yes **               | done           |       |
| ADO.NET              | indirect via Sequel? |                |       |
| JDBC                 | indirect via Sequel? |                |       |
| JDBC-ODBC-bridge     | indirect via Sequel? |                |       |
| Java Persistence API | no                   |                |       |
| OLE DB               | indirect via Sequel? |                |       |
| ActiveX              | no                   |                |       |
| DTI                  | no                   |                |       |
| DTO                  | no                   |                |       |

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
  * native ODBC : done
  * DBI/DBD : done
  * Sequel : done
  * DataObject: : not done
* ODBC DSN-less
  * native ODBC : done
  * DBI/DBD : done
  * Sequel : done
  * DataObject: : not done
