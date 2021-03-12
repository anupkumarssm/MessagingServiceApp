 
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
</head> 
<body class="d-flex flex-column min-vh-100">
	<div class="container my-4">
	<nav class="navbar navbar-expand-lg navbar-light"
			style="background-color: #ccccff"> 

			<a class="navbar-brand" href="messages">Messaging Service App</a>

			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarNavDropdown">
				<ul class="navbar-nav w-100">
					<li class="nav-item"><a class="nav-link text-white"></a></li>
					<li class="nav-item"><a class="nav-link text-white"
						href="messages"><i class="fas fa-home">&nbsp;Messages</i></a></li>
						<li class="nav-item"><a class="nav-link text-white"
						href="contacts"><i class="fas fa-address-book">&nbsp;Contacts</i></a></li>
						<li class="nav-item"><a class="nav-link text-white"
						href="group-messages"><i class="fas fa-users">&nbsp;Group Messages</i></a></li>
				</ul> 
				<sec:authorize access="hasAnyRole('USER')">
					<a class="nav-itemb" style="color: red;"
						href="logOut"
						class="text-white"><i class="fas fa-sign-out-alt">&nbsp;Logout</i>
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