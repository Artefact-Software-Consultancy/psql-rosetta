using System;
using System.Diagnostics;
using System.Data.Odbc;
namespace BuilderODBC {
        class odbc_psql_dsn {
                static void Main(string[] args) {
                        // see: https://www.connectionstrings.com/pervasive/
                        string connectionString = "Driver={Pervasive ODBC Interface};ServerName=localhost;dbq=@demodata;";
                        string sql = "SELECT COUNT(*) FROM Person";
                        OdbcConnection conn = null;
                        OdbcCommand comm = null;
                        OdbcDataReader dr = null;
                        try {
                                Console.WriteLine("About to connect to database using DSN-less connectionstring : " + connectionString);
                                conn= new OdbcConnection(connectionString);
                                conn.Open();
                                Console.WriteLine("Executing query : "+ sql);
                                comm = new OdbcCommand(sql, conn);
                                dr = comm.ExecuteReader();
                                Console.WriteLine("Result :");
                                while (dr.Read()) {
                                        Console.WriteLine(dr.GetValue(0).ToString());
                                }
                                dr.Close();
                        }
                        catch (OdbcException oe){
                                Console.WriteLine("An ODBC exception occurred: " + oe.Message.ToString());
                        }
                        catch (Exception e) {
                                Console.WriteLine("An Exception occurred: " + e.Message.ToString());
                        }
                        finally {
                                if (conn.State == System.Data.ConnectionState.Open){
                                        conn.Close();
                                }
                                comm.Dispose();
                                conn.Dispose();
                        }
                }
        }
}
