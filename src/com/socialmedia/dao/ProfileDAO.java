package com.socialmedia.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class ProfileDAO {
	static Connection con=null;
	static {
		
		 con=DBConnection.getConnection();
	}

	public static void createProfile(String username,String name) {

		try {
			PreparedStatement ps=con.prepareStatement("select uid from user where username=?");
			ps.setString(1,username);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				int uid=rs.getInt("uid");
				PreparedStatement ps1=con.prepareStatement("insert into profile(uid,name) values(?,?)");
				ps1.setInt(1, uid);
				ps1.setString(2, name);
				int k=ps1.executeUpdate();
				if(k>0) {
					System.out.println("profile \'created\' for username "+username);
				}else {
					System.out.println("profile \'could not create\' for username "+username);

				}
                   
			}
			else {
				System.out.println("user was not found for username "+username);
			}
			
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static ResultSet getProfile(int uid) {
		ResultSet rs=null;

		try {
			PreparedStatement ps=con.prepareStatement("select * from profile where uid=?");
			ps.setInt(1,uid);
			 rs=ps.executeQuery();
			 rs.next();
		
	}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return rs;

		}

	public static JSONArray getTopTenIds() {
		JSONArray topProfiles=new JSONArray();
try {
	PreparedStatement ps=con.prepareStatement("select uid,name from profile order by follower desc");
	ResultSet rs=ps.executeQuery();
	while(rs.next()) {
		JSONObject obj=new JSONObject();

		obj.put("uid", rs.getInt("uid"));
		obj.put("name", rs.getString("name"));
		topProfiles.add(obj);
		
	}
	
} catch (SQLException e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
}

return topProfiles;
	}
	public static JSONObject getInfo(int profID) {
		JSONObject obj=null;
		try {
			PreparedStatement ps=con.prepareStatement("select uid,name from profile pr left join post ps on ps.profID=pr.profID where ps.profID=?;");
			ps.setInt(1, profID);
			
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				 obj=new JSONObject();

				obj.put("uid", rs.getInt("uid"));
				obj.put("name", rs.getString("name"));
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	return obj ;
	}
}
