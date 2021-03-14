<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<body>
	<div class="card">
		<div class="card-header">
			<div class="row">
				<div class="span4"> 
					<div class="content-heading">
						<h5>
							<a href="direct-messages"><i class="fas fa-arrow-left"> Messages&nbsp;&nbsp;</i></a><b style="color: green;">${contactDetails.timestamp}</b>&nbsp;&nbsp;&nbsp;<i class="fas fa-user"></i>&nbsp;${contactDetails.to_fullname}&nbsp;&nbsp;&nbsp;<i class="fas fa-mobile"></i>(+91)&nbsp;${contactDetails.to_mobile}
						</h5> 
					</div>
				</div>
			</div>
		</div>
		<div class="card-body" style="height: 400px;">
		<div id="showMessage"></div>
		</div>
		<div class="card-footer">
			<div class="row">
				<div class="col-12 col-sm-10 col-md-10 col-lg-10 my-1">
					<input class="form-control" type="text"
						placeholder="Message ${contactDetails.to_fullname}"
						id="textMessage">
				</div>
				<div class="col-12 col-sm-2 col-md-2 col-lg-2 my-1" align="center">
					<button class="form-control col-6" style="color: green;" id="sendBtn">
						Go&nbsp;<i class="fa fa-paper-plane" aria-hidden="true"></i>
					</button>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		$(document).ready(function() {
		 	 getUpdatedMessageFunc()
			var intervalId = window.setInterval(function(){
				getUpdatedMessageFunc()
				}, 2000); 
				
				  setInterval(function(){ 	getUpdatedMessageFunc() }, 3000);
			
			$(document).on("click", "#sendBtn", function() {
				var textMessage = $("#textMessage").val();
				if(textMessage != ''){
				  	$.get("addMessage",
							  {
						toFullname: "${contactDetails.to_fullname}",
						toMobile: " ${contactDetails.to_mobile}",
						toUsername: "${contactDetails.to_mobile}",
						textMessage : textMessage
						
							  },
							  function(data, status){
							    $("#showMessage").html(data);
							  });
					 $("#textMessage").val('')
				}else{
					alert("Please enter a message");
				}
			});
		});
		
	 	function getUpdatedMessageFunc(){
			 $.get( "getNewMessages", { tousername: "${contactDetails.to_mobile}"} )
			  .done(function( data ) {
				  $("#showMessage").html(data);
			  }); 
		}
	</script>
</body>
</html>