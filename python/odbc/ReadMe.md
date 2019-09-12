# Data access method ODBC using Python

All (?) options are listed in the [Python Wiki subject ODBC](https://wiki.python.org/moin/ODBC)

## PyODBC
The most common used implementation is [PyODBC](https://github.com/mkleehammer/pyodbc).
Both DSN and DSN-less are covered by examples in this repository.

## SQLAlchemy
A more interesting approach is the higher level SQLAlchemy library: [SQLAlchemy](https://www.sqlalchemy.org/)
To be able to use SQLAlchemy a database specific driver is required.
Or alternatively

### Alembic
On top of that the use of Alembic is quite interesting. [Alembic](https://alembic.sqlalchemy.org/)
one thing to note here is that the driver must support this.

### ODBC
Besided a native driver one can also resort to using ODBC.
Both a DSN and a DSN-less script have been added to this repository to show how to access Pervasive.SQL

