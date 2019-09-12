# PowerShell script to connect to (Remote) Actian Pervasive.SQL server
# using an existing DSN (beware of 32 vs 64 bit!):
# .\psODBCTest.ps1 raspi RaspiDemodata64 client
# remote server: raspi
# RaspiDemodata64: 64-bit System DSN (Driver: Pervasive ODBC Interface) on local Windows 10 64-bit Pro machine

param(
    [string]$PsqlServer="localhost",
    [string]$SqlCatalog="demodata",
    [String]$OdbcDriver="Pervasive ODBC Interface"
)
if ($OdbcDriver -Match "Unicode") { $OdbcDriver="Pervasive ODBC Unicode Interface" }
if ($OdbcDriver -Match "Client") { $OdbcDriver="Pervasive ODBC Client Interface" }
if ($Odbcdriver -Match "Server") { $OdbcDriver="Pervasive ODBC Server Interface"}

# Load assembly
[void]
[System.Reflection.Assembly]::LoadWithPartialName("Pervasive.Data.SqlClient")

$nobits =(Get-CimInstance -ClassName win32_operatingsystem).OSArchitecture
Write-Host "Running on $nobits Windows system"

# Setup some variables
$TaskName = "psODBCTest"

# ADO.NET
#$ConnString = "Server Name=$PsqlServer;Database Name=$SqlCatalog;"
# ODBC
#$ConnString = "Driver={$OdbcDriver};ServerName=$PsqlServer;DBQ=$SqlCatalog;TransportHint=TCP;"
# OLE DB
#$ConnString="Provider=PervasiveOLEDB;Data Source=$SqlCatalog;Location=$PsqlServer;"

$ConnString="DSN=$SqlCatalog"

Write-Host "Task $TaskName will be connecting using ConnectionString '$ConnString'";

# Hard code the SQL Query.
$SqlQuery = "select top 10 * from class"

# Setup SQL Connection
try {
    $SqlConnection = New-Object System.Data.Odbc.OdbcConnection($ConnString)
    #$SqlConnection.ConnectionString = $ConnString
    # to actually test if the connection was successful
    $SqlConnection.open()
    }
    catch {
        Write-Host "Failed to connect using ConnectionString '$ConnString'"
        Write-Host $_.Exception.Message
    }

# Setup SQL Command
$SqlCmd = New-Object System.Data.Odbc.OdbcCommand($SqlQuery, $SqlConnection)


$SqlAdapter = New-Object System.Data.Odbc.OdbcDataAdapter
$SqlAdapter.SelectCommand = $SqlCmd
$DataSet = New-Object System.Data.DataSet
$nRecs = $SqlAdapter.Fill($DataSet)


#Close the connection
$SqlConnection.Close();

# Display the Data Table in the console window.
Write-Host "DataSet contains $nRecs records :"
$DataSet.Tables[0]
