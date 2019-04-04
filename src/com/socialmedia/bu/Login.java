package com.socialmedia.bu;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.socialmedia.dao.DBConnection;
import com.socialmedia.dao.ProfileDAO;

/**
 * Servlet implementation class Login
 */
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection con=null;
	PrintWriter out=null;
	PreparedStatement ps=null;
	ResultSet rs=null;
	
	
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
        super();
        
        
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// TODO Auto-generated method stub
		response.setContentType("text/html");

		out=response.getWriter();
		con=DBConnection.getConnection();
		try {
			ps = con.prepareStatement("select * from user where username=? and password=?");
			String username=request.getParameter("username");
			String password=request.getParameter("password");

			
			ps.setString(1,username );
			ps.setString(2,password );
		    rs=ps.executeQuery();
		    boolean flag=rs.next();
		    JSONObject user=JSONConvertor.convertToJSON(rs);
		   
		    if(flag) {
		    	//other functionalities for app after login
		    	
		    JSONArray topProfiles=ProfileDAO.getTopTenIds();
		    	
		    	
		    	
		    	
		    	HttpSession session=request.getSession();
		    	session.setAttribute("uid", rs.getInt("uid"));
		    	session.setAttribute("user", rs.getString("username"));
		    	session.setAttribute("userObj", user);
		    	session.setAttribute("topProfiles", topProfiles);
		    	RequestDispatcher rd=request.getRequestDispatcher("home.jsp");
		    	rd.include(request, response);
		    	
		    }else {
		    	out.println("invalid username or password");
		    	RequestDispatcher rd=request.getRequestDispatcher("index.html");
		    	rd.include(request, response);

		    }

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
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
	public String getPath() throws UnsupportedEncodingException {
		String path = this.getClass().getClassLoader().getResource("").getPath();
		String fullPath = URLDecoder.decode(path, "UTF-8");
		String pathArr[] = fullPath.split("/WEB-INF/classes/");
		System.out.println(fullPath);
		System.out.println(pathArr[0]);
		fullPath = pathArr[0];
		String reponsePath = "";
		// to read a file from webcontent
		reponsePath = new File(fullPath).getPath();
		return reponsePath;
		}

}
