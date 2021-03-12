<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
</head>
<style>
body { /* 
  background-color: #74EBD5;
  background-image: linear-gradient(90deg, #74EBD5 0%, #9FACE6 100%);

  min-height: 100vh; */
	
}

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
	height: 280px;
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
<body>
	<h6 align="center">Coming soon</h6>
	<div class="card">
		<div class="card-body">

			<div class="row">
				<div class="col-12 col-sm-3 col-md-3 col-lg-3"
					style="height: 400px; overflow-y: scroll">
					<div class="card">
						<div class="card-header">
							<button type="button" class="btn btn-primary" data-toggle="modal"
								data-target="#createGroupModal">Create Group</button>
						</div>
						<div class="card-body">
							<ul class="list-group list-group-flush" style="cursor: pointer">
								<li class="list-group-item getusername"><div
										class="paragraphs">
										<div class="row">
											<div class="span4">
												<img style="float: left; width: 55px; height: 55px;"
													src="resources/images/usericon.png" />
												<div class="content-heading">
													<h5>Group1</h5>
												</div>
												<p style="clear: both; width: 1200px; color: green;">
													<b>Date :HH:MM:SS</b>
												</p>
											</div>
										</div>
									</div></li>
								<li class="list-group-item getusername"><div
										class="paragraphs">
										<div class="row">
											<div class="span4">
												<img style="float: left; width: 55px; height: 55px;"
													src="resources/images/usericon.png" />
												<div class="content-heading">
													<h5>Group2</h5>
												</div>
												<p style="clear: both; width: 1200px; color: green;">
													<b>Date :HH:MM:SS</b>
												</p>
											</div>
										</div>
									</div></li>
								<li class="list-group-item getusername"><div
										class="paragraphs">
										<div class="row">
											<div class="span4">
												<img style="float: left; width: 55px; height: 55px;"
													src="resources/images/usericon.png" />
												<div class="content-heading">
													<h5>Group3</h5>
												</div>
												<p style="clear: both; width: 1200px; color: green;">
													<b>Date :HH:MM:SS</b>
												</p>
											</div>
										</div>
									</div></li>
								<li class="list-group-item getusername"><div
										class="paragraphs">
										<div class="row">
											<div class="span4">
												<img style="float: left; width: 55px; height: 55px;"
													src="resources/images/usericon.png" />
												<div class="content-heading">
													<h5>Group3</h5>
												</div>
												<p style="clear: both; width: 1200px; color: green;">
													<b>Date :HH:MM:SS</b>
												</p>
											</div>
										</div>
									</div></li>
							</ul>
						</div>
					</div>
				</div>
				<div class="col-12 col-sm-9 col-md-9 col-lg-9"
					style="height: 400px;">
					<div class="card">
						<div class="card-header">Group 1</div>
						<div class="card-body">
							<div class="col-12 px-0">
								<div class="px-4 py-5 chat-box bg-white" id="chat-box">
									<!-- Sender Message-->
									<div class="media w-50 mb-3">
										<i class="fas fa-user"></i>
										<div class="media-body ml-3">
											<div class="bg-light rounded py-2 px-3 mb-2">
												<p class="text-small mb-0 text-muted">User1</p>
											</div>
											<p class="small text-muted">Date : YYYY-MM-DD HH:MM:SS</p>
										</div>
									</div>

									<!-- Reciever Message-->
									<div class="media w-50 ml-auto mb-3">
										<div class="media-body">
											<div class="bg-primary rounded py-2 px-3 mb-2">
												<p class="text-small mb-0 text-white">User3</p>
											</div>
											<p class="small text-muted">Date : YYYY-MM-DD HH:MM:SS</p>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

				</div>
			</div>

		</div>
		<div class="card-footer">
			<div class="row">
				<div class="col-12 col-sm-10 col-md-10 col-lg-10 my-1">
					<input class="form-control" type="text"
						placeholder="Type a message" id="textMessage">
				</div>
				<div class="col-12 col-sm-2 col-md-2 col-lg-2 my-1" align="center">
					<button class="form-control col-6" style="color: green;"
						id="sendBtn">
						Go&nbsp;<i class="fa fa-paper-plane" aria-hidden="true"></i>
					</button>
				</div>
			</div>
		</div>

	</div>

	<!-- The Modal -->
	<div class="modal" id="createGroupModal">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">Create Group</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<!-- Modal body -->
				<div class="modal-body">
					<form action="addContacts" method="post" class="needs-validation"
						novalidate>
						<div class="form-group textstyle">
							<label for="username">Group Name:</label> <input type="text"
								class="form-control" placeholder="Enter Group name"
								maxlength="20" name="fullname" autocomplete="off" required="">
						</div>
						<div class="form-group textstyle">
							<label for="username">Users:</label> <select style="width: 100%;"
								class="form-control select-multiple-users" name="states[]"
								multiple="multiple">
								<option value="AL">User1</option>
								<option value="WY">User2</option>
								<option value="WY">User3</option>
								<option value="WY">User4</option>
								<option value="WY">User5</option>
							</select>
						</div>
						<div align="center">
							<input type="submit"
								class="btn btn-sm btn-info form-control col-sm-6" value="Create">
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<link
		href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css"
		rel="stylesheet" />
	<script
		src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$('.select-multiple-users').select2();
		});
	</script>
</body>
</html>