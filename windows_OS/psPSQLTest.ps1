param(
    [string]$PsqlServer="localhost",
    [string]$SqlCatalog="demodata"
)

# Load assembly
[void]
[System.Reflection.Assembly]::LoadWithPartialName("Pervasive.Data.SqlClient")

$nobits =(Get-CimInstance -ClassName win32_operatingsystem).OSArchitecture
Write-Host "Running on $nobits Windows system"

# Setup some variables
$TaskName = "psPSQLTest"

Write-Host "Task $TaskName will be connecting to database '$SqlCatalog' on Pervasive.SQL server '$PsqlServer'";

# Hard code the SQL Query.
$SqlQuery = "select top 10 * from class"

# Setup SQL Connection
try {
    $SqlConnection = New-Object Pervasive.Data.SqlClient.PsqlConnection
    $SqlConnection.ConnectionString = "ServerName = $PsqlServer; ServerDSN=$SqlCatalog"
    $sqlConnection.Open()
    }
    catch {
        Write-Host "Failed to connect to DSN '$SqlCatalog' on server '$PsqlServer'"
        #Write-Host $_.Exception.Message
    }

# Setup SQL Command
$SqlCmd = New-Object Pervasive.Data.SqlClient.PsqlCommand
$SqlCmd.CommandText = $SqlQuery
$SqlCmd.Connection = $SqlConnection

# Setup .NET SQLAdapter to execute and fill .NET Dataset 
$SqlAdapter = New-Object Pervasive.Data.SqlClient.PsqlDataAdapter
$SqlAdapter.SelectCommand = $SqlCmd
$DataSet = New-Object System.Data.DataSet

#Execute and Get Row Count
$nRecs = $SqlAdapter.Fill($DataSet)

#Close the connection
$SqlConnection.Close();

# Display the Data Table in the console window.   
$DataSet.Tables[0]