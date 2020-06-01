package servlets;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

import dao.UserDao;
import entities.User;
import helper.ConnectionProvider;

@MultipartConfig
public class RegisterServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		String name = request.getParameter("user_name");
		String email = request.getParameter("user_email");
		String password = request.getParameter("user_password");
		String gender = request.getParameter("user_gender");
		String about = request.getParameter("user_about");
		
		User user = new User(name, email, password, gender, about);
		
		UserDao userDao = new UserDao(ConnectionProvider.getConnection());
		if(userDao.saveUser(user)) {
			// data inserted... user registered
			out.println("done");
		} else {
			out.println("error");
		}
		
		
	}

}
