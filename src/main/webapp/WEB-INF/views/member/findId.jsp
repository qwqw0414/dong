<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<h1>아이디 찾기</h1>
<div id="form-idSearch">
	<div class="form-group">
		<label for="exampleInputEmail1">이름</label>
		<input type="text" class="form-control" name="name" id="IDmemberName" aria-describedby="emailHelp">
	</div>
	<div class="form-group">
		<label for="exampleInputPassword1">이메일</label>
		<input type="email" class="form-control" name="email" id="memberEmail">
	</div>
	<button type="button" class="btn btn-primary btn-findId">아이디찾기</button>
	<button type="button" class="btn btn-primary returnIndex">취소</button>
</div>
<div id="findId-result"></div>

<script>
	$("#form-idSearch .btn-findId").click(function () {

		var name = $("#IDmemberName").val().trim();
		var email = $("#memberEmail").val().trim();
		var $btn = $("#findId-btn");

		 if (name.length == 0) {
			alert("이름을 입력해주세요.");
			return false;
		}  
		 else if(email.length == 0){
			alert("이메일을 입력해주세요");
			return false;
		 }
		 
		$("#form-idSearch").hide();
		$.ajax({
			url: "${pageContext.request.contextPath}/member/findIdEnd",
			data: {
				memberName: name,
				email: email
			},
			dataType: "json",
			type: "GET",
			success: data => {
				console.log(data);
				var findId = $("<h2></h2>");
				if (data == null) {
					findId.append("입력하신 정보의 회원은 존재하지 않습니다.<br>");
					findId.append("<button class='"+"btn btn-primary returnIndex"+"'>돌아가기</button>");
				}
				else {
					findId.append(data.memberName + "님의 아이디는 " + data.memberId + "입니다.<br>");
					findId.append("<button class='"+"btn btn-primary returnIndex"+"'>로그인하기</button>");
				}
				$("#findId-result").html(findId);
			},
			error: (x, s, e) => {
				console.log("ajax 요청 실패!");
			}
		});
	});
	$(".returnIndex").click(function(){
		location.href = "${pageContext.request.contextPath}/";
	});
	$(document).on("click",".returnIndex",function(){
		location.href = "${pageContext.request.contextPath}/";
	});
</script>