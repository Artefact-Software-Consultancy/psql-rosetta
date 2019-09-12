#!/usr/bin/env php
<?php

$dsn="demodata";
$dbuser="";
$dbpass="";

// See: https://docs.actian.com/psql/psqlv13/index.html#page/getstart%2Funixappconf.htm

set_error_handler(function($errno, $errstr, $errfile, $errline) {
    throw new ErrorException($errstr, $errno, 0, $errfile, $errline);
});

// connect to Demodata database no uid or password
try {
    $connect = odbc_connect($dsn, $dbuser, $dbpass);
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
