package helper;
import java.sql.*;
public class ConnectionProvider {
	public static Connection con;
	public static Connection getConnection() {
		if(con == null) {
			try {
				Class.forName("com.mysql.jdbc.Driver"); // throws ClassNotFoundException
				con = DriverManager.getConnection("jdbc:mysql:///blogproject?useSSL=false", "root", "root");
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return con;
	}
	public static void main(String[] args) throws Exception {
		
	}
}