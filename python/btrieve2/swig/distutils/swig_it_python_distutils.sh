#!/bin/bash
#source /home/pi/psql_code_rosetta/python/various/psqlenv.sh
source ../../../../tools/psqlenv.sh
echo "Script to build Swig wrapper for Btrieve2 API for Python"
echo "Method: distitils"

reqmet=0
# test for Swig
echo "Swig is obviously required"
if [ -e /usr/bin/swig ]
then
    echo "Swig requirement met!"
    ((reqmet++))
else
    echo "Swig requirement failed!"
fi

declare -a required=("btrieveC.h" "btrieveCpp.h" "btrievePython.swig" "btrieveSwig.swig")
for i in "${required[@]}"
do
    if  [ -e $i ]
    then
	echo "Requirement of existing $i is met"
	((reqmet++))
    else
	echo "Requirement mismatch. File $i could not be found";
    fi
done
if  [ "$reqmet" -ne 5 ]
then
    echo "Not all requirements are met. Cannot build."
    exit 1
fi

echo "Let's build (phase #1) :"
#sudo swig -c++ -D__linux__ -python btrievePython.swig
swig -c++ -D__linux__ -python btrievePython.swig

reqmet=0
declare -a result=("btrievePython.py" "btrievePython_wrap.cxx")
for i in "${result[@]}"
do
    if  [ -e $i ]
    then
	echo "File $i was indeed generated"
	((reqmet++))
    else
	echo "Something went wrong; file $i is missing (not generated)";
    fi
done

echo "Let's build (phase #2) : "
psqlsetup="psqlswigsetup.py" 
echo "Creating distutils SWIG setup file: $psqlsetup"
./create_python_setup.sh $psqlsetup
if [ ! -e $psqlsetup ]
then
    echo "Can not continue. Setup file was not created somehow!"
    exit 1
fi

echo "Let's build (phase #3)"
#sudo 
python3 $psqlsetup build_ext --inplace

if [ ! -e _btrieve*.so ]
then
    echo "Build process failed."
    exit 1
fi

# filename depends on architecture
bf=`ls _btrieve*.so |grep -m1 btrieve` # which fails with fancy ls options set in rc files
if [ -z $bf ]
then
    echo "An .so file was created, but I cannot find it!?!"
else
    echo "Renaming $bf to _btrievePython.so"
    mv $bf _btrievePython.so
fi