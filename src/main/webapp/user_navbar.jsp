<%@page import="com.ffc.entitites.User"%>
<%
User userNav = (User) session.getAttribute("currentUser");
if (userNav == null)
	response.sendRedirect("index.jsp");
%>

<nav class="navbar navbar-expand-md sticky-top navbar-dark bg-primary">
	<div class="container-fluid">
		<a class="navbar-brand" href="profile.jsp"><span
			class="fa fa-facebook-square"></span> Code-Blog</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav me-auto mb-2 mb-lg-0">
				<!-- <li class="nav-item"><a class="nav-link active" href="#"><span
							class="fa fa-bell"></span> Notifications</a></li>
					<li class="nav-item"><a class="nav-link active" href="#"><span
							class="fa fa-phone"></span> Contact</a></li> -->
				<!-- <li class="nav-item dropdown"><a
						class="nav-link active dropdown-toggle" href="#"
						id="navbarDropdown" role="button" data-bs-toggle="dropdown"
						aria-expanded="false"> <span class="fa fa-calendar-check-o"></span>
							Categories
					</a>
						<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
							<li><a class="dropdown-item" href="#">Programming
									Languages</a></li>
							<li><a class="dropdown-item" href="#">Projects</a></li>
							<li><hr class="dropdown-divider"></li>
							<li><a class="dropdown-item" href="#">Data Structure</a></li>
						</ul></li> -->
				<li class="nav-item"><a class="btn btn-outline-light me-2"
					data-bs-toggle="modal" data-bs-target="#addPostModal"><span class="fa fa-plus"></span> Add Post</a></li>
				<li class="nav-item"><a href="loadOneUserPost.jsp?uid=<%=userNav.getId()%>"
					class="btn btn-outline-light"><span class="fa fa-book"></span> My Posts</a></li>
			</ul>
			<ul class="navbar-nav me-2 mb-2 mb-lg-0">
				<li class="nav-item"><a class="btn btn-outline-light me-2" href="#!"
					data-bs-toggle="modal" data-bs-target="#profileModal"><span
						class="fa fa-male"></span> <%=userNav.getName()%></a></li>
				<li class="nav-item"><a class="btn btn-outline-light"
					href="logoutServlet"><span class="fa fa-external-link-square"></span>
						Logout</a></li>
			</ul>
		</div>
	</div>
</nav>