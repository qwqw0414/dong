<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<h1>아이디 찾기</h1>
<div id="formDiv">
	<form id="findIdFrm" method="post">
  	<div class="form-group">
    	<label for="exampleInputEmail1">이름</label>
    	<input type="text" class="form-control" name="memberName" id="memberName" aria-describedby="emailHelp" required>
  	</div>
  	<div class="form-group">
    	<label for="exampleInputPassword1">이메일</label>
    	<input type="email" class="form-control" name="memberEmail" id="memberEmail" required>
  	</div>
  	<button type="submit" class="btn btn-primary btn-findId">아이디찾기</button>
	</form>
</div>
<div id="findId-result"></div>

<script>
	$("#findIdFrm .btn-findId").click(function(){
		$("#formDiv").hide();
		$.ajax({
			url : "${pageContext.request.contextPath}/member/findIdEnd.do",
			data : $("#findIdFrm").serialize(),
			dataType : "json",
			type : "GET", 
			success : data => {
				console.log(data);
				var findId = $("<h1></h1>");
				if(data == null){
					findId.append("입력하신 정보의 회원은 존재하지 않습니다.");
				}
				else{
					findId.append(data.memberName+"님의 아이디는 "+data.memberId+"입니다.");
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