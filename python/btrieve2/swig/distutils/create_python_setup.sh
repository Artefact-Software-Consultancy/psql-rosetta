#!/bin/bash

if (( $# < 1 ))
then
    PSQL_PYTHONSETUP='psqlsetup.py'
else
    if (( $# == 1))
    then
	PSQL_PYTHONSETUP=$1
    else
	echo "Max of 1 parameter is expected. Exiting."
	exit 1
    fi
fi

if [ -f $PSQL_PYTHONSETUP ]
then
    echo "File $PSQL_PYTHONSETUP already exists."
    echo "Pleaserm file before I can recreate it."
    exit 1
fi

ARCHITECTURE=$(lscpu | grep Architecture | cut -d":" -f2 | xargs)
# should be something like x86_32 or x86_64 or armv71
echo "Architecture: $ARCHITECTURE"

if [ "$ARCHITECTURE" == "x86_64" ]
then
    PSQL_LIBRARY=/usr/local/psql/lib64
else
    PSQL_LIBRARY=/usr/local/psql/lib
fi

PSQL_RUNTIME=$PSQL_LIBRARY

# check if these exist. If not: exit with errorcode
if [ ! -d $PSQL_LIBRARY ]
then
    echo "Requirement of Actian PervasiveSQL library directory not met."
    echo "Directory $PSQL_LIBRARY does not exist."
    exit 1
fi
if [ ! -d $PSQL_RUNTIME ]
then
    echo "Requirement of Actian Pervasive.SQL runtime library directory not met."
    echo "Directory $PSQL_RUNTIME does not exist."
    exit 1
fi

if [ -f $PSQL_PYTHONSETUP ]
then
    rm -f $PSQL_PYTHONSETUP
fi

cat <<EOF >> $PSQL_PYTHONSETUP
#!/usr/bin/env python3
from distutils.core import setup, Extension
btrievePython_module = Extension('_btrievePython',
         sources=['btrievePython_wrap.cxx'],
         library_dirs=['$PSQL_LIBRARY'],
         runtime_library_dirs=['$PSQL_RUNTIME'],
         libraries=['btrieveCpp'] )
setup (name='btrievePython',
         version='1.0',
         author='Actian',
         description="""Compile Btrieve 2 Python module""",
         ext_modules=[btrievePython_module],
         py_modules=["btrievePython"], )

EOF

chmod +x $PSQL_PYTHONSETUP
