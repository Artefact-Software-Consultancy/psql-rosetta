# Accessing a database using JDBC

This is the default way of using databases in Java. Plenty of examples and tuturials exist.
Nevertheless an example is provided:

## PSQLJDBCtest.java
The actual code. Compile as usual: javac PSQLJDBCtest.java
This will create the class file.
Can be easily expanded to support dynamic user authentication.

### Note
Sourcecode contains many comment lines with plenty of usefull URLs.

## PSQLJDBCtest.class
File generated from PSQLJDBCtest.java using a java compiler.
I used openjdk/jre 11.0.4

## cp.sh
Bash shell script to set the Classpath environment variables.
Do not run it. Source it instead.

## test.sh
Bash script which sources the classpath using cp.sh
Next it calls PSQLJDBCtest
See the source and (un)comment and adapt at will.
Without arguments it resorts to the defaults of:
* server : localhost
* database : demodata
Otherwise call PSQLJDBCtest <server> <database>
