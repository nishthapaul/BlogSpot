<%@page import="entities.Category" %>
<%@page import="dao.PostDao" %>
<%@page import="dao.UserDao" %>
<%@page import="dao.LikeDao" %>
<%@page import="helper.ConnectionProvider" %>
<%@page import="entities.User" %>
<%@page import="entities.Post" %>
<%@page errorPage="error_page.jsp" %>
<%@page import="java.util.ArrayList" %>
<% 
	User user = (User)session.getAttribute("currentUser");
	if(user == null){
		response.sendRedirect("login_page.jsp");
	}
%>
<%
	int postId = Integer.valueOf(request.getParameter("post_id"));
	PostDao d = new PostDao(ConnectionProvider.getConnection());
	Post p = d.getPostByPostId(postId);
%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title><%= p.getpTitle() %></title>
	<!-- css -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<link href="css/myStyle.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<style>
	.post-title{
	font-weight: 100;
	font-size: 30px;
	}
	.post-content{
		font-weight: 100;
		font-size: 25px;
	}
	.row-user{
		border: 1px solid #e2e2e2;
		padding-top: 15px;
	}
	</style>
</head>
<body>
	
	<!-- navbar starts -->
	
	<nav class="navbar navbar-expand-lg navbar-dark primary-background">
	  <a class="navbar-brand" href="index.jsp"><span class="fa fa-asterisk"></span> BlogSpot</a>
	  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	    <span class="navbar-toggler-icon"></span>
	  </button>
	
	  <div class="collapse navbar-collapse" id="navbarSupportedContent">
	    <ul class="navbar-nav mr-auto">
	      <li class="nav-item active">
	        <a class="nav-link" href="profile.jsp"><span class="fa fa-bell-o"></span> LearnToCode <span class="sr-only">(current)</span></a>
	      </li>
	      <li class="nav-item dropdown">
	        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	          <span class="fa fa-check-square-o"></span> Categories
	        </a>
	        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
	          <a class="dropdown-item" href="#">Programming Language</a>
	          <a class="dropdown-item" href="#">Projects</a>
	          <div class="dropdown-divider"></div>
	          <a class="dropdown-item" href="#">Something else here</a>
	        </div>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" href="#"><span class="fa fa-address-card-o"></span> Contact</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" href="#" data-toggle="modal" data-target="#add-post-modal"><span class="fa fa-asterisk"></span> Add Post</a>
	      </li>
	    </ul>
	    <ul class="navbar-nav mr-right">
	    	<li class="nav-item">
	        	<a class="nav-link" href="#" data-toggle="modal" data-target="#profile-modal"><span class="fa fa-user-circle"></span> <%= user.getName() %></a>
	      	</li>
	    	<li class="nav-item"> 
	        	<a class="nav-link" href="LogoutServlet"><span class="fa fa-user-times"></span> Logout</a>
	      	</li>
	    </ul>
	  </div>
	</nav>
	
	<!-- navbar ends -->
	
	<!-- main body starts -->
	
		<div class="conatiner">
			<div class="row my-4">
				<div class="col-md-5 offset-md-4"> <!-- video 6, 2 -->
					<div class="card">
						<div class="card-header primary-background text-white">
							<h4 class="post-title"><%= p.getpTitle() %></h4>
						</div>
						<div class="card-body">
							<img class="card-img-top my-2" src="blog_pics/<%= p.getpPic() %>" alt="Card image cap">
							
							<div class="row my-2 row-user">
								<div class="col-md-7">
									<% 
										UserDao userDao = new UserDao(ConnectionProvider.getConnection());
									%>
									<p class="post-user-info"><a href="#!"><%= userDao.getUserByPostId(p.getUserId()).getName() %></a> has posted : </p>
								</div>
								<div class="col-md-5">
									<p class="post-date"><i><b> <%= p.getpDate().toLocaleString() %> </b></i></p>
								</div>
							</div>
							
							<p class="post-content"><%= p.getpContent() %></p>
							<br>
							<div class="post-code">
								<pre><%= p.getpCode() %></pre>
							</div>
						</div>
						<div class="card-footer primary-background">
							<% 
								LikeDao ld = new LikeDao(ConnectionProvider.getConnection());
							%>
        					<a href="#!" onclick="doLike(<%= p.getPid()%>,<%= user.getId()%>)" class="btn btn-outline-light btn-sm"> <i class="fa fa-thumbs-o-up"></i> <span class="like-counter"><%= ld.countLikeOnPost(p.getPid())%></span>  </a>
            			</div>
					</div>
					
				</div>
			</div>
		</div>
	
	<!-- main body ends -->
	
	<!-- profile modal starts -->
		
		<div class="modal fade" id="profile-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header primary-background text-white text-center">
		        <h5 class="modal-title" id="exampleModalLabel"> BlogSpot </h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
		      	<div class="conatiner text-center">
		      		<img src="profile_pics/<%= user.getProfile() %>" class="img-fluid" style="border-radius:50%; max-width:150px; max-height:150px; ">
		      		<br>
		      		<h5 class="modal-title mt-3" id="exampleModalLabel"> <%= user.getName() %> </h5>
		      		<!-- details -->
		      		<div id="profile-details">
			      		<table class="table">
						  <tbody>
						    <tr>
						      <th scope="row"> Id: </th>
						      <td><%= user.getId() %></td>
						    </tr>
						    <tr>
						      <th scope="row"> Email: </th>
						      <td><%= user.getEmail() %></td>
						    </tr>
						    <tr>
						      <th scope="row"> Gender: </th>
						      <td><%= user.getGender() %></td>
						    </tr>
						    <tr>
						      <th scope="row"> Status: </th>
						      <td><%= user.getAbout() %></td>
						    </tr>
						    <tr>
						      <th scope="row"> Registered On: </th>
						      <td><%= user.getDateTime().toString() %></td>
						    </tr>
						  </tbody>
						</table>
					</div>
					
					<!-- profile edit -->
					<div id="profile-edit" style="display: none;">
						<h3 class="mt-2">Please Edit Carefully</h3>
						<form action="EditServlet" method="post" enctype="multipart/form-data">
							<table class="table">
								<tr>
									<td> Id: </td>
									<td><%= user.getId() %></td>
								</tr>
								<tr>
						      		<td> Email: </td>
						      		<td><input type="email" class="form-control" name="user_email" value="<%= user.getEmail() %>"></td>
						    	</tr>
						    	<tr>
						      		<td> User Name: </td>
						      		<td><input type="text" class="form-control" name="user_name" value="<%= user.getName() %>"></td>
						    	</tr>
						    	<tr>
						      		<td> Password: </td>
						      		<td><input type="password" class="form-control" name="user_password" value="<%= user.getPassword() %>"></td>
						    	</tr>
						    	<tr>
						      		<td> Gender: </td>
						      		<td><%= user.getGender() %></td>
						    	</tr>
						    	<tr>
						      		<td> About: </td>
						      		<td>
						      			<textarea class="form-control" name="user_about" rows="5"><%= user.getAbout() %></textarea>
						      		</td>
						    	</tr>
						    	<tr>
						      		<td> Profile Picture: </td>
						      		<td>
						      			<input type="file" name="user_image" class="form_control">
						      		</td>
						    	</tr>
							</table>
							<div class="container">
								<button type="submit" class="btn btn-outline-primary">Save</button>
							</div>
						</form>
					</div>
					
		      	</div>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		        <button type="button" class="btn btn-primary" id="edit-profile-btn">Edit</button>
		      </div>
		    </div>
		  </div>
		</div>
	
	<!-- profile modal ends -->
	
	<!-- add post modal -->
	
		<div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header primary-background text-white text-center">
		        <h5 class="modal-title" id="exampleModalLabel">Post Details</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
		        
		        <form id="add-post-form" action="AddPostServlet" method="post">
		        	<div class="form-group">
		        		<select class="form-control" name="cid">
							<option selected disabled>---Select Category---</option>
							<% 
								PostDao postDao = new PostDao(ConnectionProvider.getConnection());
								ArrayList<Category> list = postDao.getAllCategories();
								for(Category c : list){
							%>
								<option value="<%= c.getCid() %>"><%= c.getName() %></option>
							<% } %>
		        		</select>
		        	</div>
		        	<div class="form-group">
		        		<input name="pTitle" type="text" class="form-control" placeholder="Enter Post Title" required>
		        	</div>
		        	<div class="form-group">
		        		<textarea name="pContent" class="form-control" style="height: 200px" placeholder="Enter your content"></textarea>
		        	</div>
		        	<div class="form-group">
		        		<textarea name="pCode" class="form-control" style="height: 200px" placeholder="Enter your program (if any)"></textarea>
		        	</div>
		        	<div class="form-group">
		        		<label>Select your pic...</label> <br>
		        		<input type="file" class="form-control" name="pic">
		        	</div>
		        	<div class="container text-center">
		        		<button type="submit" class="btn btn-outline-primary">Post</button>
		        	</div>
		        </form>
		        
		      </div>
		      
		  </div>
		</div>
	</div>
	
	<!-- end post modal -->
	
	<!-- javascripts -->
	<script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
	<script>
		$(document).ready(function(){
			let editStatus = false;
			$('#edit-profile-btn').click(function(){
				if(editStatus == false){
					$('#profile-details').hide()
					$('#profile-edit').show()
					editStatus = true;
					$(this).text("Back");
				} else {
					$('#profile-details').show()
					$('#profile-edit').hide()
					editStatus = false;
					$(this).text("Edit");
				}
			})
		})
	</script>
	<!--now add post js-->
	<script>
	$(document).ready(function (e) {
        //
        $("#add-post-form").on("submit", function (event) {
            //this code gets called when form is submitted....
            event.preventDefault();
            console.log("you have clicked on submit..")
            let form = new FormData(this);
            //now requesting to server
            $.ajax({
                url: "AddPostServlet",
                type: 'POST',
                data: form,
                success: function (data, textStatus, jqXHR) {
                    //success ..
                    console.log(data);
                    if (data.trim() == 'done')
                    {
                        swal("Good job!", "saved successfully", "success");
                    } else
                    {
                        swal("Error!!", "Something went wrong try again...", "error");
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    //error..
                    swal("Error!!", "Something went wrong try again...", "error");
                },
                processData: false,
                contentType: false
            })
        })
    })
	</script>
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
	
</body>
</html>