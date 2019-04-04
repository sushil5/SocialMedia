package com.socialmedia.bu;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLDecoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.socialmedia.dao.DBConnection;

/**
 * Servlet implementation class ImageDownloader
 */
public class ImageDownloader extends HttpServlet {
	private static final long serialVersionUID = 45454;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String uid=request.getParameter("uid");
		int uidInt=Integer.parseInt(uid);
		
		response.setContentType("image/gif");

		System.out.println("ImageDownloader is called");
		Connection  con=DBConnection.getConnection();
		try {
			PreparedStatement ps = con.prepareStatement("select propic from profile where uid=?");
			ps.setInt(1, uidInt);
			ResultSet rs=ps.executeQuery();
			rs.beforeFirst();
if(rs.next()) {
    byte[] img = rs.getBytes("propic"); // blob field 

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

}
