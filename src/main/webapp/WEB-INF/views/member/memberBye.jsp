<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>


<style>

</style>

 <h1>회원탈퇴</h1>
    

	<form action="${pageContext.request.contextPath}/member/memberByeForm.do" method="post">
		<div class="bye-form">
        	<input type="password" id="memberPwdChk" name="memberPwdChk" placeholder="Password" class="form-control form-control-lg">
        	<input type="hidden" id="memberId" name="memberId" value="${memberLoggedIn.memberId}">
    	</div>
		<div class="bye-btn">
        	<button type="submit" class="btn btn-outline-primary btn-lg" onclick="confirmDelete();">탈퇴</button>
  	  	</div>
	</form>

<script>
function confirmDelete(){
	
	var pwd_chk = $("#memberPwdChk").val().trim(); 
	
	console.log("${memberLoggedIn.password}",pwd_chk);
	

	if("${memberLoggedIn.password}" != pwd_chk){
		alert("비밀번호가 틀렸습니다.");
		return;
	}
	<%-- else{
	    var bool = confirm("정말 탈퇴하시겠습니까?");
    	if(bool){
	        location.href = "<%=request.getContextPath() %>/member/memberDeleteEnd?memberId=<%=m.getMemberId()%> ";
    	}
	}  --%>
}
</script>

















<jsp:include page="/WEB-INF/views/common/footer.jsp"/>