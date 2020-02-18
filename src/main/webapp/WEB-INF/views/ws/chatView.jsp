<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<style>
#chatList{
	width: 100%;
	height: 540px;
	margin-top: 50px;
	padding: 10px 10px 0 10px;
	overflow: scroll;
	overflow-x:hidden;
	background-color: rgb(241, 241, 241);
}
.chat{
	/* font-family: 'MapoPeacefull' */
}
#sendMsg{
	padding: 0 10px 0 10px;
}
</style>
</head>
<body>

<div class="input-group mb-3 fixed-bottom" id="sendMsg">
    <input type="text" id="message" class="form-control" maxlength="20">
    <div class="input-group-append" style="padding: 0px;">
        <button id="sendBtn" class="btn btn-outline-secondary" type="button">보내기</button>
    </div>
</div>
<nav class="navbar navbar-dark bg-dark fixed-top">
	<h4><a href="javascript:goShop()" class="badge badge-warning">${sendId} 상점 바로가기</a></h4>
	<button class="btn btn-dark" id="btn-back">뒤로</button>
</nav>

<!-- <div id="chat">
	<ul class="list-group list-group-flush" id="data">
        <c:forEach items="${chatList}" var="m">
            <li class="list-group-item">${m.memberId }: ${m.msg }</li>
        </c:forEach>
    </ul>
</div> -->

<div id="chatList">
	<c:forEach items="${chatList}" var="m">
		<div class="chat">
			<c:if test="${memberId eq m.memberId}">
				<div class="text-right">
					<h4><span class="badge badge-dark">
							${m.msg}
			</c:if>

			<c:if test="${memberId ne m.memberId}">
				<div class="text-left">
					<h4><span class="badge badge-warning">
							${m.msg}
			</c:if>

				</span></h4>
			</div>
		</div>
	</c:forEach>
</div>

<script>
$(()=>{
	$("#btn-back").click(()=>{
		location.href = "${pageContext.request.contextPath}/ws/admin.do";
	})

	$("#chatList").scrollTop($("#chatList").find(".chat").length*60);
})
function goShop(){
	opener.parent.location.replace("${pageContext.request.contextPath}/shop/shopView.do?shopNo=${shopNo}");
}

function showMsg(msg,writeId){
	var memberId = '${memberId}';
	var $chatList = $("#chatList");
	var $message = $("#message");
	let index = $chatList.find(".chat").length;

	console.log(index);

	$chatList.animate({ scrollTop: index*50 }, "slow");

	let html = "";
	html += '<div class="chat">';

	if (writeId == memberId) {
		html += '<div class="text-right">';
		html += '<h4><span class="badge badge-dark">';
	}
	else {
		html += '<div class="text-left">';
		html += '<h4><span class="badge badge-warning">';
	}
	html += msg;
	html += '</span></h4></div>';

	$message.val('').focus();
	$chatList.append(html);
}

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
		// $("#data").append("<li class=\"list-group-item\">"+messsageBody.memberId+" : "+messsageBody.msg+ "</li>");
		showMsg(messsageBody.msg,messsageBody.memberId);
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