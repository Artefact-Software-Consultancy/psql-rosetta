# Language: PHP

## Language specific/general/preferred access methods:

An overview can be found here: [DB extensions](https://www.php.net/manual/en/refs.database.php)
The most obvious choices are native [ODBC](https://www.php.net/manual/en/book.uodbc.php) and the community preferred [PHP Data Objects](https://www.php.net/manual/en/book.pdo.php).

## Support by Actian?
No. No native client/driver etc is provided. 
Only semi-native is a SWIG wrapper implementation for the Btrieve 2 API.

### SWIG
The SWIG project itself provides [SWIG documentation](http://swig.org/Doc3.0/SWIGDocumentation.html#Php).
Unfortunately Actian only provides a PHP interface file, but no documentation, just a reference that PHP is supported.
Luckely I have overcome this and wrapped it up in build script.
For reference purposes only links to SWIG Btrieve API 2 support for Python are listed below as Python is the only language which Actian more or less bottered to describe.

### Links
* (https://www.actian.com/company/blog/python-btrieve-2-windows-accessing-actian-zen-data-no-sql)
* (http://www.goldstarsoftware.com/papers/AccessingZenFromPythonOnWindows.pdf)
* (http://www.goldstarsoftware.com/papers/AccessingZenFromPythonOnRaspberryPi.pdf)
* (https://communities.actian.com/s/question/0D5f300004JcqvcCAB/using-python-to-access-zen-on-raspbian)
* [broken link to my posting](https://communities.actian.com/s/question/0D5f300005DmbCaCAJ/how-to-build-btrieve2-api-swig-wrappers-for-php-perl-and-python
  Unfortunately for some reason my own posting on the Actian Pervasive.SQL/Zen commuunity forum was removed, so no link.
  But the issues mentioned there are resolved. See the ReadMe files in the SWIG subdirectory.

## Actian Access Methods
See in general: https://docs.actian.com/psql/PSQLv13/index.html
Or detailed: https://docs.actian.com/psql/PSQLv13/welcome/libwelcome.htm#ww143297

| Access Method        | library availability | implementation  | to do |
| --- | --- | --- | --- |
| Btrieve API          | no                   |                 |       |
| Btrieve 2 API native | no                   |                 |       |
| Btrieve 2 API SWIG   | yes                  | done    |       |       |
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

* ODBC DSN-less
  * native ODBC : done

* SWIG
  Actian provides no "official" documentation on how to build the Swig wrappers. However based on a blog article by Actian's Linda Anderson one can build the Python interface on Windows.
  Based on this work Bill Bach (Goldstar Software) showed how to do it on Linux. Based on their work I wrote scripts to build wrappers for all supported languages by Actian on Linux.
  Also included is a test script, which is an adapted port of the original script by Linda (and Bill).
