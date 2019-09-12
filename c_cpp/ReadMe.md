# Language: C/C++

## Introduction
C and C++ are related but are also very different languages. Actian mixes them up, especially in the Btrieve API 2 SDK. For this reason they are also combined in this repository. I feel this is unjust and they should be split. Not only would make this things cleaner, but also it would be easier to find what you are looking for and it would stress the need to provide example code in both languages.

## Land of plenty
C and C++ are quite old languages and used to be two very prominent languages in the IT business. They are well supported and plenty of documentation, blogs, example code, etc, etc can be found all over the net. On top of that C and C++ seem also be premier choice of those who wrote the Programmers Manual and the SDKs. Not surprisingly all APIs can be used from C/C++ which can not be said of other languages.

## The languages
More information about the C language can be found on [Wiki of ##C o Freenode](http://iso-9899.info/wiki/Main_Page). Unfortunately their does not seem to be an official C language website as there is for many languages like [Ruby](https://www.ruby-lang.org/) or [Python](https://www.python.org/).
More information about the C++ language can be found on [ISO C++](https://isocpp.org).

A more schematic overview of both can be found [here](https://en.cppreference.com/w/)

## Language specific/general/preferred access methods:

For C++ their is no really preferred method. This is illustrated by the following [presentation](https://isocpp.org/blog/2017/08/cppcon-2016-a-modern-database-interface-for-cpp-erik-smith)
For C it seems it does not get any better.
This [overview](https://en.cppreference.com/w/) does not show any database related stuff.

## Support by Actian?
Yes, C and C++ are the most supported languages. All APIs are available.

## Third party alternatives
?

## Actian Access Methods
See in general: https://docs.actian.com/psql/PSQLv13/index.html
Or detailed: https://docs.actian.com/psql/PSQLv13/welcome/libwelcome.htm#ww143297

| Access Method        | library availability | implementation  | to do |
| --- | --- | --- | --- |
| Btrieve API          | no                   |                 |       |
| Btrieve 2 API native | no                   |                 |       |
| Btrieve 2 API SWIG   | yes                  |                 |       |
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

