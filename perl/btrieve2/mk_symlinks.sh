#!/bin/bash

LNPARAMS="-s -i -v"

MYDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# directories
SWIGDIR=swig
BTRSDK=$MYDIR/sdk

# files : btrieveC.h  btrieveCpp.h  btrievePhp.swig  btrieveSwig.swig

# facilitate SWIG manual method
ln $LNPARAMS $BTRSDK/btrieveC.h $SWIGDIR/btrieveC.h
ln $LNPARAMS $BTRSDK/btrieveCpp.h $SWIGDIR/btrieveCpp.h
ln $LNPARAMS $BTRSDK/btrievePerl.swig $SWIGDIR/btrievePerl.swig
ln $LNPARAMS $BTRSDK/btrieveSwig.swig $SWIGDIR/btrieveSwig.swig

# test scripts
ln $LNPARAMS $MYDIR/test/olaf.pl $SWIGDIR/olaf.pl

