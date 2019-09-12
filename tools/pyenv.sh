#!/bin/bash

# source this
if [[ "$(basename -- "$0")" == "psqlenv.sh" ]]; then
    echo "Don't run $0, source it instead!" >&2
    #exit 1
fi

# function to get Python version
# python --version --> regex/cut
function get_python_version() {
    eval "$1=$(python -c 'import sys; print(".".join(map(str, sys.version_info[:2])))')"
}

# function to get Python path
# https://stackoverflow.com/questions/16269903/how-to-get-the-pythonpath-in-shell
# python -c "import sys; print(':'.join(x for x in sys.path if x))"
function get_python_path() {
    eval "$1=$(python -c "import sys; print(':'.join(x for x in sys.path if x))")"
}

# function to get Python include
# https://stackoverflow.com/questions/35071192/how-to-find-out-where-the-python-include-directory-is
# python-config --includes
function get_python_includes() {
    eval "$1=$(python -c "from sysconfig import get_paths as gp; print(gp()['include'])")"
}

PV=''
get_python_version PV
echo "Python version: $PV"

PP=''
get_python_path PP
echo "Python path: $PP"

PI=''
get_python_includes PI
echo "Python includes: $PI"
