# Language: Perl

## Language specific/general/preferred access methods:

Although ancient (2003) this article seems still to sum things up: [Databases and Perl](https://www.p
erl.com/pub/2003/10/23/databases.html/)

[Perl DataBase Interface (DBI)](https://dbi.perl.org) is normally the preferred choice. Drawback is that no native Pervasive.SQL driver exists.
As always ODBC comes to the rescue.
Nobody seems to use ODBC directly, but always ODBC through DBI.

## Support by Actian?
The SWIG project itself provides [SWIG documentation](http://swig.org/Doc3.0/SWIGDocumentation.html#Php).
Unfortunately Actian only provides a PHP interface file, but no documentation, just a reference that Perl is supported.
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

## Third party alternatives
DBI:ODBC seems the only way with the possible exception of the BTRIEVE 2 API.
But there are third party alternatives:
https://metacpan.org/search?q=btrieve

https://metacpan.org/pod/BTRIEVE::SAVE
https://metacpan.org/pod/BTRIEVE::FileIO
https://metacpan.org/pod/BTRIEVE::Native

Does not look promissing: code from 2004 with:
https://code.activestate.com/ppm/BTRIEVE-FileIO/
https://code.activestate.com/ppm/BTRIEVE-SAVE/
https://code.activestate.com/ppm/BTRIEVE-Native/

!!! Big fat WARNING !!!
It looks like the code is accessing data without the MKDE. This is bound to get you into trouble.

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
  * native ODBC : done; sort of; see source; do not use
  * DBI/DBD ODBC : done

* ODBC DSN-less
  * native ODBC : will not do
  * DBI/DBD ODBC : done

* SWIG
  Actian provides no "official" documentation on how to build the Swig wrappers. However based on a blog article by Actian's Linda Anderson one can build the Python interface on Windows.
  Based on this work Bill Bach (Goldstar Software) showed how to do it on Linux. Based on their work I wrote scripts to build wrappers for all supported languages by Actian on Linux.
