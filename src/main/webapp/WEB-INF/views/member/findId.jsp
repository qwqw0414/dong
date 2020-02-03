<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<h1>아이디 찾기</h1>
<div id="formDiv">
	<form id="findIdFrm" method="post" >
  	<div class="form-group">
    	<label for="exampleInputEmail1">이름</label>
    	<input type="text" class="form-control" name="name" id="memberName" aria-describedby="emailHelp">
  	</div>
  	<div class="form-group">
    	<label for="exampleInputPassword1">이메일</label>
    	<input type="email" class="form-control" name="email" id="memberEmail">
  	</div>
  	<button type="button" class="btn btn-primary btn-findId">아이디찾기</button>
	</form>
</div>
<div id="findId-result"></div>

<script>
	$("#findIdFrm .btn-findId").click(function(){
		
		var name = $("#memberName").val().trim();
		var email = $("#memberEmail").val().trim();
		
		if(name.length == 0 || email.length == 0){
			alert("모두 입력해");
			return false;
		}
		
		$("#formDiv").hide();
		$.ajax({
			url : "${pageContext.request.contextPath}/member/findIdEnd",
			data : $("#findIdFrm").serialize(),
			dataType : "json",
			//type : "GET", 
			success : data => {
				console.log(data);
				var findId = $("<h1></h1>");
				if(data != null){
					findId.append(data.memberName+"님의 아이디는 "+data.memberId+"입니다.");
				}
				else{
					findId.append("입력하신 정보의 회원은 존재하지 않습니다.");
				}
				$("#findId-result").html(findId);
			},
			error : (x, s, e) => {
				console.log("ajax 요청 실패!");
			}
		});
	});
	</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>