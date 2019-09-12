#!/usr/bin/env php

# DSN-less ODBC connection using PDO

# https://www.connectionstrings.com/pervasive
# Driver={Pervasive ODBC Client Interface};ServerName=myServerAddress;dbq=@dbname;

<?php

$dsn="demodata";
$dbname="demodata";
$dbhost="localhost";
$dbuser="";
$dbpass="";

// See: https://docs.actian.com/psql/psqlv13/index.html#page/getstart%2Funixappconf.htm

//print_r(PDO::getAvailableDrivers());

set_error_handler(function($errno, $errstr, $errfile, $errline) {
    throw new ErrorException($errstr, $errno, 0, $errfile, $errline);
});

// connect to Demodata database no uid or password
// connection should match driver as found in /usr/local/psql/etc/odbcinst.ini
// see also: 
try {

    $dbconnstr = "Driver={/usr/local/psql/lib/libodbcci.so};ServerName=localhost;dbq=@demodata;";
    $connstr = "odbc:" . $dbconnstr;  
    //$connect = new PDO($connstr, $dbuser, $dbpass);
    $connect = new PDO($connstr);
}
catch (Exception $e) {
    echo "Unable to connect to DSN: " . $dsn . PHP_EOL;
    echo "Error: " . $e->getMessage() . PHP_EOL;
    exit(1);
}

// set the query variable to your SQL
//$query = "SELECT * FROM Department";
$query = "SELECT * FROM Dept";

// obtain a result object for your query
try {
    //$result = odbc_exec($connect, $query);
    $connect->query($query);
}
catch (Exception $e) {
    echo "Unable to execute query: " . $query . PHP_EOL;
    echo "Exception: " . $e->getMessage() . PHP_EOL;
    exit(1);
}
echo "Successful access to DSN " . $dsn . PHP_EOL;
?>
