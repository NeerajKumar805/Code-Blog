<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@page import="com.ffc.entitites.User"%>
<%@page import="com.ffc.dao.LikeDao"%>
<%@page import="com.ffc.entitites.Post"%>
<%@page import="java.util.List"%>
<%@page import="com.ffc.helper.ConProvider"%>
<%@page import="com.ffc.dao.PostDao"%>

<%@page errorPage="error.jsp"%>

<%-- <%
User user = (User) session.getAttribute("currentUser");
if (user == null)
	response.sendRedirect("login.jsp");
%> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Facebook For Coders</title>

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

<!-- body background style -->
<style>
.banner-bg {
	clip-path: polygon(50% 0%, 79% 0, 100% 0, 100% 70%, 80% 90%, 50% 100%, 20% 94%, 0
		100%, 0 0, 24% 0);
}
</style>
</head>

<body>

	<!-- nav-bar -->

	<%@include file="navbar.jsp"%>

	<!-- banner -->
	<div class="container-fluid m-0 p-0">
		<div class="p-5 bg-lightblue text-white banner-bg">
			<div class="container p-5 pt-0">
				<p class=" display-4">
					Hey, <span class="text-warning">Welcome Folks!</span>
				</p>
				<p>Unlock the power of coding with essential knowledge. Embrace
					the journey of exploration, where simplicity meets complexity.
					Discover the joy of problem-solving and creation in the world of
					technology. Start your coding adventure today!</p>
				<p>Discover the ease of coding with required knowledge. Unleash
					your potential and explore a world of endless possibilities.</p>
				<a href="register.jsp" class="btn btn-outline-light"> <span
					class="fa fa-user-plus"></span> Join Now
				</a> <!-- <a class="btn btn-outline-light ms-3" href="login.jsp"> <span
					class="fa fa-user-circle fa-spin"></span> Login
				</a> -->
			</div>
		</div>
	</div>
	<br>
	<div class="container">
		<h2 class="text-center font-monospace fw-bold border-bottom border-primary p-3">Latest Posts</h2>
		<div class="row">
			<%
			PostDao postDao = new PostDao(ConProvider.getCon());
			List<Post> list = null;
			list = postDao.getAllPosts();
			if (list.size() == 0)
				out.print("<h3 class='text-center display-6'>There is no any post in this category...</h3>");
			for (Post p : list) {
			%>
			<div class="col-lg-4 col-md-6 mt-3">
				<b><%=p.getpTitle()%></b> <img src="blogPics/<%=p.getpPic()%>"
					class="card-img mt-3 pb-2" alt="Post photo" height="200px">
				<%-- <p class="mt-1"><%=p.getpContent()%></p> --%>

				<%
				if (p.getpContent().length() >= 0 && p.getpContent().length() <= 45) {
				%>
				<p class="mt-1"><%=p.getpContent()%></p>
				<%
				} else {
				%>
				<p class="mt-1"><%=p.getpContent().substring(0, 45)%>...</p>
				<%
				}
				%>

				<div class="card-footer">
					<%
					LikeDao likeDao = new LikeDao(ConProvider.getCon());
					%>
					<a href="login.jsp" class="btn btn-info btn-sm">Read More...</a> <a
						href="login.jsp" class="btn btn-info btn-sm"><i
						class="fa fa-thumbs-o-up"></i> <span><%=likeDao.likeCount(p.getPid())%></span></a>
					<!--  <a href="login.jsp"
						class="btn btn-info btn-sm"><i class="fa fa-commenting-o">
							8</i></a> -->
				</div>
			</div>
			<%
			}
			%>
		</div>
	</div>
	<%@include file="footer.jsp"%>
	<!-- Bootstrap Javascript -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
		crossorigin="anonymous">
	</script>

</body>
</html>