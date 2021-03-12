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
	<div class="col-12 px-0">
		<div class="px-4 py-5 chat-box bg-white" id="chat-box">
			<c:forEach items="${directMessages}" var="directMessage">
				<c:if test="${directMessage.from_username eq username}">
					<!-- Sender Message-->
					<div class="media w-50 mb-3">
						<i class="fas fa-user"></i>
						<div class="media-body ml-3">
							<div class="bg-light rounded py-2 px-3 mb-2">
								<p class="text-small mb-0 text-muted">${directMessage.text_message}</p>
							</div>
							<p class="small text-muted">${directMessage.timestamp}</p>
						</div>
					</div>
				</c:if>
				<c:if test="${directMessage.from_username ne username}">
					<!-- Reciever Message-->
					<div class="media w-50 ml-auto mb-3">
						<div class="media-body">
							<div class="bg-primary rounded py-2 px-3 mb-2">
								<p class="text-small mb-0 text-white">${directMessage.text_message}</p>
							</div>
							<p class="small text-muted">${directMessage.timestamp}</p>
						</div>
					</div>
				</c:if>
			</c:forEach>
		</div>
	</div>
	 
	<script type="text/javascript">
      $(document).ready(function() {
      var element = document.getElementById("chat-box");
      element.scrollTop = element.scrollHeight;
	  }); 
      </script>
</body>
</html>