<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.1.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/js.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/css.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/animation.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.3.0/sockjs.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.js"></script>
<title>동네톡</title>
</head>
<body>

<div class="input-group mb-3">
    <input type="text" id="message" class="form-control" placeholder="Message">
    <div class="input-group-append" style="padding: 0px;">
        <button id="sendBtn" class="btn btn-outline-secondary" type="button">Send</button>
    </div>
</div>
<div>
    <ul class="list-group list-group-flush" id="data">
        <c:forEach items="${chatList}" var="m">
            <li class="list-group-item">${m.memberId }: ${m.msg }</li>
        </c:forEach>
    </ul>
</div>

<script>
$(document).ready(function() {
	$("#sendBtn").click(function() {
		sendMessage();
	});
	$("#message").keydown(function(key) {
		if (key.keyCode == 13) {// 엔터
			sendMessage();
		}
	});

	$(window).on("focus", function() {
		console.log("focus");
		lastCheck();
	});
});

let socket = new SockJS('<c:url value="/stomp" />');
let stompClient = Stomp.over(socket);

stompClient.connect({}, function(frame) {
	console.log('connected stomp over sockjs');
	console.log(frame);
	
	lastCheck();

	stompClient.subscribe('/chat/${chatId}', function(message) {
		console.log("receive from subscribe /chat/${chatId} :", message);
		let messsageBody = JSON.parse(message.body);
		$("#data").append("<li class=\"list-group-item\">"+messsageBody.memberId+" : "+messsageBody.msg+ "</li>");
	});

});

function lastCheck() {
	let data = {
		chatId : "${chatId}",
		memberId : "${memberId}",
		time : new Date().getTime()
	}
	stompClient.send('<c:url value="/lastCheck" />', {}, JSON.stringify(data));
}

function sendMessage() {

    let data = {
        chatId : "${chatId}",
        memberId : "${memberId}",
        msg : $("#message").val(),
        time : new Date().getTime(),
        type: "MESSAGE"
    }
    stompClient.send('<c:url value="/chat/${chatId}" />', {}, JSON.stringify(data));
}

</script>

</body>
</html>