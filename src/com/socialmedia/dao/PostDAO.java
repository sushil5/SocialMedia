package com.socialmedia.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class PostDAO {
static	Connection con=null;
static {
	
	con=DBConnection.getConnection();
}
	
	public static ResultSet getPost() {
		
		ResultSet rs=null;

		try {
			PreparedStatement ps=con.prepareStatement("select postid,profID,status,likes,about from post order by postid desc");
			 rs=ps.executeQuery();
		
	}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return rs;

		}
		
		
	}
	

