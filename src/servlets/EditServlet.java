package servlets;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

import dao.UserDao;
import entities.Message;
import entities.User;
import helper.ConnectionProvider;
import helper.Helper;

@MultipartConfig
public class EditServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		
		String userEmail = request.getParameter("user_email");
		String userName = request.getParameter("user_name");
		String userPassword = request.getParameter("user_password");
		String userAbout = request.getParameter("user_about");
		
		Part part = request.getPart("user_image");
		String imageName = part.getSubmittedFileName();
		
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("currentUser");
		user.setEmail(userEmail);
		user.setName(userName);
		user.setPassword(userPassword);
		user.setAbout(userAbout);
		String oldFile = user.getProfile();
		user.setProfile(imageName);
		
		// update in database
		UserDao userDao = new UserDao(ConnectionProvider.getConnection());
		if(userDao.updateUser(user)) {
//			out.println("updated to db");
			String path = request.getRealPath("/") + "profile_pics" + File.separator + user.getProfile();
			System.out.println(path);
			String pathOldFile = request.getRealPath("/") + "profile_pics" + File.separator + oldFile;
			System.out.println(pathOldFile);
			if(!oldFile.equals("default.png")) {
				Helper.deleteFile(pathOldFile);
			}
			if(Helper.saveFile(part.getInputStream(), path)) {
//				out.println("profile photo updated");
				Message msg = new Message("Everything updated", "success", "alert-success");
				session.setAttribute("msg", msg);
			} else {
//				out.println("profile not updated");
				Message msg = new Message("Profile photo not updated", "error", "alert-danger");
				session.setAttribute("msg", msg);
			}
		} else {
//			out.println("not updated to db");
			Message msg = new Message("Something went wrong... Details not updated to db", "error", "alert-danger");
			session.setAttribute("msg", msg);
		}
		
		response.sendRedirect("profile.jsp");
		
	}

}