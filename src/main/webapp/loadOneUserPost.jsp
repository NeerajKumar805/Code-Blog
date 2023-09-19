<%@page import="jakarta.servlet.jsp.tagext.JspIdConsumer"%>
<%@page import="com.ffc.dao.LikeDao"%>
<%@page import="com.ffc.dao.UserDao"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.ffc.entitites.Post"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.ffc.entitites.Category"%>
<%@page import="java.util.List"%>
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
int uid = Integer.parseInt(request.getParameter("uid"));
PostDao postDao = new PostDao(ConProvider.getCon());
Post p1 = new Post();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%=user.getName()%>'s Posts || Facebook For Coders</title>
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

	<div class="container-fluid mt-5">

		<!-- <img src="..." class="card-img-top" alt="..."> -->
		<div class="row d-flex justify-content-center">
			<%
			List<Post> list = null;

			if (uid == 0)
				list = postDao.getAllPosts();
			else if (uid != 0)
				list = postDao.getPostsByUserId(uid);
			if (list.size() == 0)
				out.print("<h3 class='text-center display-6 pt-5 mt-5'>You haven't posted anything yet...</h3>");
			else {
				for (Post p : list) {
			%>
			<div class="col-lg-3 col-md-4 col-sm-6 m-2" style="background-color: #ffe6e6">
				<div class="row mt-2">
					<div class="col-md-9 col-sm-10">You have posted this...</div>
					<div class="col-md-3 col-sm-2">
						<!-- <a data-bs-toggle="modal"
		data-bs-target="#exampleModal"><span class="fa fa-ellipsis-v"></span></a> -->
						<a href="deletePost?pid=<%=p.getPid()%>" class="btn btn-sm btn-danger">Delete</a>
					</div>
				</div>
				<img src="blogPics/<%=p.getpPic()%>" class="card-img-top pb-2 pt-2"
					alt="Post photo" height="250px"> <span
					class="fa fa-question-circle-o"></span>
				<%
				if (p.getpTitle().length() >= 0 && p.getpTitle().length() <= 20) {
				%>
				<b><%=p.getpTitle()%></b>
				<%
				} else {
				%>
				<b><%=p.getpTitle().substring(0, 20)%></b>...
				<%
				}
				%>
				<!-- end of title -->
				<%
				if (p.getpContent().length() >= 0 && p.getpContent().length() <= 30) {
				%>
				<p class="mt-1"><%=p.getpContent()%></p>
				<%
				} else {
				%>
				<p class="mt-1"><%=p.getpContent().substring(0, 30)%>...
				</p>
				<%
				}
				%>
				<div class="card-footer d-flex justify-content-around">
					<%
					LikeDao likeDao = new LikeDao(ConProvider.getCon());
					%>
					<a href="#!" onclick="doLike(<%=p.getPid()%>,<%=user.getId()%>)"
						class="btn btn-info btn-sm"><i class="fa fa-thumbs-o-up"></i>
						<span><%=likeDao.likeCount(p.getPid())%></span></a>
					<!-- <a href="#!" class="btn btn-info btn-sm"><i
				class="fa fa-commenting-o"> 8</i></a> -->
					<a href="showMoreBlog.jsp?postId=<%=p.getPid()%>"
						class="btn btn-info btn-sm">Read More...</a>
				</div>
			</div>
			<%
			}
			}
			%>
		</div>

	</div>
	<!-- Main ends -->
	<%-- <%@include file="footer.jsp"%> --%>
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