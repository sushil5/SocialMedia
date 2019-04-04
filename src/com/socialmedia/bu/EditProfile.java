package com.socialmedia.bu;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.json.simple.JSONObject;

import com.socialmedia.dao.DBConnection;
@MultipartConfig(maxFileSize = 16177215) 
public class EditProfile extends HttpServlet {
	private static final long serialVersionUID = 1565;
	Connection con = null;
	PreparedStatement ps1 = null;
	PreparedStatement ps2 = null;
	PrintWriter out = null;
	InputStream inputStream = null; // input stream of the upload file
	boolean userUpdate = false;
	boolean profileUpdate = false;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		out = response.getWriter();
		response.setContentType("text/html");
		con = DBConnection.getConnection();
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String email = request.getParameter("email");
		String mobile = request.getParameter("mobile");
		
		String name=firstName+" "+lastName;
		String address = request.getParameter("address");
        String dob = request.getParameter("date");

    	HttpSession session=request.getSession();
        int uid=(int)session.getAttribute("uid");

		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		java.util.Date date=null;
		try {
			date = formatter.parse(dob);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		java.sql.Date sqlDate = new java.sql.Date(date.getTime());

		// obtains the upload file part in this multipart request
		Part filePart = request.getPart("propic");
		if (filePart != null) {
			// prints out some information for debugging

			// obtains input stream of the upload file
			inputStream = filePart.getInputStream();
		}
		   
        try {
            // connects to the database
            con=DBConnection.getConnection();
            // constructs SQL statement
            String sql1 = "UPDATE user SET first_name=?, last_name=?, email=?,mobile_no=? WHERE uid=?";
            ps1 = con.prepareStatement(sql1);
            ps1.setString(1, firstName);
            ps1.setString(2, lastName);
            ps1.setString(3,email);
			ps1.setString(4,mobile);
			ps1.setInt(5,uid);
			int k=ps1.executeUpdate();
			if(k>0) {
				System.out.println("updated table user values firstName,lastName,email,mobile");
				userUpdate=true;
			}else {
				System.out.println("failed: updating user values firstName,lastName,email,mobile ");
			}
			 
            String sql2 = "UPDATE profile SET name=?, address=?,dob=?,propic=? where uid=?";
            ps2 = con.prepareStatement(sql2);
            ps2.setString(1, name);
            ps2.setString(2, address);
			
			ps2.setDate(3,sqlDate);

			if (inputStream != null) {
                // fetches input stream of the upload file for the blob column
                ps2.setBlob(4, inputStream);
    			ps2.setInt(5,uid);

            }
 
            // sends the statement to the database server
            int m = ps2.executeUpdate();
            if (m> 0) {
				System.out.println("updated table profile values name,address,dob,propic ");
                profileUpdate=true;
            }
            else {
				System.out.println("failed: updating profile values name,address,dob,propic ");

            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } 
            
        if(userUpdate&&profileUpdate) {
        	JSONObject userObj=JSONConvertor.convertToJSON(uid);
        	session.setAttribute("userObj", userObj);
        	
        	RequestDispatcher rd1=request.getRequestDispatcher("success.jsp");
        	rd1.include(request, response);
        }else {
        	 RequestDispatcher rd=request.getRequestDispatcher("editProfile.jsp");
         	rd.forward(request, response);
         	 RequestDispatcher rd1=request.getRequestDispatcher("/invalidEdit.html");
          	rd1.include(request, response);
        }
       

	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(req, resp);
	}
}
