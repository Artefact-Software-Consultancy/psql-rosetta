#!/bin/bash

LNPARAMS="-s -i -v"

MYDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# directories
SWIGMAN=swig/manual
SWIGDU=swig/distutils
BTRSDK=$MYDIR/sdk

# files : btrieveC.h  btrieveCpp.h  btrievePython.swig  btrieveSwig.swig

# facilitate SWIG manual method
ln $LNPARAMS $BTRSDK/btrieveC.h $SWIGMAN/btrieveC.h
ln $LNPARAMS $BTRSDK/btrieveCpp.h $SWIGMAN/btrieveCpp.h
ln $LNPARAMS $BTRSDK/btrievePython.swig $SWIGMAN/btrievePython.swig
ln $LNPARAMS $BTRSDK/btrieveSwig.swig $SWIGMAN/btrieveSwig.swig

# facilitate SWIG distutils method
ln $LNPARAMS $BTRSDK/btrieveC.h $SWIGDU/btrieveC.h
ln $LNPARAMS $BTRSDK/btrieveCpp.h $SWIGDU/btrieveCpp.h
ln $LNPARAMS $BTRSDK/btrievePython.swig $SWIGDU/btrievePython.swig
ln $LNPARAMS $BTRSDK/btrieveSwig.swig $SWIGDU/btrieveSwig.swig


# test scripts
ln $LNPARAMS $MYDIR/test/linda.py $SWIGMAN/linda.py
ln $LNPARAMS $MYDIR/test/linda.py $SWIGDU/linda.py
