# Data Access using ODBC from from Ruby

## Language specific/general/preferred access methods:

* odbc : <http://www.ch-werner.de/rubyodbc>
* sequel : <http://sequel.jeremyevans.net>
* dbd / dbi : <https://github.com/erikh/ruby-dbi>
* datamapper / dataobjects : <https://github.com/datamapper/do>

Only Sequel seems to be not an abandoned project.

### Requirements

* odbc   : gem install ruby-odbc
* dbi    : gem install dbi
           gem install dbd-odbc
* sequel : gem install sequel
Obviously the odbc gem is also required for DBI and Sequel when using ODBC.

## Implementation

Both DSN-based and DSN-less methods have been implement for: ODBC, DBI, Sequel.
No examples for DataMapper/DataObjects are provided. 

### Windows
All code is tested using Ruby on Windows (10 Pro) with both Pervasive.SQL v13 (remote) and ZEN v14 (local).
Ruby was installed using the 64-bit Windows installer. All required gems were manually installed.

### Linux
No testing so far, as I dislike alternative ecosystems in software. 
The ruby-odbc package in Debian is troublesome. See below.
Might work with other distributions or by manually installing gems.

## Major issues

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
