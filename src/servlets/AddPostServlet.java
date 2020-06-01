package servlets;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

import dao.PostDao;
import entities.Post;
import entities.User;
import helper.ConnectionProvider;
import helper.Helper;
@MultipartConfig
public class AddPostServlet extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		int cid = Integer.parseInt(request.getParameter("cid"));
		String pTitle = request.getParameter("pTitle");
//		out.println("your post title is " + pTitle);
		String pContent = request.getParameter("pContent");
        String pCode = request.getParameter("pCode");
        Part part = request.getPart("pic");
//        out.println(part.getSubmittedFileName());
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("currentUser");
        
        Post p = new Post(pTitle, pContent, pCode, part.getSubmittedFileName(), null, cid, user.getId());
        PostDao dao = new PostDao(ConnectionProvider.getConnection());
        if (dao.savePost(p)) {

            String path = request.getRealPath("/") + "blog_pics" + File.separator + part.getSubmittedFileName();
            Helper.saveFile(part.getInputStream(), path);
            out.println("done");
        } else {
            out.println("error");
        }
        
	}

}
