package servlets;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

import entities.Message;
public class LogoutServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		response.getWriter().append("Served at: ").append(request.getContextPath());
		HttpSession s = request.getSession();
		s.removeAttribute("currentUser");
		Message msg = new Message("Logout Successfully", "success", "alert-success");
		s.setAttribute("msg", msg);
		response.sendRedirect("login_page.jsp");
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		doGet(request, response);
	}

}
