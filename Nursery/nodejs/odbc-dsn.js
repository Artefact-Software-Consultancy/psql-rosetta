#!/usr/bin/env nodejs
// tested on Debian using external NodeJS repo with NodeJS 10.0

const odbc = require('odbc');

// Driver : on Linux check with odbcinst -q -d
// DataSource : on Linux check with odbcinst -q -s
 const connectionString = 'DSN=demodata';
//var connectionString = 'DSN=' + `${process.env.CONNECTION_STRING}`; // must be set in shell script calling this code

const connectionTimeout = 10;
const loginTimeout = 10;
var odbcUser = '';
var odbcPass = '';

const queryString = 'SELECT COUNT(*) FROM PERSON';

console.log('About to make a DSN-based ODBC connection using the following connection-string/DSN: %s', connectionString); 

// only usefull in async function
var connectionConfig = {
    connectionString: connectionString,
    connectionTimout: 10,
    loginTimout: 10,
}

const connection = odbc.connect(connectionString, (error, connection) => {
    if (error) { console.error(error) }
    connection.query(queryString, (error, result) => {
	if (error) { console.error(error) }
	console.log('Result of query: %s :', queryString);
	var personcount = result[0];
	console.log(personcount);
    });
connection.close();
});


