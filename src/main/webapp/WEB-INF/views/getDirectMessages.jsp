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
		<div class="card-header" id="directContactName"><a href="direct-messages"><i class="fas fa-arrow-left"> Messages&nbsp;&nbsp;</i></a><b style="color: green;">${contactDetails.timestamp}</b>&nbsp;&nbsp;&nbsp;<i class="fas fa-user"></i>&nbsp;${contactDetails.to_fullname}&nbsp;&nbsp;&nbsp;<i class="fas fa-mobile"></i>(+91)&nbsp;${contactDetails.to_mobile}
						</div>
		<div class="card-body1">
			<div class="col-12 px-0">
				<div class="px-4 py-5 chat-box bg-white" id="chat-box">
					<div id="mainMessageBox"></div> 
				</div>
			</div>
		</div>
		<div class="card-footer">
			<div class="row">
				<div class="col-12 col-sm-9 col-md-9 col-lg-9 my-1">
				 <input class="form-control" type="text"
						maxlength="50" placeholder="Message" id="textMessage">
				</div>
				<div class="col-12 col-sm-3 col-md-3 col-lg-3 my-1" align="center">
					<button class="form-control col-6" style="color: green;"
						id="sendBtn"> <i class="fa fa-paper-plane" aria-hidden="true"></i>
					</button>
				</div>
			</div>
		</div>
	</div> 
	<script type="text/javascript">
		$(document)
				.ready(
						function() {
							var element = document.getElementById("chat-box");
							element.scrollTop = element.scrollHeight;
						setInterval(function(){ 
							var tousername = '${contactDetails.to_mobile}';
							var userName = '${username}';  
								$.get( "directMessageListener", {tousername:tousername})
								  .done(function( data) {
									  if(data.length != 0){
										  $.each(data, function (index, itemData) {
									   if(userName == itemData.from_username){
												  var mySecondDiv = $('<div class="media w-50 mb-3"> <i class="fas fa-user">(Me)</i> <div class="media-body ml-3"> <div class="bg-light rounded py-2 px-3 mb-2"> <p class="text-small mb-0 text-muted">'
															+ itemData.text_message
															+ '</p> </div> <p class="small text-muted">Date :'+itemData.timestamp+'</p> </div></div>');
													$('#mainMessageBox').append(
															mySecondDiv); 
											  }else{
												  var reciverBoxDiv = $(' <div class="media w-50 ml-auto mb-3"> <div class="media-body"> <div class="bg-primary rounded py-2 px-3 mb-2"> <p class="text-small mb-0 text-white">'+itemData.text_message+'</p> </div> <p class="small text-muted">Date :'+itemData.timestamp+'</p> </div> </div>');
												  $('#mainMessageBox').append(reciverBoxDiv); 
											  }
											  
										  
										  });
										  var element = document.getElementById("chat-box");
											element.scrollTop = element.scrollHeight;
									  }
								  }); 
							}, 1000);
							
							$(document).on("click","#sendBtn",function() {
								var currentdate = new Date(); 
								var month = (currentdate.getMonth()+1);
								if(month < 10){
									month = "0"+month;
								}  
							    var datetime = currentdate.getFullYear() + "-"   + month  + "-" + currentdate.getDate() + " "
							                + currentdate.getHours() + ":"  
							                + currentdate.getMinutes() + ":" 
							                + currentdate.getSeconds();
							                
												var textMessage = $(
														"#textMessage").val();
												if (textMessage != '') {
													var element = document
															.getElementById("chat-box");
													element.scrollTop = element.scrollHeight;
													
													$.get( "addDirectMessage",{
														toFullname:"${contactDetails.to_fullname}",
														toMobile:" ${contactDetails.to_mobile}",
														toUsername:"${contactDetails.to_mobile}",
														textMessage:textMessage
															  })
													  .done(function( data ) { 
														  if(data == "1"){
															  var mySecondDiv = $('<div class="media w-50 mb-3"> <i class="fas fa-user">(Me)</i> <div class="media-body ml-3"> <div class="bg-light rounded py-2 px-3 mb-2"> <p class="text-small mb-0 text-muted">'
																		+ textMessage
																		+ '</p> </div> <p class="small text-muted">Date : '+datetime+'</p> </div></div>');
																$('#mainMessageBox').append(
																		mySecondDiv);
																 var element = document.getElementById("chat-box");
																	element.scrollTop = element.scrollHeight; 
														  }
													  }); 
													$("#textMessage").val('')
												} else {
													alert("Please enter a message");
												}
											});
							
							getDirectMessageFunc();
						});
		 
		function getDirectMessageFunc(){
			var userName = '${username}';  
			var tousername = '${contactDetails.to_mobile}';
			$.get( "getDirectMessagesData", { tousername:tousername} )
			  .done(function( data ) {
				  $('#mainMessageBox').empty();
				  $.each(data, function (index, itemData) {
					  if(userName == itemData.from_username){
						  var mySecondDiv = $('<div class="media w-50 mb-3"> <i class="fas fa-user">(Me)</i> <div class="media-body ml-3"> <div class="bg-light rounded py-2 px-3 mb-2"> <p class="text-small mb-0 text-muted">'
									+ itemData.text_message
									+ '</p> </div> <p class="small text-muted">Date : '+itemData.timestamp+'</p> </div></div>');
							$('#mainMessageBox').append(
									mySecondDiv); 
					  }else{
						  var reciverBoxDiv = $(' <div class="media w-50 ml-auto mb-3"> <div class="media-body"> <div class="bg-primary rounded py-2 px-3 mb-2"> <p class="text-small mb-0 text-white">'+itemData.text_message+'</p> </div> <p class="small text-muted">Date : '+itemData.timestamp+'</p> </div> </div>');
						  $('#mainMessageBox').append(reciverBoxDiv); 
					  }
					   $("#updateDate"+itemData.id).html("Date : "+itemData.timestamp);
					});
				  var element = document.getElementById("chat-box");
					element.scrollTop = element.scrollHeight; 
			  }); 
			
		}
	</script>
</body>
</html>