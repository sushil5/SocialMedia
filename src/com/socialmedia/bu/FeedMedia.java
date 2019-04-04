package com.socialmedia.bu;

import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.socialmedia.dao.DBConnection;

/**
 * Servlet implementation class FeedMedia
 */
public class FeedMedia extends HttpServlet {
	private static final long serialVersionUID = 145487;
       
   
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String uid=request.getParameter("postID");
		int postIDInt=Integer.parseInt(uid);
		
		response.setContentType("image/gif");

		System.out.println("ImageDownloader is called");
		Connection  con=DBConnection.getConnection();
		try {
			PreparedStatement ps = con.prepareStatement("select media from post  where postid=?");
			ps.setInt(1, postIDInt);
			ResultSet rs=ps.executeQuery();
if(rs.next()) {
    byte[] img = rs.getBytes("media"); // blob field 

	OutputStream output = response.getOutputStream();
	/*String path = this.getClass().getClassLoader().getResource("").getPath();
	String fullPath = URLDecoder.decode(path, "UTF-8");
	String pathArr[] = fullPath.split("/WEB-INF/classes/");
	System.out.println(fullPath);
    File file=new File(pathArr[0]+File.pathSeparator+"WebContent"+File.pathSeparator+"images"+File.pathSeparator+"user.png");
    FileWriter fw=new FileWriter(file);
    fw.write(img);*/
	output.write(img);
	output.flush();
	output.close();
}
else {
	
}
}
			
catch(Exception e) {
	
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
