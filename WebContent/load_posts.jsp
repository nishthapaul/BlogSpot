<%@page import="dao.PostDao" %>
<%@page import="dao.LikeDao" %>
<%@page import="helper.ConnectionProvider" %>
<%@page import="entities.Post" %>
<%@page import="entities.User" %>
<%@page import="java.util.List" %>
<div class="row">
	<% 
		User uuu = (User)session.getAttribute("currentUser");
		Thread.sleep(400);
		PostDao d = new PostDao(ConnectionProvider.getConnection());
		int cid = Integer.parseInt(request.getParameter("cid"));
		List<Post> posts = null;
		if (cid == 0) {
            posts = d.getAllPosts();
        } else {
            posts = d.getPostByCatId(cid);
        }
		if (posts.size() == 0) {
            out.println("<h3 class='display-3 text-center'>No Posts in this category..</h3>");
            return;
        }
		for(Post p : posts){
			%>
				
				<div class="col-md-6 mt-2">
        			<div class="card">
        				<div class="card-body">
        					<img class="card-img-top" src="blog_pics/<%= p.getpPic() %>" alt="Card image cap">
                			<b><%= p.getpTitle()%></b>
                			<p><%= p.getpContent()%></p>
            			</div>
            			<div class="card-footer primary-background text-center">
            			<% 
								LikeDao ld = new LikeDao(ConnectionProvider.getConnection());
							%>
        					<a href="#!" onclick="doLike(<%= p.getPid()%>,<%= uuu.getId()%>)" class="btn btn-outline-light btn-sm"> <i class="fa fa-thumbs-o-up"></i> <span class="like-counter"><%= ld.countLikeOnPost(p.getPid())%></span>  </a>
        					<a href="show_blog_post.jsp?post_id=<%= p.getPid() %>" class="btn btn-outline-light btn-sm">Read More...</a>
        					
            			</div>
        			</div>
        		</div>
				
			<%
		}
	%>
</div>
<script>
	function doLike(pid, uid)
	{
	    console.log(pid + "," + uid)
	    const d = {
	        uid: uid,
	        pid: pid,
	        operation: 'like'
	    }

	    $.ajax({
	        url: "LikeServlet",
	        data: d,
	        success: function (data, textStatus, jqXHR) {
	            console.log(data);
	            if (data.trim() == 'true')
	            {
	                let c = $(".like-counter").html();
	                c++;
	                $('.like-counter').html(c);
	            }
	        },
	        error: function (jqXHR, textStatus, errorThrown) {
	            console.log(data)
	        }
	    })
	}
	</script>
