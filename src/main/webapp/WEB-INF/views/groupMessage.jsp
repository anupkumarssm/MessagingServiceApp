<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
</head>
<body> 


	<div class="card">
		<div class="card-body">
			<div class="row">
				<div class="col-12 col-sm-3 col-md-3 col-lg-3">
					<div class="card">
						<div class="card-header">
							<button type="button" class="btn btn-primary form-control" data-toggle="modal"
								data-target="#createGroupModal">Create Group</button>
						</div>
						<div class="card-body" style="height: 400px; overflow-y: scroll">
							<ul class="list-group list-group-flush" style="cursor: pointer">
							<c:forEach items="${getGroupList}" var="getGroups">
								<li id="activeLi${getGroups.id}" class="list-group-item getusername activeLi" onclick="getGroupId('${getGroups.id}','${getGroups.group_name}')"><div
										class="paragraphs">
										<div class="row">
											<div class="span4">
												<!-- <img style="float: left; width: 55px; height: 55px;"
													src="resources/images/usericon.png" /> -->
												<div class="content-heading">
													<i class="fas fa-user">&nbsp;&nbsp;<b>${getGroups.group_name}</b></i><br>
													<p style="font-family:'Courier New'"><b>Create By :</b> ${getGroups.group_name} <br> <b> Date :</b> HH:MM:SS </p>
												</div>
											</div>
										</div>
									</div></li>
									</c:forEach>
								 
							</ul>
						</div>
					</div>
				</div>
				<div class="col-12 col-sm-9 col-md-9 col-lg-9" style="height: 400px;">
				<div id="showGroupMessage"></div>
				</div>
			</div>
		</div>
	</div>

	<!-- The Modal -->
	<div class="modal" id="createGroupModal">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header bg-primary">
					<h4 class="modal-title text-white">Create Group</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<!-- Modal body -->
				<div class="modal-body">
					<form action="createGroup" method="post" class="needs-validation" id="createGroupForm"
						novalidate>
						<div class="form-group textstyle">
							<label for="username">Group Name:</label> <input type="text"
								class="form-control" placeholder="Enter Group name"
								maxlength="20" name="groupName" autocomplete="off" required="">
						</div>
						<div class="form-group textstyle">
							<label for="username">Select Users:</label> <select style="width: 100%;"
								class="form-control select-multiple-users" name="mobile"
								multiple="multiple">
								<c:forEach items="${getAllContacts}" var="contacts">
								<option value="${contacts.mobile}">${contacts.fullname}</option>
								</c:forEach> 
							</select>
						</div>
						<div align="center">
							<input type="submit"
								class="btn btn-sm btn-primary form-control col-sm-6" value="Create">
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
			$("#activeLi${top1Group.id}").addClass("active");   
			$('.select-multiple-users').select2();
			 $.get( "getGroupMessage", { groupId: "${top1Group.id}"} )
			  .done(function( data ) {
				  $("#showGroupMessage").html(data);
			  }); 
			 
			 
			 $(".activeLi").click(function () {
				    $(".activeLi").removeClass("active");
				    // $(".tab").addClass("active"); // instead of this do the below 
				    $(this).addClass("active");   
				});
			 
				$('#createGroupForm')
				.bootstrapValidator(
						{
							fields : {
								groupName : {
									validators : {
										notEmpty : {
											message : '<div class="text-center text-danger">Group Name cannot be empty</div>'
										},
									}
								},
								mobile : {
									validators : {
										notEmpty : {
											message : '<div class="text-center text-danger">Users cannot be empty</div>'
										},
									}
								}
							}
						});
			 
		});
	</script>
</body>
</html>