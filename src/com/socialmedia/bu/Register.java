package com.socialmedia.bu;

import java.io.IOException;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.socialmedia.dao.DBConnection;
import com.socialmedia.dao.ProfileDAO;

/**
 * Servlet implementation class Register
 */
public class Register extends HttpServlet {
	private static final long serialVersionUID = 144L;
	Connection con=null;
	PreparedStatement ps1=null;
	PreparedStatement ps2=null;
	PrintWriter out=null;
       
   /*
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		out=response.getWriter();
		response.setContentType("text/html");
		con=DBConnection.getConnection();
		String username=request.getParameter("username");
		String password=request.getParameter("password");
		String firstName=request.getParameter("firstName");
		String lastName=request.getParameter("lastName");
		
		String email=request.getParameter("email");
		String mobile=request.getParameter("mobile");
	
        
	    try {
			ps1=con.prepareStatement("insert into user(username,password,first_name,last_name,email,mobile_no) values (?,?,?,?,?,?)");
			ps1.setString(1,username);
			ps1.setString(2,password);
			ps1.setString(3,firstName);
			ps1.setString(4,lastName);
			
			ps1.setString(5,email);
			ps1.setString(6,mobile);
			int k=ps1.executeUpdate();
			if(k>0) {
				System.out.println("user registered with username "+username);
			RequestDispatcher rd=request.getRequestDispatcher("index.html");
			rd.include(request,response);
			String name=firstName+" "+lastName;
			ProfileDAO.createProfile(username,name);
		
			}else {
				
				out.println("Registration failed");
				RequestDispatcher rd=request.getRequestDispatcher("register.html");
				rd.include(request,response);
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
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
