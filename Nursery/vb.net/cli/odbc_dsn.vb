Imports System.Data.Odbc
Module Module1
    Sub Main()
	Dim conn As OdbcConnection
	Dim comm As OdbcCommand
	Dim dr As OdbcDataReader
	Dim connectionString As String
	Dim sql As String
	connectionString = "DSN=Demodata;"
	sql = "SELECT COUNT(*) FROM Person"
	console.writeline("This is a DSN based ODBC example")
	console.writeline("About to connect to the database using ConnectionString: " + connectionString)
	conn = New OdbcConnection(connectionString)
	conn.Open()
	console.writeline("About to execute query: " + sql)
	comm = New OdbcCommand(sql, conn)
	dr = comm.ExecuteReader()
	While (dr.Read())
		Console.WriteLine(dr.GetValue(0).ToString())
	End While
	conn.Close()
	dr.Close()
	comm.Dispose()
	conn.Dispose()
    End Sub
End Module
