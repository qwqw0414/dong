<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<h1>비밀번호 찾기</h1>
<div id="pwdFrm">
	<div class="form-group">
		<label for="exampleInputPassword1">아이디</label>
		<input type="text" class="form-control" id="passwordMemberId" required>
	</div>
	<div class="form-group">
		<label for="exampleInputPassword1">이메일</label>
		<input type="email" class="form-control" id="passwordEmail" required>
	</div>
	<button type="submit" class="btn btn-primary" id="btn-Update">비밀번호 변경</button>
	<button class="btn btn-primary returnIndex">돌아가기</button>
</div>

<div id="pwdUpdateFrm">
	<div class="form-group">
		<label for="exampleInputPassword1">비밀번호</label>
		<input type="password" class="form-control" id="findPassword" required>
	</div>
	<input type="hidden" class="form-control" id="passwordMemberId" required>
	<div class="form-group">
		<label for="exampleInputPassword1">비밀번호 확인</label>
		<input type="password" class="form-control" id="passwordCheck" required>
	</div>
	<button type="submit" class="btn btn-primary" id="btn-pwdUpdate">변경</button>
	<button class="btn btn-primary returnIndex">변경 취소</button>
	
</div>


<script>
$(".returnIndex").click(function(){
	location.href = "${pageContext.request.contextPath}/";
});

$(document).on("click",".returnIndex",function(){
	location.href = "${pageContext.request.contextPath}/";
});
	
	$(function () {
		$("#pwdUpdateFrm").hide();
	});


	$(() => {
		var $memberId = $("#pwdFrm #passwordMemberId");
		var $email = $("#pwdFrm #passwordEmail");
		var $pwd = $("#pwdUpdateFrm #findPassword");
		var $pwdChk = $("#pwdUpdateFrm #passwordCheck");


		$("#pwdFrm #btn-Update").click(function () {

			$.ajax({
				url: "${pageContext.request.contextPath}/member/findPasswordEnd",
				data: {
					memberId: $memberId.val(),
					email: $email.val()
				},
				dataType: "json",
				type: "GET",
				success: data => {
					console.log(data);
					if (data > 0) {
						$("#pwdFrm").hide();
						$("#pwdUpdateFrm").show();
						$("#pwdUpdateFrm #passwordMemberId").val($memberId.val());
					} else {
						console.log("입력한 값 없음");
					}

				}, error: (x, s, e) => {
					console.log("ajax요청 실패!", x, s, e);
				}
			});
		});


		$("#pwdUpdateFrm #btn-pwdUpdate").click(function () {
			var regExpPw = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g;

			// 		비밀번호 유효성 검사
			if ($pwd.val().length == 0) {
				alert("변경할 비밀번호를 입력하세요.");
				$pwd.focus();
				return;
			}

			if ($pwdChk.val().length == 0) {
				alert("변경할 비밀번호를 입력하세요.");
				$pwdChk.focus();
				return;
			}

			if (!regExpPw.test($pwd.val())) {
				alert("비밀번호 형식이 올바르지 않습니다..");
				$pwd.focus();
				return;
			}

			if ($pwd.val() !== $pwdChk.val()) {
				alert("입력하신 비밀번호가 서로 일치하지 않습니다.");
				$pwdChk.focus();
				return;
			}

			$.ajax({
				url: "${pageContext.request.contextPath}/member/passwordUpdate",
				data: {
					memberId: $("#pwdUpdateFrm #passwordMemberId").val(),
					password: $pwd.val()
				},
				dataType: "json",
				type: "POST",
				success: data => {
					console.log(data);
					if (data > 0) {
						console.log("변경 성공");
						location.href = "/dong";
					} else {
						console.log("비밀번호 변경 실패");
						location.href = "/dong/member";
					}

				}, error(x, s, e) {
					console.log("비밀번호 변경 ajax요청 실패!", x, s, e);
				}
			});

		});
	});



</script>