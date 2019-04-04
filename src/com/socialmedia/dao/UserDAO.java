package com.socialmedia.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	public static ResultSet getUser(int uid) {
		Connection con=DBConnection.getConnection();
		ResultSet rs=null;

		try {
			PreparedStatement ps=con.prepareStatement("select * from user where uid=?");
			ps.setInt(1,uid);
			 rs=ps.executeQuery();
			 rs.next();
		
	}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return rs;

		}

	public static String userAvail(String username) {
		Connection con=DBConnection.getConnection();
		ResultSet rs=null;
String msg="";
		try {
			PreparedStatement ps=con.prepareStatement("select * from user where username=?");
			ps.setString(1, username);
			 rs=ps.executeQuery();
          if(rs.next()) {
        	  msg= "<span style='color:red'>username unavailable</span>";
          }	
          else {
        	  msg="<span style='color:green'>username available</span>";
          }
	}
		catch(Exception e) {
			e.printStackTrace();
			
		}
		
		return msg;
	}

}
