import java.sql.*; // Connection & DriverManager
import java.net.*;

/*
 * From Java 8 on the JDBC-ODBC-bridge is no longer available
 * see: https://docs.oracle.com/javase/7/docs/technotes/guides/jdbc/bridge.html
 * only native JDBC driver should be used.
 */

/*
 * see: https://www.connectionstrings.com/pervasive/
 * Driver={Pervasive ODBC Client Interface};ServerName=myServerAddress;dbq=@dbname;
 */

// https://www.tutorialspoint.com/jdbc/index.htm

/*
 * see: https://docs.actian.com/psql/psqlv13/
 * JDBC:
 *      https://docs.actian.com/psql/psqlv13/#page/jdbc%2Fjdbc_gd.htm%23
 *      https://docs.actian.com/psql/psqlv13/#page/jdbc%2Fjdbctasks.htm%23ww82748
 *      https://docs.actian.com/psql/psqlv13/#page/jdbc%2Fjdbctasks.htm#ww68687
 * JCL (Btrieve):
 *      https://docs.actian.com/psql/psqlv13/#page/jcl%2Fjavintro.htm%23
 */

public class PSQLJDBCtest {
    public static void main(String args[]) throws ClassNotFoundException {
	try{
		// load driver
		Class.forName("com.pervasive.jdbc.v2.Driver");
		// goal: DSN-based connection : BS, this not ODBC
		String DB_SERVER="localhost";
		//String DB_DSN="demodata";

		//String DB_SERVER="localhost";
		String DB_PORT="1583";
		String DB_NAME="Demodata";
		String DB_USER="";
		String DB_PASS="";

		// parse args if available
		String argHost="";
		String argDB="";
		if (args.length == 2) {
		    try {
			argHost = String.valueOf(args[0]);
		    }
		    catch (Exception e) {
			System.err.println("Argument " + args[0] + " must be a string (hostname or IP).");
			// it would be fair to act, but lets be lazy
		    }
		    try {
			argDB = String.valueOf(args[1]);
		    }
		    catch (Exception e) {
			System.err.println("Argument " + args[1] + " must be a string (database name).");
		    }
		    // I can test a host here using InetAddress.isReachable, but JDBC will do that too, so why bother
		    // Try { hst = InetAddress.getByName(argHost); etc

		    DB_SERVER = argHost ;
		    DB_NAME = argDB ;
		}

		String DB_URI = "jdbc:pervasive://" + DB_SERVER + ":" + DB_PORT + "/" + DB_NAME ;
		System.out.println("Connection URI : " + DB_URI);
		Connection conn = DriverManager.getConnection(DB_URI);
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery("select count(*) from person");
		rs.next();
		int count = rs.getInt(1);
		System.out.println("Number of people in database table person: " + count);
		conn.close();
	}
	catch(Exception e){
		System.out.println(e.toString());
	};
    }
}
