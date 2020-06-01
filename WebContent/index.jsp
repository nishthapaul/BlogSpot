<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@page import="dao.PostDao" %>
<%@page import="helper.ConnectionProvider" %>
<%@page import="java.util.ArrayList" %>
<%@page import="entities.Category" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>BlogSpot</title>
	<!-- css -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<link href="css/myStyle.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
	<!-- navbar -->
	<%@include file="normal_navbar.jsp" %>
	
	<!-- banner -->
	<div class="container-fluid p-0 m-0">
		<div class="jumbotron primary-background text-white banner-background">
			<div class="container">
				<h3 class="display-3">Welcome to BlogSpot</h3>
				<p>Welcome to technical blog, world of technology 
				A programming language is a formal language, which comprises a set of instructions that produce various kinds of output. Programming languages are used in computer programming to implement algorithms.</p>
				<p>Most programming languages consist of instructions for computers. There are programmable machines that use a set of specific instructions, rather than general programming languages.</p>
				<a href="register_page.jsp" class="btn btn-outline-light btn-lg"><span class="fa fa-user-plus"></span> Start! It's free</a>
				<a href="login_page.jsp" class="btn btn-outline-light btn-lg"><span class="fa fa-user-circle fa-spin"></span> Login</a>
			</div>
		</div>
	</div>
	
	<div class="container">
		<div class="row">
			<% 
				PostDao pd = new PostDao(ConnectionProvider.getConnection());
				ArrayList<Category> listCategory = pd.getAllCategories();
				for(Category cat : listCategory){
			%>
			
			<div class="col-md-4 mb-3">
				<div class="card">
						<div class="card-body">
				    		<h5 class="card-title"><%= cat.getName() %></h5>
				    		<p class="card-text"><%= cat.getDescription() %></p>
  						</div>
				</div>
			</div>
			<% } %>
			
		</div>
		
	</div>
		
	<!-- javascripts -->
	<script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</body>
</html>