<%@ page import="com.ffc.entitites.Message"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login page for Facebook For Coders</title>
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
	clip-path: polygon(50% 0%, 79% 0, 100% 0, 100% 70%, 80% 90%, 50% 100%, 20% 94%, 0
		100%, 0 0, 24% 0);
}
</style>
</head>
<body>
	<!-- navbar -->
	<%@include file="navbar.jsp"%>

	<!-- form -->
	<main class="d-flex align-items-center bg-lightblue banner-bg"
		style="height: 80vh">
		<div class="container d-flex justify-content-center">
			<div class="card" style="width: 20rem;">
				<div class="card-header bg-primary text-white text-center">
					<span class="fa fa-user-circle fa-3x"></span>
					<p>Login here</p>
				</div>

				<div class="card-body">
					<form action="loginServlet1" method="POST">
						<div class="mb-3">
							<label for="email1" class="form-label">Email address</label> <input
								type="email" name="email"
								class="form-control border border-primary" id="email1"
								aria-describedby="emailHelp">
							<div id="emailHelp" class="form-text">We'll never share
								your email with anyone else.</div>
						</div>
						<div class="mb-3">
							<label for="password1" class="form-label">Password</label> <input
								type="password" name="password"
								class="form-control border border-primary" id="password1">
						</div>

						<%
						Message m = (Message) session.getAttribute("msg");
						if (m != null) {
						%>
						<div class="text-center alert <%=m.getCssClass()%>" role="alert">
							<%=m.getContent()%>
						</div>

						<%
						session.removeAttribute("msg");
						}
						%>
						<div class="container text-center">
							<button type="submit" class="btn btn-primary">Submit</button>
						</div>
						<div class="form-text pt-1">Don't have account? <a href="register.jsp" style="text-decoration: none;"><b>Create now!</b> </a></div>
					</form>
				</div>
			</div>
		</div>
	</main>
	<!-- Javascript -->
	<script src="js/myjs.js" type="text/javascript"></script>

	<!-- bootstrap javascript -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
		crossorigin="anonymous">
	</script>
</body>
</html>