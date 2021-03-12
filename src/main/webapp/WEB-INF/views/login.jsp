<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<html>
<head>
<meta name="viewport" content="width=device-width">
</head> 
<body> 
	<div class="row">
		<div class="col-sm-4" align=""><div class="card ">
				<div class="card-body"><h5>Tips: </h5><hr><h6>Step 1. Please sign up</h6>
		<h6>Step 2. Please sign in</h6>
		<h6>Step 3. Then Use Messages & contacts</h6>
		<h5>Thank you.</h5></div></div></div>
		<div class="col-sm-4">
			<div class="card " style="background-color: #ccccff">
				<div class="card-body">

			<ul class="nav nav-pills textstyle">
						<li class="nav-item"><a class="nav-link active button"
							data-toggle="pill" href="#signin">Sign in</a></li>
						<li class="nav-item"><a class="nav-link button"
							data-toggle="pill" href="#signup">Sign up</a></li>
					</ul>
					<hr>
					<!-- Tab panes -->
					<div class="tab-content textstyle">
						<div class="tab-pane container active" id="signin">
							<form action="/login" method="post" class="needs-validation" id="singinForm" novalidate >
								<div class="form-group">
									<label for="username">Mobile</label> <input type="text" id="loginusername"
										name="username" class="form-control mobile"
										placeholder="Enter mobile" autocomplete="off" required="">
								</div>
								<div class="form-group">  <input type="hidden"
										name="password" class="form-control" id="loginpassword" >
								</div> 
								<div align="center"> 
								<input type="submit"
									class="btn btn-sm btn-info form-control col-sm-6"
									value="Sign in">
									</div> 
							</form>
						</div>
						<div class="tab-pane container fade" id="signup">
							<form action="/signup" method="post"
								class="needs-validation" id="singupForm" novalidate>
								<div class="form-group textstyle">
									<label for="username">Full Name:</label> <input type="text"
										class="form-control" placeholder="Enter First name" name="fullname" autocomplete="off" required="required">
								</div>
								<div class="form-group textstyle">
									<label for="username">Mobile:</label> <input type="text"
										class="form-control mobile" placeholder="Enter Mobile" name="mobile" autocomplete="off" required="required">
								</div> 
								<div align="center"> 
								<input type="submit"
									class="btn btn-sm btn-info form-control col-sm-6"
									value="Sign up">
									</div> 
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-sm-4"></div>
	</div>
	
 <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/1000hz-bootstrap-validator/0.11.9/validator.min.js"></script>
 <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.inputmask/3.3.4/jquery.inputmask.bundle.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$('.mobile').inputmask('999-999-9999');
			$("#loginusername").keyup(function() {
				$("#loginpassword").val($(this).val());
			});
		});
	</script>
</body>
</html>