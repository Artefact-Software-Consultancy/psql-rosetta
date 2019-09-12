# Data access method SQL from Python

Pervasive.SQL has its own SQL dialect which is not 100% identical to ODBC standards.
You can use it from a SQL client application as for instance can be found in the Pervasive Control Center (PCC) or at the Linux commandline tool ISQL.
However this dialect if not offered as a separate API. Instead the programmers manual redirects you to ODBC.

For this reason no SQL example code can be found here.

# BUT ....
This might not be entirely true in the case of Python. [SQLAlchemy](https://www.sqlalchemy.org/) provides an Object Relational Mapper (ORM).
Given there is a native driver: [sqlalchemy-pervasive](https://github.com/SacNaturalFoods/sqlalchemy-pervasive) it might be the case that the Pervasive.SQL dialect can be used directly.
Please note that the native driver is an opensource third party driver which is not activly maintained. The driver is in an alpha stage, but basic operations seem ok.
Example code is provided. To install the driver/dialect: pip3 install sqlalchemy-pervasive

## SQLAlchemy Driver
There is good news and there is bad news:

### The good news
A driver exists!
* It can be found here: [SQLAlchemy-Pervasive](https://github.com/SacNaturalFoods/sqlalchemy-pervasive)
* Although in early development stage and far from complete feature wise some quick tests show it does what it needs to do properly.
Further testing (and hopefully development and support!) required! As always: use at own risk.

### The bad news
Driver development seems to have ceased six years ago although someone seemed to be eager to continue.
Another bad thing is that only basic calls are implemented, but for instance querying the driver for its capabilities does not work as that code is not implemented.
Unfortunately for this reason the driver does not work nicely with [Alembic](https://alembic.sqlalchemy.org/). 
It would be great if someone (Actian?) could endorse this project as is probably the best way to access the database from Python.


