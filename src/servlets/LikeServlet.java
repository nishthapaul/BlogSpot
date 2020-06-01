package servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.LikeDao;
import helper.ConnectionProvider;

public class LikeServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		String operation = request.getParameter("operation");
		int uid = Integer.valueOf(request.getParameter("uid"));
		int pid = Integer.valueOf(request.getParameter("pid"));
//		out.println(operation);
//		out.println(uid);
//		out.println(pid);
		LikeDao lDao = new LikeDao(ConnectionProvider.getConnection());
		if(operation.equals("like")){
			boolean f  = lDao.insertLike(pid, uid);
			out.println(f);
		}
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}