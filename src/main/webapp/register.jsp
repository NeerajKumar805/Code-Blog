<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Registration page for FacebookForCoders</title>
<!-- css -->
<link href="css/mystyle.css" rel="stylesheet" />
<!-- bootstrap css -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
.banner-bg {
	clip-path: polygon(50% 0%, 100% 0, 100% 35%, 100% 100%, 80% 90%, 50% 100%, 20% 90%,
		0 100%, 0% 35%, 0 0);
}
</style>
</head>
<body>
	<!-- navbar -->
	<%@include file="navbar.jsp"%>

	<!-- form -->
	<main class="d-flex align-items-center bg-lightblue banner-bg"
		style="height: 90vh">
		<div class="container d-flex justify-content-center">
			<div class="card" style="width: 20rem;">
				<div class="card-header bg-primary text-white text-center">
					<span class="fa fa-user-plus fa-2x"></span>
					<p>Register yourself here</p>
				</div>
				<div class="card-body">
					<form id="reg-form" action="regServlet" method="POST">
						<div class="mb-3">
							<input name="user_name" type="text" required
								class="form-control border border-primary" id="username1"
								placeholder="Enter your name">
						</div>
						<div class="mb-3">
							<input name="user_email" type="email" required
								class="form-control border border-primary" id="email1"
								placeholder="Enter your email" aria-describedby="emailHelp">
							<div id="emailHelp" class="form-text">We'll never share
								your email with anyone else.</div>
						</div>
						<div class="mb-3">
							<label class="form-label me-3">Gender</label> <input type="radio"
								name="user_gender" value="Male" required> Male <input
								type="radio" name="user_gender" value="Female"> Female
						</div>
						<div class="mb-3">
							<input name="user_password" type="password" required
								class="form-control border border-primary" "id="password1"
								placeholder="Enter your password">
						</div>
						<div class="mb-3">
							<textarea name="user_about" rows="2" required
								class="form-control border border-primary"
								placeholder="Write somethng about yourself"></textarea>
						</div>
						<div class="mb-3 form-check">
							<input name="user_check" type="checkbox" required
								class="form-check-input border border-primary" id="cheack1">
							<label class="form-check-label" for="cheack1">Agree T&C*</label>
						</div>
						<div class="container text-center" id="loader"
							style="display: none;">
							<span class="fa fa-refresh fa-spin fa-4x"></span>
							<h4>Please wait..</h4>
						</div>
						<button type="submit" id="submit-btn" class="btn btn-primary">Submit</button>
						<div class="form-text pt-1">Already have an account? <a href="login.jsp" style="text-decoration: none;"><b>Login here!</b> </a></div>
					</form>
				</div>
			</div>
		</div>
	</main>
	<!-- Javascript -->
	<script src="js/myjs.js" type="text/javascript"></script>

	<!-- bootstrap javascript -->
	<!-- <script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
		crossorigin="anonymous"></script -->
	>
	<!-- <script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"
		integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p"
		crossorigin="anonymous"></script> -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"
		integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF"
		crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"
		integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
		crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
	<script>
            $(document).ready(function () {
                console.log("loaded........")

                $('#reg-form').on('submit', function (event) {
                    event.preventDefault();
                    let form = new FormData(this);

                    $("#submit-btn").hide();
                    $("#loader").show();
                    //send register servlet:
                    $.ajax({
                        url: "regServlet",
                        type: 'POST',
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                            console.log(data)

                            $("#submit-btn").show();
                            $("#loader").hide();

                            if (data.trim() === 'done')
                            {
                                swal("Registered Successfully...","Kindly login yourself","success")
                                        .then((value) => {
                                            window.location = "login.jsp"
                                        });
                            } else
                            {
                            	swal(data,"Please try again...","error");
                            }

                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            $("#submit-btn").show();
                            $("#loader").hide();
                            swal("Something went wrong!!!","Please try again...","error");
                        },
                        processData: false,
                        contentType: false
                    });
                });
            });
        </script>
</body>
</html>