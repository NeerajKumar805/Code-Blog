<%@page import="com.ffc.dao.LikeDao"%>
<%@page import="com.ffc.dao.UserDao"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.ffc.entitites.Post"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.ffc.entitites.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.ffc.helper.ConProvider"%>
<%@page import="com.ffc.dao.PostDao"%>
<%@page import="com.ffc.entitites.User"%>
<%@page import="com.ffc.entitites.Message"%>

<%@page errorPage="error.jsp"%>

<%
User user = (User) session.getAttribute("currentUser");
if (user == null)
	response.sendRedirect("index.jsp");
%>
<%
int pid = Integer.parseInt(request.getParameter("postId"));
PostDao postDao = new PostDao(ConProvider.getCon());
Post p = postDao.getPostByPostId(pid);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%=p.getpTitle()%> || Facebook For Coders</title>
<!-- css -->
<style>
body {
	background: url("./img/bg.jpg");
	background-size: cover;
	background-attachment: fixed;
}

#content {
	overflow-x: auto;
	white-space: pre-wrap;
	word-wrap: break-word;
}

.font-family {
	/* font-family: Helvetica; */
	font-family: Verdana;
}

pre {
	overflow-x: auto;
}
</style>
<link href="css/mystyle.css" rel="stylesheet" />
<!-- bootstrap css -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>

	<%@include file="user-inner-navbar.jsp"%>

	<!-- Main starts -->

	<div class="container mt-3">

		<!-- <img src="..." class="card-img-top" alt="..."> -->
		<div class="row">
			<div class="col-md-6 offset-md-3">
				<div class="card">
					<div class="card-header alert alert-primary">
						<h5>
							<span class="fa fa-question-circle"></span>
							<%=p.getpTitle()%></h5>
					</div>
					<div class="card-body">
						<img src="blogPics/<%=p.getpPic()%>"
							class="card-img-top image-fluid" alt="Post photo" height="300px">
						<div class="row mt-3 border border-4 rounded">
							<div class="col-md-7">
								<%
								UserDao userDao = new UserDao(ConProvider.getCon());
								%>
								<p class="fs-6 lh-sm">
									<a href="#!" data-bs-toggle="modal"
										data-bs-target="#post-user-profile-modal"
										class="text-decoration-none fw-bold"><%=userDao.getUserByUserId(p.getUserId()).getName()%></a>
									has posted
								</p>
							</div>
							<div class="col-md-5 fst-italic fw-bold">
								<p><%=DateFormat.getDateTimeInstance().format(p.getpDate())%></p>
							</div>
						</div>
						<%-- <p class="fs-5 lh-sm" style="text-align: justify;"><%=p.getpContent()%></p> --%>

						<pre class="mt-3 font-family" id="content"><%=p.getpContent()%></pre>
						<hr>
						<div class="bg-dark text-light p-3">
							<pre class="fw-bold">
								<%=p.getpCode()%>
							</pre>
						</div>

					</div>
					<div class="card-footer">
						<!-- <a href="#!" class="btn btn-info btn-sm" data-bs-toggle="modal"
							data-bs-target="#view-user"> <i class="fa fa-eye"></i> <span
							class="like-counter"></span> </a> -->
						<%
						LikeDao likeDao = new LikeDao(ConProvider.getCon());
						%>
						<a href="#!" onclick="doLike(<%=p.getPid()%>,<%=user.getId()%>)"
							class="btn btn-info btn-sm"> <i
							class="fa fa-thumbs-o-up liked"></i> <span class="like-counter">
								<%=likeDao.likeCount(pid)%></span></a>
						<!--  <a href="#!" class="btn btn-info btn-sm"><i
							class="fa fa-commenting-o"> 8</i> </a> -->
					</div>

					<!-- Comments -->

					<!-- <div class="card-footer">
						<div class="comments">
							<form action="commentServlet" method="POST">
								<div class="form-group">
									<label class="mb-2"><b>8 Comments</b></label>
									<textarea required rows="3" placeholder="Write a comment"
										name="postCmt" class="form-control"></textarea>
								</div>

								<div class="container-fluid text-end mt-2">
									<button type="submit" class="btn btn-primary ">Submit</button>
								</div>
							</form>
						</div>
					</div> -->
				</div>
			</div>
		</div>

	</div>
	<!-- Main ends -->


	<div class="modal fade" id="post-user-profile-modal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header bg-lightblue">
					<h5 class="modal-title" id="profile-details">Profile Details</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>

				<div class="modal-body">
					<div class="container">
						<div class="container text-center">
							<img
								src="pics/<%=userDao.getUserByUserId(p.getUserId()).getProfile()%>"
								class="img-fluid" alt="profile pic"
								style="border-radius: 50%; width: 200px; height: 200px;">
							<h5 class="modal-title mb-3" id="exampleModalLabel"><%=userDao.getUserByUserId(p.getUserId()).getName()%></h5>
						</div>
						<!-- Profile Details -->

						<div id="profile-details" class="text-center">
							<table class="table table-striped table-hover">
								<tbody>
									<tr>
										<th scope="row">Id :</th>
										<td><%=userDao.getUserByUserId(p.getUserId()).getId()%></td>
									</tr>
									<tr>
										<th scope="row">Email :</th>
										<td><%=userDao.getUserByUserId(p.getUserId()).getEmail()%></td>
									</tr>
									<tr>
										<th scope="row">Gender :</th>
										<td><%=userDao.getUserByUserId(p.getUserId()).getGender()%></td>
									</tr>
									<tr>
										<th scope="row">Status :</th>
										<td><%=userDao.getUserByUserId(p.getUserId()).getAbout()%></td>
									</tr>
									<tr>
										<th scope="row">Registered on :</th>
										<td><%=userDao.getUserByUserId(p.getUserId()).getDateTime()%></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Back</button>
				</div>
			</div>
		</div>
	</div>
	<%@include file="footer.jsp"%>
	<script
		src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
	<script src="js/myjs1.js"></script>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
		crossorigin="anonymous">
	</script>
</body>
</html>