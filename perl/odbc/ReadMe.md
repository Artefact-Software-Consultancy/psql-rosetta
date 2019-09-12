# Accessing data using ODBC from Perl

## Native
Two libraries exist with which in theory this could be achieved.
However it is highly recommended not to take this route, but to have a look at DBI
* [UnixODBC : ODBC on Linux using Perl](https://metacpan.org/pod/UnixODBC)
* [Win32::ODBC : ODBC on Windows using Perl](https://www.foo.be/docs/tpj/issues/vol3_1/tpj0301-0008.html)

## DBI
[Perl's Database Interface](https://dbi.perl.org/) is the preferred way to access databases.
An example using ODBC both DSN bases as well as DSN-less are included in the repository.
