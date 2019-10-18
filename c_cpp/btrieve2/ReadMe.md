# Btrieve API 2 access from C/C++
C and C++ are the best documented languages to access databases using the Btrieve API 2.
* [Btrieve 2 API] https://docs.actian.com/psql/psqlv13/index.html#page/btrieve2api/btrieve2api.htm
* [Getting Started with the Btrieve C++ and C API 2](https://docs.actian.com/psql/btrieve2v13/html/)

How to use it on Windows is documented in a [white paper Bill Bach from Goldstrar Software](http://www.goldstarsoftware.com/papers/AccessingZenFromCppOnWindows.pdf) 

## Alternative
In theory one could write a SWIG interface file to support accessing Pervasive.SQL using the Btrieve2 API from Ruby.
This has been done for PHP, Perl and Python. And as Java is also supported by SWIG...
But why would you if native access is available?

See: [SWIG documentation](http://swig.org/doc.html)

# Bugs
Currently (Actian Zen 14 (initial release) / Actian Pervasive.SQL 13) a bug exists which crashes the database engine.
It is known at Actian as bug PSQL-7166 and occurs when executing the [bpercentage example](https://docs.actian.com/psql/btrieve2v13/html/bpercentage_8cpp-example.html)
 
