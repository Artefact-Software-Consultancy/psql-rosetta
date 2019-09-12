# Java

When using Java to access Pervasive.SQL data the following Database Access Methods spring to mind:
* Btrieve API
* Btrieve 2 API
* JDBC
* JDBC-ODBC bridge: deprecated / no longer available in modern JDKs
* JCL (Java Class Library)
Exotics (if even possible):
* OLEDB : wrapping a Microsoft technique into Java which will only work under Windows

I will only look into the more common Access Methods.

## Btrieve API
https://docs.actian.com/psql/psqlv13/#page/btrieveapi%2Fbtrieveapi.About_This_Manual.htm%23

## Btrieve 2 API
https://docs.actian.com/psql/psqlv13/#page/btrieve2api%2Fbtrieve2api.htm%23
There is no native API for Java. In theory this can be fixed by composing a SWIG wrapper definition for Java.
This is quite an effort so waiting for a native API while developing code based on the Btrieve 1 API is appealing.
Once fully developed as a Btrieve 1 API application the need to rewrite it using the Btrieve 2 API might well be no longer desirable.
Given this picture I will not develop a SWIG interface wrapper.

## JDBC
https://docs.actian.com/psql/psqlv13/#page/jdbc%2Fjdbc.About_This_Manual.htm%23
A short example showing how to connect to an existing DB is usefull.
Developing a more complex example is not as it is already evailable in the SDK: Java Video Store

### JSP
JSP (Java Server Pages). An example is included in the SDK. Under the hood it uses JDBC.
See the pvideo.jsp code.

## JDBC-ODBC bridge
https://docs.oracle.com/javase/7/docs/technotes/guides/jdbc/bridge.html
So: as of JDK 8 this option is no longer available.

## Java Class Library
https://docs.actian.com/psql/psqlv13/#page/jcl%2Fjcl.About_This_Manual.htm%23
The documentation mentions Tightly-Coupled database which in practice seems a database with metadata (DDF files) ment to be used using SQL.
The alternative is a Loosly-Coupled Database where DDF files are not mandatory. Yet the documentation tries to sell you a migration to DDFs and transform your code to SQL.
Seems only an issue if you are migrating from an existing database. Yet SQL (relational model) is a very different ballgame compared to Btrieve (navigational model).
See also: https://docs.actian.com/psql/psqlv13/index.html#page/jcl%2Fjavintro.htm%23
This method puzzles me a bit. Why have an alternative to JDBC? There can be only two answers to that: speed and the usage of a different model. The last one the seems the more obvious answer and indeed is named as such in above link. However again a reference is made to the Video Store Java Sample Application and within that one sees not only a JDBC binding, but also some SQL. Nothing like low level Btrieve calls like (C code):
status = BTRVID(B_VERSION, posBlock1, &versionBuffer, &dataLen, keyBuf1, keyNum, (BTI_BUFFER_PTR) &clientID);
Although I must admit, not entiry true: this class library is something in the middle of JDBC/SQL and Btrieve. I would suggest skipping it and go for JDBC.


