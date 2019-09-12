# Language: Python

## Language specific/general/preferred access methods:

An overview can be found here: [DB scenarios](https://docs.python-guide.org/scenarios/db)
The most obvious choices are native pyodbc or my favorite: SQLAlchemy. Combining it with Alembic makes a really powerful toolchest.
Unfortunately this is not supported by Actian. A third party driver, very limited and in beta state, does exist: [unofficial SQLAlchemy Pervasive>SQL driver](https://pypi.org/project/sqlalchemy-pervasive)

## Support by Actian?
No. No native client/driver etc is provided. Some documentation can be found.
Only semi-native is a SWIG wrapper implementation for the Btrieve 2 API.
There are two ways to get it working: manual build and the Python specific distutils way of building the SWIG wrapper. 
See: [With the aide of SWIG access using the Btrieve 2 API](https://communities.actian.com/s/question/0D5f300005DmbCaCAJ/how-to-build-btrieve2-api-swig-wrappers-for-php-perl-and-python) for all important info and links.

### Links
* (https://www.actian.com/company/blog/python-btrieve-2-windows-accessing-actian-zen-data-no-sql)
* (http://www.goldstarsoftware.com/papers/AccessingZenFromPythonOnWindows.pdf)
* (http://www.goldstarsoftware.com/papers/AccessingZenFromPythonOnRaspberryPi.pdf)
* (https://communities.actian.com/s/question/0D5f300004JcqvcCAB/using-python-to-access-zen-on-raspbian)
* [broken link to my posting](https://communities.actian.com/s/question/0D5f300005DmbCaCAJ/how-to-build-btrieve2-api-swig-wrappers-for-php-perl-and-python
  Unfortunately for some reason my own posting on the Actian Pervasive.SQL/Zen commuunity forum was removed, so no link.
  But the issues mentioned there are resolved. See the ReadMe files in the SWIG subdirectory.

## Third party alternatives
* https://pypi.org/project/sqlalchemy-pervasive/
* Others ?

## Actian Access Methods
See in general: https://docs.actian.com/psql/PSQLv13/index.html
Or detailed: https://docs.actian.com/psql/PSQLv13/welcome/libwelcome.htm#ww143297

| Access Method        | library availability | implementation  | to do |
| --- | --- | --- | --- |
| Btrieve API          | no                   |                 |       |
| Btrieve 2 API native | no                   |                 |       |
| Btrieve 2 API SWIG   | yes                  | semi documented |       |
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
  * native ODBC : done
  * SQLAlchemy ODBC : done

* ODBC DSN-less
  * native ODBC : done
  * SQLAlchemy ODBC : done

* SWIG
  Actian provides no "official" documentation on how to build the Swig wrappers. However based on a blog article by Actian's Linda Anderson one can build the Python interface on Windows.
  Based on this work Bill Bach (Goldstar Software) showed how to do it on Linux. Based on their work I wrote scripts to build wrappers for all supported languages by Actian on Linux.
