
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="icon" href="#">
<title>Messaging Service App</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="viewport"
	content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0" />

<link href="https://use.fontawesome.com/releases/v5.0.6/css/all.css"
	rel="stylesheet">
<link rel="stylesheet" href="resources/css/bootstrap.min.css">

<script src="resources/js/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="resources/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.inputmask/3.3.4/jquery.inputmask.bundle.min.js"></script>
 <link rel="stylesheet" href="resources/css/bootstrapValidator.min.css" />
	<script type="text/javascript" src="resources/js/bootstrapValidator.min.js"></script>
<style>
body {
	background-color: #74EBD5;
	background-image: linear-gradient(90deg, #74EBD5 0%, #9FACE6 100%);
	min-height: 100vh;
}
</style>
 <style>
::-webkit-scrollbar {
	width: 5px;
}

::-webkit-scrollbar-track {
	width: 5px;
	background: #f5f5f5;
}

::-webkit-scrollbar-thumb {
	width: 1em;
	background-color: #ddd;
	outline: 1px solid slategrey;
	border-radius: 1rem;
}

.text-small {
	font-size: 0.9rem;
}

.messages-box, .chat-box {
	height: 350px;
	overflow-y: scroll;
}

.rounded-lg {
	border-radius: 0.5rem;
}

input::placeholder {
	font-size: 0.9rem;
	color: #999;
}
</style>
</head>
<body class="d-flex flex-column min-vh-100">
	<div class="container my-4">
		<nav class="navbar navbar-expand-lg navbar-light bg-primary"
			style="background-color: #ccccff">

			<a class="navbar-brand" href="messages"><img
				style="margin: -16px; margin-top: -23px;"
				src="resources/images/logo1.png" height="57px;" width="200px;"></a>

			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarNavDropdown">
				<ul class="navbar-nav w-100">
					<li class="nav-item"><a class="nav-link text-white"></a></li>
					<li class="nav-item"><a class="nav-link text-white"
						href="direct-messages"><i class="fas fa-user">&nbsp;Direct&nbsp;Messages</i></a></li>
					<li class="nav-item"><a class="nav-link text-white"
						href="group-messages"><i class="fas fa-users">&nbsp;Group&nbsp;Messages</i></a></li>
						<li class="nav-item"><a class="nav-link text-white"
						href="contacts"><i class="fas fa-address-book">&nbsp;Contacts</i></a></li>
				</ul>
				<sec:authorize access="hasAnyRole('USER')">
				
				<ul class="navbar-nav w-100">
				<li class="nav-item" style="width: 150px;"></li>
					<li class="nav-item">
					<span  ><b>Welcome&nbsp;:</b>&nbsp;${userDetials.fullname}</span>
					</li>
					</ul>
				
				
				 
					<a class="nav-itemb text-white" href="logOut" ><i class="fas fa-sign-out-alt" style="color: red;">&nbsp;Logout</i>
					</a>
				</sec:authorize>
				<sec:authorize access="!hasAnyRole('USER')">
					<a href="login" class="nav-itemb text-white"><i
						class="fas fa-sign-in-alt">&nbsp;Login </i></a>
				</sec:authorize>
			</div>
		</nav>
		<sitemesh:write property="body" />
	</div>
</body>
</html>