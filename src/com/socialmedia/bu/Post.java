package com.socialmedia.bu;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.json.simple.JSONObject;

import com.mysql.jdbc.Blob;
import com.socialmedia.dao.DBConnection;

@MultipartConfig(maxFileSize = 16177215) 

public class Post extends HttpServlet {

	private static final long serialVersionUID = 1788;
	InputStream inputStream = null; // input stream of the upload file

    /**
     * @see HttpServlet#HttpServlet()
     */
   
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	HttpSession	session=request.getSession();
	JSONObject userObj=(JSONObject)session.getAttribute("userObj");
	
		PrintWriter out=response.getWriter();

         int profID=(int)userObj.get("profID");
		String status=request.getParameter("status");
		String about=request.getParameter("aboutMsg");

		Part filePart = request.getPart("media");
		if (filePart != null) {
			// prints out some information for debugging

			// obtains input stream of the upload file
			inputStream = filePart.getInputStream();
		}
		else {
			out.print("unsuccessfull");
		}
		
		
		Connection con=DBConnection.getConnection();
		try {
			PreparedStatement ps=con.prepareStatement("insert into post(profID,media, status,about) values(?,?,?,?)");
		    ps.setInt(1, profID);
		    
                // fetches input stream of the upload file for the blob column
                ps.setBlob(2, inputStream);
                if(status!=null)
    			ps.setString(3,status);
                else
                	ps.setString(3, "");
                ps.setString(4, about);
                
                int k=ps.executeUpdate();
                if(k>0) {
                	if(about.contains("profile")) {
            			PreparedStatement ps1=con.prepareStatement("update profile set propic=? where profID=?");
                        ps1.setBlob(1, inputStream);
                        ps1.setInt(2, profID);
                      int m=  ps1.executeUpdate();
                   if(m>0) {
                	   System.out.println("propic updated through a post");
                   }else {
                	   System.out.println("could not update propic ");
                	   
                   }
                	}
                	
                	RequestDispatcher rd=request.getRequestDispatcher("home.jsp");
    		    	rd.include(request, response);
                }else {
                	out.println("could not prcess");
                	RequestDispatcher rd=request.getRequestDispatcher("home.jsp");
    		    	rd.include(request, response);
                }
           	
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
doGet(request,response);
	}

}
