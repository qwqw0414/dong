<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>


<style>

</style>

 <h1>회원탈퇴</h1>
    

	<form action="${pageContext.request.contextPath}/member/memberByeForm.do" method="post">
		<div class="bye-form">
        	<input type="password" id="password" name="password" placeholder="Password" class="form-control form-control-lg">
        	<input type="hidden" id="memberId" name="memberId" value="${memberLoggedIn.memberId}">
    	</div>
		<div class="bye-btn">
        	<button type="submit" class="btn btn-outline-primary btn-lg">탈퇴</button>
  	  	</div>
	</form>


















<jsp:include page="/WEB-INF/views/common/footer.jsp"/>