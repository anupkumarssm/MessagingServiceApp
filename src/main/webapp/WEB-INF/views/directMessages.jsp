<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<body>
<style> 
.notification { 
 padding: 20px 26px;
  position: relative;
  display: inline-block;
  border-radius: 2px;
} 
.notification .badge {
  position: absolute;
  top: 8px;
  right: -10px;
  padding: 5px 15px;
  border-radius: 50%;
  background-color: red;
  color: white;
}
</style>
	<div class="row">
		<div class="col-md-6">
			<h4>Direct Messages</h4>
		</div>
		<div class="col-md-6">
			<input type="text" class="form-control searchContacts"
				placeholder="Search contacts" id="searchContacts">
		</div>
	</div>
	<div class="card">
		<div class="card-body" style="height: 400px; overflow-y: scroll">
			<ul class="list-group list-group-flush" style="cursor: pointer">
				<c:forEach items="${getAllMessages}" var="messages">
					<li class="list-group-item getusername" data-toMobile="${messages.toMobile}"><div
							class="paragraphs">
							<div class="row">
								<div class="span4" id="spanDiv${messages.id}">
									<div class="content-heading">
										<a href="#" class="notification">
										 <i class="fa fa-user-plus" aria-hidden="true">&nbsp;${messages.toFullname}</i> <c:if test="${messages.messageCount ne '0'}"><span class="badge" id="messageCountValue${messages.id}">${messages.messageCount}</span></c:if>
										</a> 
									</div>
									<p style="clear: both; width: 1200px; color:green;"><b id="updateDate${messages.id}">Date : ${messages.timestamp}</b></p>
								</div>
							</div>
						</div></li>
				</c:forEach> 
				<c:if test="${empty getAllMessages}"><h5 align="center" style="color: gray;"><b>No Chats</b></h5></c:if>
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
	left: 71%;
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
												window.location.href = 'get-direct-messages?toMobile='
														+ tousername;
											});
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
													var data = ${getAllContacts};
													response(data);
												},
												select : function(event, ui) {
													$("#searchContacts").val(
															ui.item.label); //ui.item is your object from the array
													window.location.href = 'get-direct-messages?toMobile='
															+ ui.item.value;
													return false;
												}
											});
							
							 window.setInterval(function(){
								 $.get( "checkUserOnlineOrOffLine")
								  .done(function( data ) {
									  $.each(data, function (index, itemData) { 
										   $("#updateDate"+itemData.id).html("Date : "+itemData.timestamp);
										   $("#messageCountValue"+itemData.id).html(itemData.messageCount);
										});
								  }); 
								}, 2000);
							
						});
	</script>

</body>
</html>