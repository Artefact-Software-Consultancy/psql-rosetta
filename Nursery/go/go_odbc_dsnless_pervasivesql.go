package main

import (
//  "os"
  "fmt" 
//  "regexp"

//  "database/sql" 
  "github.com/jmoiron/sqlx"
  _ "github.com/alexbrainman/odbc"
  "github.com/sirupsen/logrus"
//  _ "driver"
)

// https://www.connectionstrings.com/pervasive
// Driver={Pervasive ODBC Client Interface};ServerName=myServerAddress;dbq=@dbname;
//  "Driver={/usr/local/psql/lib/libodbcci.so};ServerName=localhost;dbq=@demodata;"
//const cs = "Driver={/usr/local/psql/lib64/libodbcci.so};ServerName=localhost;dbq=@demodata;"
const cs = "Driver={PervasiveSQL};ServerName=localhost;dbq=@demodata;"

const qry = "SELECT COUNT(*) FROM Person"

var log = logrus.New()

var count int

func main() {

  fmt.Println("Go example code for connecting to a Pervasive.SQL database using ODBC without a DSN\n")
  fmt.Println("Using Connection string:", cs)

  db, err := sqlx.Open("odbc", cs)
  if err != nil {
    fmt.Println("Connection Failed : ", err)
    log.Fatal(err)
  } else {
    fmt.Println("Successful connection")
  }

  result, err := db.Query(qry)
  if err != nil {
    fmt.Println("Unable to execute query : ", err)
  } else {
    fmt.Println("Executed query: ", qry) 
  }

  // Parse results
  defer result.Close()
  for result.Next() {
    //var row string
    //if err := result.Scan(&row); err != nil {
    if err := result.Scan(&count); err != nil {
      log.Fatal(err)
      //fmt.Println("%s\n", row)
    } else {
      fmt.Println("Number of persons in table: \n", count)
    }
  }

  if err := result.Err(); err != nil {
    log.Fatal(err)
  }

  // Close the connection
  fmt.Println("Closing the database connection")
  defer db.Close()
}
