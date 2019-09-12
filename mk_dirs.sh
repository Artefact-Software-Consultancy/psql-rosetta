#!/bin/bash

display_usage() {
    echo "This script creates a directory tree of database access methods."
    echo "It requires a single parameter specifying the programming language."
    echo -e "\nUsage:\n $0 [argument] \n"
}

if [ "$#" -ne 1 ]
then
    display_usage
    exit 1
fi
if [ "$#" == "--help" ] || [ "$#" == "-h" ]
then
    display_usage
    exit 0
fi

echo "Now creating a directory structure for language $1"
echo "based on 'Overview of PSQL Access Methods'."
echo "See: https://docs.actian.com/psql/psqlv13/#page/prog_gde%2Facc_mthd.htm%23"
mkdir -p ./$1/btrieve
mkdir -p ./$1/btrieve2/native
mkdir -p ./$1/btrieve2/swig
mkdir -p ./$1/btrieve2/sdk
mkdir -p ./$1/btrieve2/test
mkdir -p ./$1/sql
mkdir -p ./$1/odbc
mkdir -p ./$1/ado.net
mkdir -p ./$1/jdbc
mkdir -p ./$1/jpa
mkdir -p ./$1/java
mkdir -p ./$1/pdac
mkdir -p ./$1/oledb
mkdir -p ./$1/activex
mkdir -p ./$1/dti
mkdir -p ./$1/dto
echo ""
