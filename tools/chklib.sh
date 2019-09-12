#!/bin/bash

display_usage() {
    echo "Perform some simple test on a wrapped module."
    echo "Requires as an argument the full path & name of the binary module."
    echo -e "\nUsage: $0 <binary library> \n"
}

test_exists() {
    if [ -f "$1" ]
    then
	echo "Found $1 so we can commence testing."
    else
	echo "Could not find: $1"
	exit 1
    fi
}

test_ldd() {
    ldd $1
}

provide_sums() {
    SUMMD5=`md5sum $1`
    SUMSHA256=`sha256sum $1`

    echo "md5sum : $SUMMD5"
    echo "sha256 : $SUMSHA256"
}

test_filt() {
    c++filt "$1"
}

test_preload() {
    # see: https://stackoverflow.com/questions/15648781/how-to-make-dlerror-report-all-unresolved-symbols-from-dlopen-failure-to-l
    #export LD_BIND_NOW=1
    #export LD_WARN=1
    #export LD_TRACE_LOADED_OBJECTS=1
    #export LD_PRELOAD=$1
    ldd -r "$1"
}

# Main

if [ $# -ne 1 ]
then
    display_usage
    exit 1
fi

if [[ ( $# == "--help" ) || ( $# == "-h" ) ]]
then
    display_usage
    exit 0
fi

MYLIB="$1"
test_exists $MYLIB
provide_sums $MYLIB
test_preload $MYLIB

echo "Finished testing $MYLIB"
echo ""
