<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<div class="card">
		<div class="card-header">
			<div class="row">
				<div class="col-md-10">
					<h4>Contact List</h4>
				</div>
				<div class="col-md-2">
					<button type="button" class="btn btn-primary" data-toggle="modal"
						data-target="#addContactModal">Add Contact</button>
				</div>
			</div>
		</div>
		<div class="card-body">
			<!-- Button to Open the Modal -->
			<ul class="list-group list-group-flush">
				<c:forEach items="${getAllContacts}" var="contacts">
					<li class="list-group-item"><div class="paragraphs">
							<div class="row">
								<div class="span4">
									<div class="content-heading">
										<h5>${contacts.fullname}</h5>
									</div>
									<p style="clear: both; width: 1200px;">${contacts.mobile}</p>
								</div>
							</div>
						</div></li>
				</c:forEach>
			</ul>
		</div>
	</div>
	<!-- The Modal -->
	<div class="modal" id="addContactModal">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">Add Contact</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<!-- Modal body -->
				<div class="modal-body">
					<form action="addContacts" method="post" class="needs-validation"
						novalidate>
						<div class="form-group textstyle">
							<label for="username">Full Name:</label> <input type="text"
								class="form-control" placeholder="Enter First name" maxlength="20"
								name="fullname" autocomplete="off" required="">
						</div>
						<div class="form-group textstyle">
							<label for="username">Mobile:</label> <input type="text"
								class="form-control mobile" placeholder="Enter Mobile"
								name="mobile" autocomplete="off" required="">
						</div>
						<div align="center">
							<input type="submit"
								class="btn btn-sm btn-info form-control col-sm-6" value="Save">
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
 <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/1000hz-bootstrap-validator/0.11.9/validator.min.js"></script>
 <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.inputmask/3.3.4/jquery.inputmask.bundle.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$('.mobile').inputmask('999-999-9999');
		});
	</script>
</body>
</html>