# Data Access using ODBC from from Ruby

## Language specific/general/preferred access methods:

* odbc : <http://www.ch-werner.de/rubyodbc>
* sequel : <http://sequel.jeremyevans.net>
* dbd / dbi : <https://github.com/erikh/ruby-dbi>
* datamapper / dataobjects : <https://github.com/datamapper/do>

Only Sequel seems to be not an abandoned project.

Implemented:
* native ODBC DSN-based
* sequel ODBC DSN-based
* DBI ODBC DSN-based

To-Do:
above three DSN less --> done, not tested for obvious reason (see below)

>>> BIG FAT WARNING <<<
All this code is not properly tested. Why?
[bug: Cannot allocate SQLHENV](https://bugs.launchpad.net/raspbian/+bug/1832778)
Bug exists at least on:
* Raspbian Stretch
* Raspbian Buster
* Debian Buster
Looks ok on:
* Debian Stretch

Given the fact that this bug seems to be quite frequent in many builds for many different distros it is probably given that ODBC-Ruby is not a very popular way to access databases.
Reliability (especially if software gets updated) is a big issue here.
