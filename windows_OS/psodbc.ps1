# Windows PowerShell Script to test Pervasive.SQL connectivity through ODBC
# using Windows Authentication
#$DSN = "RaspiDemoData"
#$DSN="RaspiDemodata64"
$DSN="Demodata"
#$DSN="Raspi32"
$SQLQUERY = "SELECT * FROM Person"

$conn = New-Object system.Data.Odbc.OdbcConnection
#$conn.connectionstring = "(DSN=$DSN)"
#$conn.connectionString = "Server DSN=$DSN;Host=raspi"
$conn.connectionString = "Provider=PervasiveOLEDB;Data Source=DEMODATA;Host=raspi"

try {
    if (($conn.open()) -eq $true) {
        $conncmd = New-Object system.Data.Odbc.OdbcCommand($SQLQUERY, $conn)
        $da = New-Object system.Data.Odbc.OdbcDataAdapter($conncmd)
        $conn.close()
        
        Write-Host "Succesfull connection to DSN : $DSN"
        
        # print/output the resultset
        $dt
    }
    else {
        Write-Host "Could not connect to DSN : $DSN"
        Write-Host "No errors, so reason unknown"
      }
    }
    catch {
        Write-Host "Failed to connect to DSN : $DSN"
        Write-Host $_.Exception.Message
    }

# also consider: https://www.connectionstrings.com/pervasive/

# issues:
# - when running the script Set-Execution-Policy might need a change from
#   Windows 10 default setting "restricted" to "Bypass: https://ss64.com/ps/set-executionpolicy.html
# - when the script is ran and an error occurs it is not reported!
# - when executed manually:
#   $conn.open()  results in:
#   Exception calling "Open" with "0" argument(s): "ERROR [IM014] [Microsoft][ODBC Driver Manager] The specified DSN contains an architecture mismatch between the Driver and Application"
