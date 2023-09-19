<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Something went wrong...</title>

<!--css-->
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
	<div class="container text-center">
		<img src="img/error.png" class="img-fluid w-25">
		<h3 class="display-4">Sorry ! Something went wrong ...</h3>
		<%=exception%>
		<br>
		<a href="profile.jsp"
			class="btn bg-primary text-white mt-3">Home</a>
	</div>
</body>
</html>
