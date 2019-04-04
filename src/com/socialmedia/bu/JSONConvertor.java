package com.socialmedia.bu;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.json.simple.JSONObject;

import com.socialmedia.dao.ProfileDAO;
import com.socialmedia.dao.UserDAO;

public class JSONConvertor {

	/**
	 * Convert a result set into a JSON Array
	 * 
	 * @param resultSet
	 * @return a JSONArray
	 * @throws Exception
	 */
	static int uid1;
	public static JSONObject convertToJSON(ResultSet rs)  {
		if (rs == null) {
			rs = UserDAO.getUser(uid1);
		}

		JSONObject obj = new JSONObject();
		// from user table
		try {
			obj.put("uid", rs.getInt("uid"));
			obj.put("username", rs.getString("username"));
			obj.put("first_name", rs.getString("first_name"));
			obj.put("last_name", rs.getString("last_name"));
			obj.put("email", rs.getString("email"));
			obj.put("mobile_no", rs.getString("mobile_no"));

			// from profile table
			ResultSet rs1 = ProfileDAO.getProfile(rs.getInt("uid"));
            obj.put("profID", rs1.getInt("profID"));
			obj.put("name", rs1.getString("name"));
			obj.put("address", rs1.getString("address"));
			obj.put("dob", rs1.getDate("dob"));
			obj.put("friends", rs1.getInt("friends"));
			obj.put("following", rs1.getInt("following"));
			obj.put("follower", rs1.getInt("follower"));

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return obj;
	}

	public static JSONObject convertToJSON(int uid) {
      
		uid1=uid;
		JSONObject userObj=convertToJSON(null);
		return userObj;
	}
}
