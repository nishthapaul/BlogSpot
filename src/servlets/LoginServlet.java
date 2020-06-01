package servlets;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

import dao.UserDao;
import entities.Message;
import entities.User;
import helper.ConnectionProvider;

public class LoginServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		String email = request.getParameter("user_email");
		String password = request.getParameter("user_password");
		
		UserDao userDao = new UserDao(ConnectionProvider.getConnection());
		User user = userDao.getUserByEmailAndPassword(email, password);
		
		if(user == null) {
			// login error
//			out.println("invalid details... Try again");
			Message msg = new Message("Invalid details... Try again", "error", "alert-danger");
			HttpSession s = request.getSession();
			s.setAttribute("msg", msg);
			response.sendRedirect("login_page.jsp");
		} else {
			// login success
			HttpSession session = request.getSession();
			session.setAttribute("currentUser", user);
			response.sendRedirect("profile.jsp");
		}
		
	}

}
