<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<body>
	<div class="row">
		<div class="col-md-6">
			<h4>Messages</h4>
		</div>
		<div class="col-md-6">
			<input type="text" class="form-control searchContacts"
				placeholder="Search contacts" id="searchContacts">
		</div>
	</div>
	<div class="card">
		<div class="card-body">
			<ul class="list-group list-group-flush" style="cursor: pointer">
				<c:forEach items="${getAllMessages}" var="messages">
					<li class="list-group-item getusername" data-toMobile="${messages.toMobile}"><div
							class="paragraphs">
							<div class="row">
								<div class="span4">
									<img style="float: left; width: 55px; height: 55px;"
										src="resources/images/usericon.png" />
									<div class="content-heading">
										<h5>${messages.toFullname}</h5>
										<h5 style="border-radius: 5px solid #999">${messages.chatCount}</h5>
									</div>
									<p style="clear: both; width: 1200px; color:green;"><b id="updateDate${messages.id}">Date : ${messages.timestamp}</b></p>
								</div>
							</div>
						</div></li>
				</c:forEach> 
			</ul>
		</div>
	</div>

	<link
		href="http://code.jquery.com/ui/1.10.2/themes/smoothness/jquery-ui.css"
		rel="Stylesheet"></link>
	<script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>

	<style>
.ui-autocomplete {
	width: 330px;
	margin-top: 120px;
	cursor: pointer;
	position: absolute;
	left: 50%;
	transform: translatex(-50%);
}
</style>
	<script type="text/javascript">
		$(document)
				.ready(
						function() {
							$(document)
									.on(
											"click",
											".getusername",
											function() {
												var tousername = $(this).attr(
														"data-toMobile");
												//alert("tousername=="+tousername)
												window.location.href = 'getMessages?toMobile='
														+ tousername;
											});

							//alert("LLL")
							$("#searchContacts")
									.autocomplete(
											{
												source : function(request,
														response) {
													$(
															".ui-menu .ui-menu-item a")
															.css(
																	{
																		"margin-top" : "155px",
																		"margin-left" : "14px"
																	});
													/*  var data1 = [{
													         label: "hi",
													         value: "bye"
													         }]; */
													var data = ${getAllContacts};
													response(data);
												},
												select : function(event, ui) {
													$("#searchContacts").val(
															ui.item.label); //ui.item is your object from the array
													window.location.href = 'getMessages?toMobile='
															+ ui.item.value;
													return false;
												}
											});
							
							var intervalId = window.setInterval(function(){
								 $.get( "checkUserOnlineOrOffLine")
								  .done(function( data ) {
									  $.each(data, function (index, itemData) {
										   $("#updateDate"+itemData.id).html("Date : "+itemData.timestamp);
										});
								  }); 
								}, 2000);
							
						});
	</script>

</body>
</html>