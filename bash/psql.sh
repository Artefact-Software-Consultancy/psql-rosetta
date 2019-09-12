#!/bin/bash

# https://docs.actian.com/psql/psqlv13/index.html#page/uguide%2Fuguide.Command_Line_Interface_Utilities.htm%23

# https://docs.actian.com/psql/psqlv13/index.html#page/uguide/uguide.isql.htm

# /usr/bin/isql and /usr/local/psql/bin/isql are not binary identical
# one is part of the unixodbc package, the other is part of Pervasive.SQL
MYISQL='/usr/local/psql/bin/isql' # or 'isql64'

MYDSN='demodata'

MYSCRIPT='psqltest.sql'

cat $MYSCRIPT | $MYISQL $MYDSN -b
