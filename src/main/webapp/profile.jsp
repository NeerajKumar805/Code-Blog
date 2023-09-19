
<%@page contentType="text/html" pageEncoding="UTF-8"%>

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
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User profile page after login</title>
<!-- css -->
<style>
body {
	background: url("./img/bg.jpg");
	background-size: cover;
	background-attachment: fixed;
}
</style>
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
	<%@include file="user_navbar.jsp"%>

	<!-- Main content of the page -->

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
	<main class="container mt-3">
		<div class="row">

			<!-- Category Section -->

			<div class="col-md-4">
				<div class="list-group">
					<a href="#" onclick="getPosts(0, this)"
						class="list-group-item list-group-item-action active text-center c-link"
						aria-current="true">All Posts</a>
					<%
					PostDao postDao1 = new PostDao(ConProvider.getCon());
					ArrayList<Category> list1 = postDao1.getAllCategories();
					for (Category c : list1) {
					%>
					<a href="#" onclick="getPosts(<%=c.getCid()%>, this)"
						class="list-group-item list-group-item-action c-link"><%=c.getCname()%></a>
					<%
					}
					%>
				</div>
			</div>

			<!-- Post Contents -->

			<div class="col-md-8">
				<div class="container me-0 text-center" id="loader">
					<i class="fa fa-refresh fa-spin fa-3x"></i>
					<h4 class="mt-2">Loading...</h4>
				</div>
				<div class="container-fluid" id="post-container"></div>
			</div>
		</div>
	</main>

	<!-- End of main -->

	<!-- Profile Details -->
	<div class="modal fade" id="profileModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header bg-lightblue">
					<h5 class="modal-title" id="exampleModalLabel">Profile Details</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>

				<div class="modal-body">
					<div class="container">
						<div class="container text-center">
							<img src="pics/<%=user.getProfile()%>" class="img-fluid"
								alt="profile pic"
								style="border-radius: 50%; width: 200px; height: 200px;">
							<h5 class="modal-title mb-3" id="exampleModalLabel"><%=user.getName()%></h5>
						</div>
						<!-- Profile Details -->

						<div id="profile-details" class="text-center">
							<table class="table table-striped table-hover">
								<tbody>
									<tr>
										<th scope="row">Id :</th>
										<td><%=user.getId()%></td>
									</tr>
									<tr>
										<th scope="row">Email :</th>
										<td><%=user.getEmail()%></td>
									</tr>
									<tr>
										<th scope="row">Gender :</th>
										<td><%=user.getGender()%></td>
									</tr>
									<tr>
										<th scope="row">Status :</th>
										<td><%=user.getAbout()%></td>
									</tr>
									<tr>
										<th scope="row">Registered on :</th>
										<td><%=user.getDateTime()%></td>
									</tr>
								</tbody>
							</table>
						</div>

						<!--profile edit-->

						<div id="profile-edit" class="container" style="display: none;">
							<h3 class="mt-2 mb-4 text-center">Edit your details</h3>
							<form action="editServlet" method="POST"
								enctype="multipart/form-data">
								<div class="container">
									<table class="table">
										<tr>
											<th>ID :</th>
											<td>&nbsp;&nbsp;&nbsp;<%=user.getId()%></td>
										</tr>
										<tr>
											<th>Email :</th>
											<td><input type="email" class="form-control"
												name="user_email" value="<%=user.getEmail()%>"></td>
										</tr>
										<tr>
											<th>Name :</th>
											<td><input type="text" class="form-control"
												name="user_name" value="<%=user.getName()%>"></td>
										</tr>
										<tr>
											<th>Password :</th>
											<td><input type="text" class="form-control"
												name="user_password" value="<%=user.getPassword()%>"></td>
										</tr>
										<tr>
											<th>Gender :</th>
											<td>&nbsp;&nbsp;&nbsp;<%=user.getGender()%></td>
										</tr>
										<tr>
											<th>About :</th>
											<td><textarea rows="2" class="form-control"
													name="user_about"><%=user.getAbout()%>
                                                </textarea></td>
										</tr>
										<tr>
											<th>New Profile:</th>
											<td><input type="file" name="image" class="form-control">
											</td>
										</tr>

									</table>
								</div>

								<div class="container text-center">
									<button type="submit" class="btn btn-outline-primary">Save
										Changes</button>
								</div>

							</form>

						</div>
					</div>
				</div>

				<div class="modal-footer">
					<a class="btn btn-danger" href="deleteUser?id=<%=user.getId()%>">Close
						account</a>
					<button type="button" id="edit-profile-button"
						class="btn btn-primary">Edit</button>
				</div>
			</div>
		</div>
	</div>

	<!-- Ending Profile Section -->

	<!-- Post Section Start -->

	<div class="modal fade" id="addPostModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header bg-lightblue">
					<h5 class="modal-title" id="exampleModalLabel">Share your
						knowledge...</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form action="addPostServlet" method="POST" id="add-post-form">
						<select class="form-control mb-3" name="cid">
							<option class="form-control" selected>---Select
								Category---</option>
							<%
							PostDao postDao = new PostDao(ConProvider.getCon());
							ArrayList<Category> aList = postDao.getAllCategories();
							for (Category c : aList) {
							%>
							<option value="<%=c.getCid()%>"><%=c.getCname()%></option>
							<%
							}
							%>
						</select>
						<div class="mb-3">
							<input type="text" required placeholder="Write the title"
								name="pTitle" class="form-control">
						</div>
						<div class="mb-3">
							<textarea required rows="3"
								placeholder="Start writing your post content" name="pContent"
								class="form-control"></textarea>
						</div>
						<div class="mb-3">
							<textarea rows="3" placeholder="Code (If any)" name="pCode"
								class="form-control"></textarea>
						</div>
						<div class="mb-3">
							<label class="form-labe">Attach a photo</label> <input
								type="file" name="postPic" required>
						</div>
						<div class="container text-center mb-3">
							<button type="submit" class="btn btn-outline-primary">Submit</button>
						</div>
					</form>
				</div>
				<!-- <div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary">Post</button>
				</div> -->
			</div>
		</div>
	</div>
	<%-- <%@include file="footer.jsp"%> --%>
	
	<!-- Javascript -->
	<script src="js/myjs1.js" type="text/javascript"></script>

	<!-- bootstrap javascript -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
		crossorigin="anonymous"></script>

	<script src="https://code.jquery.com/jquery-3.4.1.min.js"
		integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
	<script>
		$(document).ready(function() {
			let editStatus = false;

			$('#edit-profile-button').click(function() {

				if (editStatus == false) {
					$("#profile-details").hide()

					$("#profile-edit").show();
					editStatus = true;
					$(this).text("Back")
				} else {
					$("#profile-details").show()

					$("#profile-edit").hide();
					editStatus = false;
					$(this).text("Edit")

				}

			})
		});
	</script>
	<!-- JavaScript for add post -->
	<script>
	$(document).ready(function (e) {
        //
        $("#add-post-form").on("submit", function (event) {
            //this code gets called when form is submitted....
            event.preventDefault();
            /* console.log("you have clicked on submit..") */
            let form = new FormData(this);

            //now requesting to server
            $.ajax({
                url: "addPostServlet",
                type: 'POST',
                data: form,
                success: function (data, textStatus, jqXHR) {
                    //success ..
                    /* console.log(data); */
                    if (data.trim() == 'done')
                    {
                        swal("Post saved successfully!", "You can view your post now...", "success")
                        .then((value) => {
                            window.location = "profile.jsp"
                        });
                    } else
                    {
                        swal("Something went wrong!!!", "Please try again...", "error");
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    //error..
                	swal("Something went wrong!!!", "Please try again...", "error");
                },
                processData: false,
                contentType: false
            })
        })
    })
	</script>
	<script>
        
        function getPosts(cid, temp) {
        	$("#loader").show();
            $("#post-container").hide()
            $(".c-link").removeClass('active')
            
        	$.ajax({
                url: "loadPost.jsp",
                data: {cid:cid},
                success: function (data, textStatus, jqXHR) {
                	console.log(data);
                    $("#loader").hide();
                    $("#post-container").show();
                    $("#post-container").html(data)
                    $(temp).addClass('active')
                }
            })
		}
     $(document).ready(function (e) {
    	let allPostsRef= $(".c-link")[0]
        getPosts(0, allPostsRef)
     })
	</script>
	
</body>
</html>