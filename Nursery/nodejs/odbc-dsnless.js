#!/usr/bin/env nodejs
// tested on Debian using external NodeJS repo with NodeJS 10.0

const odbc = require('odbc');

// Driver : on Linux check with odbcinst -q -d
// const connectionString = "DRIVER={FreeTDS};SERVER=host;UID=user;PWD=password;DATABASE=dbname";
// const connectionString = 'Driver=PervasiveSQL;ServerName=localhost;dbq=@demodata;';
var connectionString = `${process.env.CONNECTION_STRING}`; // must be set in shell script calling this code

const queryString = 'SELECT COUNT(*) FROM PERSON';

console.log('About to make a DSN-less ODBC connection using the following connection-string: %s', connectionString); 

// const connection = odbc.connect(connectionString, (error, connection) => {
const connection = odbc.connect(`${process.env.CONNECTION_STRING}`, (error, connection) => {
    if (error) { console.error(error) }
    connection.query(queryString, (error, result) => {
	if (error) { console.error(error) }
	console.log('Result of query: %s :', queryString);
	var personcount = result[0];
	console.log(personcount);
    });
connection.close();
});


