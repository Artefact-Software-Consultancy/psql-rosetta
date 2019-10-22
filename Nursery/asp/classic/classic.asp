<html>
<head>
<titleSimple Pervasive.SQL demo</title>
<style>
table {
  font-family: arial, sans-serif;
  border-collapse: collapse;
  width: 100%;
}

td, th {
  border: 1px solid #dddddd;
  text-align: left;
  padding: 8px;
}
tr:nth-child(even) {
  background-color: #dddddd;
}
</style>
</head>
<body bgcolor="white" text="black">
<h1>Classic ASP database demo</h1>
<%
Dim sqlConn
Dim sqlCS
Dim sqlQry
Dim rsDemodata

Response.Write ("Classic ASP database access")
Response.Write("</br>")

'error handling is overrated? :P
Set sqlConn = Server.CreateObject("ADODB.Connection")

CS = "Driver={Pervasive ODBC Interface};ServerName=localhost;dbq=@Demodata;"
'CS = "Driver={Pervasive ODBC Client Interface};ServerName=raspi;dbq=@demodata;"
'sqlConn.ConnectionString=CS

Response.Write("Using connection string: " + CS)
Response.Write("</br>")
Response.Write("</br>")

'Open database
sqlConn.Open CS

Set rsDemodata = Server.CreateObject("ADODB.RecordSet")

sqlQry = "SELECT * FROM Person" '+ " LIMIT 25"

'open recordset with query
rsDemodata.Open sqlQry,sqlConn
'rsDemodata.Execute sqlQry
%>
<h2>List of persons</h2>
<table>
  <tr>
    <th>First_Name</th>
    <th>Last_Name</th>
    <th>Perm_Street</th>
    <th>Perm_City</th>
    <th>Perm_State</th>
    <th>Perm_Zip</th>
    <th>Perm_Country</th>
    <th>Street</th>
    <th>City</th>
    <th>State</th>
    <th>Zip</th>
    <th>Phone</th>
    <th>Emergency_Phone</th>
    <th>Unlisted</th>
    <th>Date_Of_Birth</th>
    <th>Email_Address</th>
    <th>Sex</th>
    <th>Citizenship</th>
    <th>Smoker</th>
    <th>Married</th>
    <th>Children</th>
    <th>Disability</th>
    <th>Scholarship</th>
    <th>Comments</th>
  </tr>
<%

Do While not rsDemodata.EOF
%>
    <tr>
        <td><%=rsDemodata("First_Name") %></td>
        <td><%=rsDemodata("Last_Name") %></td>
        <td><%=rsDemodata("Perm_Street") %></td>
        <td><%=rsDemodata("Perm_City") %></td>
        <td><%=rsDemodata("Perm_State") %></td>
        <td><%=rsDemodata("Perm_Zip") %></td>
        <td><%=rsDemodata("Perm_Country") %></td>
        <td><%=rsDemodata("Street") %></td>
        <td><%=rsDemodata("City") %></td>
        <td><%=rsDemodata("State") %></td>
        <td><%=rsDemodata("Zip") %></td>
        <td><%=rsDemodata("Phone") %></td>
        <td><%=rsDemodata("Emergency_Phone") %></td>
        <td><%=rsDemodata("Unlisted") %></td>
        <td><%=rsDemodata("Date_Of_Birth") %></td>
        <td><%=rsDemodata("Email_Address") %></td>
        <td><%=rsDemodata("Sex") %></td>
        <td><%=rsDemodata("Citizenship") %></td>
        <td><%=rsDemodata("Smoker") %></td>
        <td><%=rsDemodata("Married") %></td>
        <td><%=rsDemodata("Children") %></td>
        <td><%=rsDemodata("Disability") %></td>
        <td><%=rsDemodata("Scholarship") %></td>
        <td><%=rsDemodata("Comments") %></td>
    </tr>
<%
    
    'Move to next record
    rsDemodata.MoveNext
Loop
%>
</table>

<%
'Clean up
rsDemodata.Close
Set rsDemodata = Nothing
Set sqlConn = Nothing

' Error handling is messy. Should happen where it is needed. Not here.
If Err.Number > 0 Then
    Response.Write("Error #" & Err.Number & "")
    Response.Write("Error Source: " & Err.Source & "")
    Response.Write("Error Description: " & Err.Description & "")
End If
%>

</body>
</html>

