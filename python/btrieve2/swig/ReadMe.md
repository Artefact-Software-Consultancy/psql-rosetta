# Btrieve 2 API using Python with the aid of SWIG

SWIG: http://swig.org/Doc3.0/Python.html

Actian provides in the Btrieve2 API SDK:
* header files for C/C++
* SWIG interface files (1 generic one and 1 Python specific one)

Copy these 4 files into the SDK subdirectory next to the one where this ReadMe.md file resides.

As can be read in the SWIG documentation: 2 methods of building the SWIG wrappers can be used when compiling for Python:
* the regular SWIG build method : http://swig.org/Doc3.0/Python.html#Python_nn7
* the 'distutils' method : http://swig.org/Doc3.0/Python.html#Python_nn6

To faciliate the building process for Linux I have written 2 scripts which perform all actions needed.
With some luck these will also run on MacOSX. (untested)
Windows will take some further work to automate and test.

