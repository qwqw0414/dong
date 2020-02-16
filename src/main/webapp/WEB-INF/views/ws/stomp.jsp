<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<script type="text/javascript">
$(document).ready(function() {
	$("#sendBtn").click(function() {
		sendMessage();
	});
	$("#message").keydown(function(key) {
		if (key.keyCode == 13) {// 엔터
			sendMessage();
		}
	});

	//window focus이벤트핸들러 등록
	$(window).on("focus", function() {
		console.log("focus");
		lastCheck();
	});
});

//웹소켓 선언
//1.최초 웹소켓 생성 url: /stomp
let socket = new SockJS('<c:url value="/stomp" />');
let stompClient = Stomp.over(socket);

//connection이 맺어지면, 콜백함수가 호출된다.
stompClient.connect({}, function(frame) {
	console.log('connected stomp over sockjs');
	console.log(frame);
	
	//사용자 확인
	lastCheck();
	
	//stomp에서는 구독개념으로 세션을 관리한다. 핸들러 메소드의 @SendTo어노테이션과 상응한다.
	stompClient.subscribe('/hello', function(message) {
		console.log("receive from /hello :", message);
		let messsageBody = JSON.parse(message.body);
		$("#data").append("<li class=\"list-group-item\">"+messsageBody.memberId+" : "+messsageBody.msg+ "</li>");
	}); 

	//stomp에서는 구독개념으로 세션을 관리한다. 핸들러 메소드의 @SendTo어노테이션과 상응한다.
	stompClient.subscribe('/chat/${chatId}', function(message) {
		console.log("receive from subscribe /chat/${chatId} :", message);
		let messsageBody = JSON.parse(message.body);
		$("#data").append("<li class=\"list-group-item\">"+messsageBody.memberId+" : "+messsageBody.msg+ "</li>");
	});

});

function sendMessage() {

	let data = {
		chatId : "${chatId}",
		memberId : "${memberId}",
		msg : $("#message").val(),
		time : new Date().getTime(),
		type: "MESSAGE"
	}

	console.log(data);

	//테스트용 /hello
	stompClient.send('<c:url value="/hello" />', {}, JSON.stringify(data));
	
	//채팅메세지: 1:1채팅을 위해 고유한 chatId를 서버측에서 발급해 관리한다.
	stompClient.send('<c:url value="/chat/${chatId}" />', {}, JSON.stringify(data));
	
	//message창 초기화
	$('#message').val('');
}


/*
 * 윈도우가 활성화 되었을때, chatroom테이블의 lastcheck(number)컬럼을 갱신한다.
 * 안읽은 메세지 읽음 처리
 */ 
function lastCheck() {
    let data = {
        chatId : "${chatId}",
        memberId : "${memberId}",
        time : new Date().getTime()
    }
    stompClient.send('<c:url value="/lastCheck" />', {}, JSON.stringify(data));
}



</script>
</body>
</html>