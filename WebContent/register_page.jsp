<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Sign Up Page</title>
	
	<!-- css -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<link href="css/myStyle.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
	<!-- navbar -->
	<%@include file="normal_navbar.jsp" %>
	
	<main class="d-flex align-items-center primary-background banner-background" style="padding-bottom: 80px; ">
		<div class="container">
			<div class="row">
				<div class="col-md-6 offset-md-3">
					
					<div class="card">
						<div class="card-header primary-background text-white text-center">
							<span class="fa fa-user-plus fa-3x"></span>
							<br>
							<p>Register Here</p>
						</div>
						<div class="card-body">
							<form id="reg-form" action="RegisterServlet" method="post">
								<div class="form-group">
									<label for="user_name">User Name</label>
							    	<input type="text" name="user_name" class="form-control" id="user_name" aria-describedby="nameHelp" placeholder="Enter User Name" required>
							  	</div>
								<div class="form-group">
									<label for="exampleInputEmail1">Email address</label>
							    	<input type="email" name="user_email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter Email Id" required>
							    	<small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
							  	</div>
							  	<div class="form-group">
							    	<label for="exampleInputPassword1">Password</label>
							    	<input type="password" name="user_password" class="form-control" id="exampleInputPassword1" placeholder="Enter Password" required>
							  	</div>
							  	<div class="form-group">
							    	<label for="gender">Select Gender</label> <br>
							    	<input type="radio" id="gender" value="male" name="user_gender" required> Male
							    	<input type="radio" id="gender" value="female" name="user_gender" required> Female
							  	</div>
							  	<div class="form-group">
							  		<textarea name="user_about" class="form-control" rows="5" placeholder="Enter something about yourself"></textarea>
							  	</div>
							  	<div class="form-group form-check">
							    	<input type="checkbox" name="check" class="form-check-input" id="exampleCheck1" required>
							    	<label class="form-check-label" for="exampleCheck1">Agree Terms and Conditions</label>
							  	</div>
							  	<div class="container text-center" id="loader" style="display: none;">
                                    <span class="fa fa-refresh fa-spin fa-4x"></span>
                                    <h4>Please wait..</h4>
                                </div>
							  	<button id="submit-btn" type="submit" class="btn btn-primary">Submit</button>
							</form>
						</div>
					</div>
					
				</div>
			</div>
		</div>
	</main>
	
	<!-- javascripts -->
	<script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
	<script src="js/myjs.js" type="text/javascript"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
	<script>
		$(document).ready(function () {
	        console.log("loaded........")
	        $('#reg-form').on('submit', function (event) {
	            event.preventDefault(); // stop to go to servlet
	            let form = new FormData(this); 
	            $("#sumbimt-btn").hide();
	            $("#loader").show();
	            //send register servlet:
	            $.ajax({
	                url: "RegisterServlet",
	                type: 'POST',
	                data: form,
	                success: function (data, textStatus, jqXHR) {
	                    console.log(data)
	                    $("#sumbimt-btn").show();
	                    $("#loader").hide();
	                    if (data.trim() === 'done')
	                    {
	                        swal("Registered successfully.. We are going to redirect to login page")
	                                .then((value) => {
	                                    window.location = "login_page.jsp"
	                                });
	                    } else
	                    {
	                        swal(data);
	                    }
	                },
	                error: function (jqXHR, textStatus, errorThrown) {
	                	console.log(jqXHR)
	                    $("#sumbimt-btn").show();
	                    $("#loader").hide();
	                    swal("something went wrong..try again");
	                },
	                processData: false,
	                contentType: false
	            });
	        });
	    });
	</script>
</body>
</html>