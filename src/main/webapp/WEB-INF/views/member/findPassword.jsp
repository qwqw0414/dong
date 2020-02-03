<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<h1>비밀번호 찾기</h1>
<div id="pwdFrm">
<form action="${pageContext.request.contextPath}/member/findPasswordEnd.do" method="post">
    <div class="form-group">
    <label for="exampleInputPassword1">아이디</label>
    <input type="text" class="form-control" name="memberId" id="id" required>
  </div>
  <div class="form-group">
    <label for="exampleInputPassword1">이메일</label>
    <input type="email" class="form-control" name="email" id="email" required>
  </div>
<button type="submit" class="btn btn-primary" id="btn-pwdFrm">확인</button>
</form>

<div id="pwdUpdateFrm">
<form action="${pageContext.request.contextPath}/member/passwordUpdate.do" method="post">
    <div class="form-group">
    <label for="exampleInputPassword1">비밀번호</label>
    <input type="password" class="form-control" name="pwd" id="pwd" required>
  </div>
    <input type="hidden" class="form-control" name="memberId" id="memberId" required>
  <div class="form-group">
    <label for="exampleInputPassword1">비밀번호 확인</label>
    <input type="password" class="form-control" name="pwdChk" id="pwdChk" required>
  </div>
<button type="submit" class="btn btn-primary" id="btn-pwdUpdate">변경</button>
</form>
</div>

</div>
<script>
$("#pwdFrm #btn-pwdFrm").click(()=>{
	$.ajax({
		url: "${pageContext.request.contextPath}/member/passwordUpdate",
		data: $("#pwdUpdateFrm").serialize(),
		dataType:"json",
		type: "POST",
		success: data => {
			console.log(data);
			
		},
		error(x,s,e) => {
			console.log("ajax요청 실패!",x,s,e);
		}
	});
}); 

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>