package io.github.hjain13;

import java.sql.*;

public class Connector {
	public Connection con;
	public Statement stmt;

	public Connector() throws Exception {
		try {
			String userName = "root";
			String password = "2762633";
			String url = "jdbc:mysql://localhost:3306/bookstorejava?allowMultiQueries=true";
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			con = DriverManager.getConnection(url, userName, password);
			stmt = con.createStatement();
		} catch (Exception e) {
			System.err
					.println("Unable to open mysql jdbc connection. The error is as follows,\n");
			System.err.println(e.getMessage());
			throw (e);
		}
	}

	public void closeConnection() throws Exception {
		con.close();
	}
}
