package com.socialmedia.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/*
String url = "jdbc:mysql://localhost:3306/dbname";
String user = "user";
String pass = "pass";
Class.forName ("com.mysql.jdbc.Driver").newInstance ();
Connection conn = DriverManager.getConnection (url, user, pass);
*/
public class DBConnection {
	private static Connection con;
	static {
		try {
			String url = "jdbc:mysql://localhost:3306/test";
			String user = "root";
			String pass = "1234";
			Class.forName ("com.mysql.jdbc.Driver").newInstance ();
			 con = DriverManager.getConnection (url, user, pass);
		    
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InstantiationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public static Connection getConnection() {
		return con;
	}
}
