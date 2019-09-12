#!/bin/bash
echo ">>> WARNING : about to wipe all generated files! <<<"
rm -i *.so
rm -i *.o
rm -i *.cpp
echo "Also wiping temporary build directories:"
rm -I -r build
rm -i btrievePhp.py*


