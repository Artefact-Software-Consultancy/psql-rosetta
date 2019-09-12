# Data access using Btrieve API 2 from PHP

In this directory 4 subdirectories can be found as well as a bash script.

## mk_symlinks.sh
script to build this directory structure. Provides symlinks to SDK components and test scripts.

## sdk
Subdirectory into which the following files from the BtrieveAPI2 SDK need to be copied:
* btrieveC.h : C header file Btrieve API 2
* btrieveCpp.h : C++ header file Btrieve API 2
* btrieveSwig.swig : generic SWIG interface file for Btrieve API 2
* btrievePhp.swig : PHP specific SWIG interface file for Btrieve API 2

## native
Subdirectory for native Btrieve API 2 access using PHP. Spoiler alert: do not hold your breath.

## test
Subdirectory with test script(s). Script is an adapted port of a Python testscript written by Linda Anderson (Actian) with some lines of Bill Bach (Goldstar Software)

## swig
Subdirectory with generator script to build the SWIG wrapper module.

