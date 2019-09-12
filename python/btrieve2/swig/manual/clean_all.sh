#!/bin/bash
echo ">>> WARNING : about to wipe all generated files! <<<"
rm -i *.so
rm -i *.o
rm -i *.cxx
echo "Also wiping temporary build directories:"
rm -I -r build
rm -I -r __pycache__
rm -i btrievePython.py*


