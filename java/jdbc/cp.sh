#!/usr/bin/bash
# better to source

# see: https://docs.actian.com/psql/psqlv13/jdbc/jdbctasks.htm#ww82748
#      (How to Set Up your Environment)

PSQL_LIB=/usr/local/psql/lib

export CLASSPATH=$CLASSPATH:$PSQL_LIB/pvjdbc2.jar
export CLASSPATH=$CLASSPATH:$PSQL_LIB/pvjdbc2x.jar
export CLASSPATH=$CLASSPATH:$PSQL_LIB/jpscs.jar

