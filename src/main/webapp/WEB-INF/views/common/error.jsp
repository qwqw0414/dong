<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isErrorPage="true"%>
	<%
	 int statusCode = response.getStatus();
	 String msg = (exception==null)?String.valueOf(statusCode):exception.getMessage();
%>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.4.1.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/css.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/animation.css">

<style>
img{
	display: block;
	margin: 0px auto;
	margin-top: 8vh;
	/* width: 800px; */
}
.error-title{
	position: absolute;
	top: 300px;
	z-index: 1;
	text-align: center;
	width: 100%;
}
.error-title h3{
	color: rgb(49, 169, 190);
	/* font-family: 'BMHANNAPro'; */
}
.error-title h6{
	color:rgb(80, 80, 80);
	/* font-family: 'NanumSquare_acB'; */
}
.error-title h4{
	color:darkslategray;
	/* font-family: 'NanumSquare_acB'; */
}

.error-title button{
	width: 150px;
}
</style>
<div class="row">
	<div class="col">
		<img src="${pageContext.request.contextPath}/resources/images/error-clear.png">
	</div>
</div>
<div class="error-title">
	<h3>죄송합니다. 현재 찾을 수 없는 페이지를 요청 하셨습니다.</h3>
	<br>
	<h6>
		존재하지 않는 주소를 입력하셨거나.<br>
		요청하신 페이지의 주소가 변경, 삭제되어 찾을 수 없습니다.<br>
		궁금한 점이 있으시면 언제든 고객센터를 통해 문의해 주시기 바랍니다.<br>
		<br>
	</h6>
	<h4>감사합니다.</h4>
	<br>
	<div class="row">
		<div class="col text-right">
			<button class="btn btn-outline-secondary" id="btn-main">메인으로</button>
		</div>
		<div class="col text-left">
			<button class="btn btn-outline-secondary" id="btn-back">이전 페이지</button>
		</div>
	</div>
</div>
<script>
$("#btn-main").click(()=>{
	location.href = "${pageContext.request.contextPath}";
})
$("#btn-back").click(()=>{
	// 임시
	window.history.back();
})
</script>