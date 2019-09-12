# Data access using the Btrieve API from Perl

Summer 2019 no native Btrieve API access for/from PHP is available from Actian.

Theoretical alternatives:
- Btrieve2 API
- other type of data access such as ODBC (transactional (SQL), not navigational (noSQL))
- Investigate availability of third-party solutions

A third party solution exists. It is opensource but looks like it is accessing datafiles directly.
You do not want that. Most likely this will lead to data corruption especially with newer versions of Pervasive.SQL
