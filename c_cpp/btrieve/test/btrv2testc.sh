#!/bin/bash

PSQLTESTURI="btrv://localhost/demodata" # see databaseURI in PSQL docs Microkernel fundamentals
PSQLTESTFILE="/usr/local/psql/data/samples/sample.btr"
PSQLTESTPATH="/home/pi/psql_code_rosetta/c_cpp/btrieve2/actian"
PSQLTESTDIGIT=2

# see: https://stackoverflow.com/questions/192249/how-do-i-parse-command-line-arguments-in-bash
# see: http://docs.actian.com/psql/btrieve2v13/html/examples.html
# see: https://docs.actian.com/psql/PSQLv13/index.html#page/prog_gde/fundmnts.htm#ww61463

checkfile(){
    if [ ! -f $1 ]; then
        echo "File $1 not found!"
        exit 1
    fi
}

btst() {
    MYT=$1
	if [ $# -le 2 ]; then
		# handle defaults
		case "$MYT" in
			bfileinformation)
				MYP=$PSQLTESTFILE
				;;
			bfilter)
				MYP=$PSQLTESTDIGIT
				;;
			bkeyonly)
				MYP=$PSQLTESTDIGIT
				;;
			bpercentage)
				echo ">>> $MYT crashes the engine on my system... <<<"
				MYT=block  # need to pass this without further fuss
				;;
			btest)
				MYP=$PSQLTESTDIGIT
				;;
			btest++)
				MYP=$PSQLTESTDIGIT
				;;
			btestappend)
				MYP=$PSQLTESTDIGIT
				;;
			btestbulk)
				MYP=$PSQLTESTDIGIT
				;;
			btestchunk)
				MYP=$PSQLTESTDIGIT
				;;
			btestvlr)
				MYP=$PSQLTESTDIGIT
				;;
			bversion)
				MYP=$PSQLTESTURI
				;;
			*)
				MYP=""
				;;
		esac
		if [ ! -z "$MYP" -a "$MYP" != " " ]; then
			echo "Missing required argument(s)."
			echo "Processing with default(s): $MYP"
		fi
	else
		MYP=$2
	fi
    echo " *** Performing test: $MYT ***"
    checkfile $PSQLTESTPATH/$MYT
    $PSQLTESTPATH/$MYT $MYP
}

display_help() {
    echo "Usage: $(basename "$0") [-h] [-a] | [-t] <argument>"
    echo "      --help            : this message"
    echo "      --all             : execute all tests"
    echo "      --test <argument> : the requered test with optional argument(s) if required"
    echo "                          when no requirement argument is given,"
    echo "                          this is reported and a default one is used."
    echo "      Possible (non intrusive) tests are:"
    for i in "${btsts[@]}"
    do
        echo "      $i"
    done
    echo "When permission errors occur consider using a writable directory like /tmp to start this script from."
    echo
}

test_all() {
    for i in "${btsts[@]}"
    do
		btst $i
    done
}

btsts=("bfileattributes" "bfileinformation" "bfilter" "bindexattributes" "bkeyonly" "block" "bpercentage" "btest" "btest++" "btestappend" "btestbulk" "btestchunk" "btestvlr" "bversion")

# main


# saner programming env: these switches turn some bugs into errors
set -o errexit -o pipefail -o noclobber -o nounset

# -allow a command to fail with !’s side effect on errexit
# -use return value from ${PIPESTATUS[0]}, because ! hosed $?
! getopt --test > /dev/null 
if [[ ${PIPESTATUS[0]} -ne 4 ]]; then
    echo 'I’m sorry, `getopt --test` failed in this environment.'
    exit 1
fi

OPTIONS=hat
LONGOPTS=help,all,test

# -regarding ! and PIPESTATUS see above
# -temporarily store output to be able to check for errors
# -activate quoting/enhanced mode (e.g. by writing out “--options”)
# -pass arguments only via   -- "$@"   to separate them correctly
! PARSED=$(getopt --options=$OPTIONS --longoptions=$LONGOPTS --name "$0" -- "$@")
if [[ ${PIPESTATUS[0]} -ne 0 ]]; then
    # e.g. return value is 1
    #  then getopt has complained about wrong arguments to stdout
    exit 2
fi
# read getopt’s output this way to handle the quoting right:
eval set -- "$PARSED"

#d=n f=n v=n outFile=-
# now enjoy the options in order and nicely split until we see --
while true; do
    case "$1" in
        -h|--help)
            display_help
            shift
            ;;
        -a|--all)
            # perform all test
            test_all
            shift
            ;;
        -t|--test)
            REQTST=$3
            if [ $# -le 4 ]; then
				TSTARG=""
			else
				TSTARG=$4
			fi
            if [[ "${btsts[@]} " =~ $REQTST ]]; then
                # test is available
                # consider 'case/esac' to facilitate default options
                btst $REQTST $TSTARG
            else
                echo "Requested test \"$REQTST\" is not available"
            fi
            shift
            ;;
        *)
			display_help
			break
			;;
        --)
            shift
            break
            ;;
        *)
            echo "Something is seriously wrong"
            exit 3
            ;;
    esac
done

# handle non-option arguments
#if [[ $# -ne 1 ]]; then
#    echo "$0: A single argument is required."
#    exit 4
#fi

#echo "verbose: $v, force: $f, debug: $d, in: $1, out: $outFile"
