#!/bin/bash
#source /home/pi/psql_code_rosetta/python/various/psqlenv.sh
#source ../../../tools/pyenv.sh
source ../../../tools/pvsw_env.sh
echo "Script to build Swig wrapper for Btrieve2 API for PHP"
echo "Method: manual"

# check out the docs: http://swig.org/Doc3.0/SWIGDocumentation.html#Php_nn1
# WARNING: my SWIG 3.0 did not support -php7
# php7 : resulting file is called : btrievePhp_wrap.cxx
# php5 : resulting file is called : btrievePhp_wrap.cpp

# receipe according to swig docs:
# swig -python example.i
# gcc `php-config --includes` -fpic -c example_wrap.c example.c
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

declare -a REQUIRED=("btrieveC.h" "btrieveCpp.h" "btrievePhp.swig" "btrieveSwig.swig")
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
# Debian/Raspbian Stretch : -php is the only option available
# Debian/Raspbian Buster: -php5 or -php7 can be used: php5 is deprecated as of January 2019, so -php7 it is!
#sudo swig -c++ -D__linux__ -php btrievePhp.swig
swig -c++ -D__linux__ -php7 btrievePhp.swig

REQMET=0
#declare -a RESULT=("btrievePhp.php" "btrievePhp_wrap.cpp") # php5
declare -a RESULT=("btrievePhp.php" "btrievePhp_wrap.cxx") # php7
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
#gcc `php-config --includes` -fPIC $CXX_FLAGS -shared -c btrievePhp_wrap.cpp -o btrievePhp_wrap.o --verbose
gcc `php-config --includes` -fPIC $CXX_FLAGS -shared -c btrievePhp_wrap.cxx -o btrievePhp_wrap.o --verbose

echo "Let's build (phase #3) : "
g++  -shared $LDPP_FLAGS `php-config --ldflags` -lbtrieveCpp btrievePhp_wrap.o -o btrievePhp.so
# --verbose

#g++ `python3-config --cflags` -fpic -c btrievePython_wrap.cxx btrieveCpp.h -L /usr/local/psql/lib -l btrieveCpp
##g++ -L /usr/local/psql/lib/ -l btrieveCpp -shared btrievePython_wrap.o -o _btrievePython.so
#g++ -shared btrievePython_wrap.o -L /usr/local/psql/lib -l btrieveCpp -l stdc++  -o _btrievePython.so


if [ ! -e btrieve*.so ]
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



