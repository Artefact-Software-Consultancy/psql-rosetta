#!/bin/bash
# as this is a new shell all settings will NOT
# be available outside it! Keeping things nice and tidy.

# so better 'source' the instead!

# insprired by my Makefile for the Btrieve2 API examples
LD_FLAGS="-lpsqlmif -lbtrieveC"
LDPP_FLAGS="-lbtrieveCpp -lbtrieveC"
C_FLAGS="-O2 -Wall -c"
CXX_FLAGS="-Wall -Wextra -c"
# now be somewhat dynamic as in the Makefile
if [ -z ${PVSW_ROOT} ]; then
    PVSW_ROOT="/usr/local/psql"
    echo "PVSW_ROOT environment var was not set. However I can continue using $PVSW_ROOT"
fi
OSNAME=$(uname -s)
OSARCH=$(uname -m)
if [ "$OSNAME" == "Linux" ]; then
    if [ "$OSARCH" == "x86_64" ]; then
                C_FLAGS+=" -DBTI_LINUX_64"
                LD_FLAGS+=" -L$PVSW_ROOT/lib64"
                #LD_FLAGS+=" -R$PVSW_ROOT/lib64"

                CXX_FLAGS+=" -DBTI_LINUX_64"
                LDPP_FLAGS+=" -L$PVSW_ROOT/lib64"
                #LDPP_FLAGS+=" -R$PVSW_ROOT/lib64"
    else
                if [ "$OSARCH" == "aarch64" ]; then
                        C_FLAGS+=" -DBTI_LINUX_64"
                        LD_FLAGS+=" -L$PVSW_ROOT/lib64"
                        #LD_FLAGS+=" -R$PVSW_ROOT/lib64"

                        CXX_FLAGS+=" -DBTI_LINUX_64"
                        LDPP_FLAGS+=" -L$PVSW_ROOT/lib64"
                        #LDPP_FLAGS+=" -R$PVSW_ROOT/lib64"
                else
                        C_FLAGS+=" -DBTI_LINUX"
                        LD_FLAGS+=" -L$PVSW_ROOT/lib"
                        #LD_FLAGS+=" -R$PVSW_ROOT/lib"

                        CXX_FLAGS+=" -DBTI_LINUX"
                        LDPP_FLAGS+=" -L$PVSW_ROOT/lib"
                        #LDPP_FLAGS+=" -R$PVSW_ROOT/lib"
                fi
    fi
else
    C_FLAGS+=" -DBTI_MACOSX_64"
    LD_FLAGS+=" -L$PVSW_ROOT/lib64"
    #LD_FLAGS+=" -R$PVSW_ROOT/lib64"

    CXX_FLAGS+=" -DBTI_MACOSX_64"
    LDPP_FLAGS+=" -L$PVSW_ROOT/lib64"
    #LDPP_FLAGS+=" -R$PVSW_ROOT/lib64"
fi

# Debugging purposes:
#echo "OSNAME     : $OSNAME"
#echo "OSARCH     : $OSARCH"
#echo "PVSW_ROOT  : $PVSW_ROOT"
#echo "C_FLAGS    : $C_FLAGS"
#echo "CXX_FLAGS  : $CXX_FLAGS"
#echo "LD_FLAGS   : $LD_FLAGS"
#echo "LDPP_FLAGS : $LDPP_FLAGS"
#exit

