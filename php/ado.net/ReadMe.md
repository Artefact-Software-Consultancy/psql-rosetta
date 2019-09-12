# Accessing data using Microsoft ADO from PHP

I found [ADOdb.org](http://adodb.org) which seems like an ORM and not su much like a direct ADO port at first glance.
Also Pervasive.SQL is not natively supported leaving ODBC as the only option. I would go for PDO instead.
But as COM can be used the conclusion is it can be done. However this is not tested with Pervasive.SQL
One of the reasons I do not feel the need to write POC code for this.

