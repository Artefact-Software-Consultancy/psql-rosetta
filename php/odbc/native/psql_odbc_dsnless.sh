#!/usr/bin/env php

# DSN-less ODBC connection

# https://www.connectionstrings.com/pervasive
# Driver={Pervasive ODBC Client Interface};ServerName=myServerAddress;dbq=@dbname;

<?php

$dsn="demodata";
$dbuser="";
$dbpass="";

# Raspbian, see:
#  odbcinst -q -d -l
#  odbcinst -q -s -l
# but more importantly: /usr/local/psql/etc/odbcinst.ini
$dbconnstr = "Driver={/usr/local/psql/lib/libodbcci.so};ServerName=localhost;dbq=@demodata;";
#$dbconnstr = "Driver={Pervasive ODBC Interface};ServerName=localhost;dbq=@demodata;";
$dsn = $dbconnstr;

// See: https://docs.actian.com/psql/psqlv13/index.html#page/getstart%2Funixappconf.htm

set_error_handler(function($errno, $errstr, $errfile, $errline) {
    throw new ErrorException($errstr, $errno, 0, $errfile, $errline);
});

// connect to Demodata database no uid or password
try {
    $connect = odbc_connect($dsn, $dbuser, $dbpass);
    //$connect = odbc_connect($dbconnstr);
}
catch (Exception $e) {
    echo "Unable to connect to DSN: " . $dsn . PHP_EOL;
    echo "Exception: " . $e->getMessage() . PHP_EOL;
    exit(1);
}

// set the query variable to your SQL
//$query = "SELECT * FROM Department";
$query = "SELECT * FROM Dept";

// obtain a result object for your query
try {
    $result = odbc_exec($connect, $query);
}
catch (Exception $e) {
    echo "Unable to execute query: " . $query . PHP_EOL;
    echo "Exception: " . $e->getMessage() . PHP_EOL;
    exit(1);
}
echo "Successful access to DSN " . $dsn . PHP_EOL;
?>
