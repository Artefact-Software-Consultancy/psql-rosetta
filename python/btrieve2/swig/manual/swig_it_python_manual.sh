#!/bin/bash
#source /home/pi/psql_code_rosetta/python/various/psqlenv.sh
#source ../../../../tools/pyenv.sh
source ../../../../tools/pvsw_env.sh
echo "Script to build Swig wrapper for Btrieve2 API for Python"
echo "Method: manual"


# receipe according to swig docs:
# swig -python example.i
# gcc -c -fpic example.c example_wrap.c -I/usr/local/include/python2.0
# gcc -shared example.o example_wrap.o -o _example.so


REQMET=0
# test for Swig
echo "Swig is obviously required"
if [ -e /usr/bin/swig ]
then
    echo "Swig requirement met!"
    ((REQMET++))
else
    echo "Swig requirement failed!"
fi

declare -a REQUIRED=("btrieveC.h" "btrieveCpp.h" "btrievePython.swig" "btrieveSwig.swig")
for i in "${REQUIRED[@]}"
do
    if  [ -e $i ]
    then
	echo "Requirement of existing $i is met"
	((REQMET++))
    else
	echo "Requirement mismatch. File $i could not be found";
    fi
done
if  [ "$REQMET" -ne 5 ]
then
    echo "Not all requirements are met. Cannot build."
    exit 1
fi

echo "Let's build (phase #1) :"
#sudo swig -c++ -D__linux__ -python btrievePython.swig
swig -c++ -D__linux__ -python btrievePython.swig

REQMET=0
declare -a RESULT=("btrievePython.py" "btrievePython_wrap.cxx")
for i in "${RESULT[@]}"
do
    if  [ -e $i ]
    then
	echo "File $i was indeed generated"
	((REQMET++))
    else
	echo "Something went wrong; file $i is missing (not generated)";
    fi
done


echo "Let's build (phase #2) : "
gcc `python3-config --cflags` -fPIC $CXX_FLAGS -shared -c btrievePython_wrap.cxx -o btrievePython_wrap.o
# $LDD_FLAGS
# --verbose

echo "Let's build (phase #3) : "
g++ `python3-config --ldflags` -shared $LDPP_FLAGS -lbtrieveCpp btrievePython_wrap.o -o _btrievePython.so
# --verbose

#g++ `python3-config --cflags` -fpic -c btrievePython_wrap.cxx btrieveCpp.h -L /usr/local/psql/lib -l btrieveCpp
##g++ -L /usr/local/psql/lib/ -l btrieveCpp -shared btrievePython_wrap.o -o _btrievePython.so
#g++ -shared btrievePython_wrap.o -L /usr/local/psql/lib -l btrieveCpp -l stdc++  -o _btrievePython.so


if [ ! -e _btrieve*.so ]
then
    echo "Build process failed."
    exit 1
else
    echo "Build process ended succesfully."
fi

# filename depends on architecture
#bf=`ls _btrieve*.so |grep -m1 btrieve` # which fails with fancy ls options set in rc files
#if [ -z $bf ]
#then
#    echo "A .so file was created, but I cannot find it!?!"
#else
#    echo "Renaming $bf to _btrievePython.so"
#    mv $bf _btrievePython.so
#fi



