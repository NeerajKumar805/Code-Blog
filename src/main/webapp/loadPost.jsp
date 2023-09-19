<!-- Load post jsp page -->

<%@page import="com.ffc.entitites.User"%>
<%@page import="com.ffc.dao.LikeDao"%>
<%@page import="com.ffc.entitites.Post"%>
<%@page import="java.util.List"%>
<%@page import="com.ffc.helper.ConProvider"%>
<%@page import="com.ffc.dao.PostDao"%>

<%@page errorPage="error.jsp"%>

<div class="row">
	<%
	User u = (User) session.getAttribute("currentUser");
	Thread.sleep(300);
	PostDao postDao = new PostDao(ConProvider.getCon());
	List<Post> list = null;

	int cid = Integer.parseInt(request.getParameter("cid"));

	if (cid == 0)
		list = postDao.getAllPosts();
	else if (cid != 0)
		list = postDao.getPostsByCatId(cid);
	if (list.size() == 0)
		out.print("<h3 class='text-center display-6 pt-5 mt-5'>There is no any post in this category...</h3>");
	else {
		for (Post p : list) {
	%>
	<div class="col-lg-6 col-md-12 mb-3 rounded pt-3" style="background-color: #ffe6e6">
		<img src="blogPics/<%=p.getpPic()%>" class="card-img-top pb-2"
			alt="Post photo" height="200px"> <span
			class="fa fa-question-circle-o"></span>
		<%
		if (p.getpTitle().length() >= 0 && p.getpTitle().length() <= 30) {
		%>
		<b><%=p.getpTitle()%></b>
		<%
		} else {
		%>
		<b><%=p.getpTitle().substring(0, 30)%></b>...
		<%
		}
		%>
		<!-- end of title -->
		<%
		if (p.getpContent().length() >= 0 && p.getpContent().length() <= 40) {
		%>
		<p class="mt-1"><%=p.getpContent()%></p>
		<%
		} else {
		%>
		<p class="mt-1"><%=p.getpContent().substring(0, 40)%>...
		</p>
		<%
		}
		%>
		<div class="card-footer d-flex justify-content-around">
			<%
			LikeDao likeDao = new LikeDao(ConProvider.getCon());
			%>
			<a href="#!" onclick="doLike(<%=p.getPid()%>,<%=u.getId()%>)"
				class="btn btn-info btn-sm"><i class="fa fa-thumbs-o-up"></i> <span><%=likeDao.likeCount(p.getPid())%></span></a>
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