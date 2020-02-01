<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>


<div id="memberLogin" class="text-center">

	<h1>로그인</h1>
	<form action="${pageContext.request.contextPath}/member/memberLoginId.do" method="post">
	<div class="login-form" id="loginPage">
		<input type="text" name="memberId" id="memberId" placeholder="로그인할 아이디를 입력해주세요." class="form-control form-control-lg"/>
		<br />
		<input type="password" name="password" id="password" placeholder="비밀번호를 입력해주세요." class="form-control form-control-lg"/>
	</div>
	
	<div class="enroll-btn" >
		<button type="submit" class="btn btn-outline-primary btn-lg btn-pre">로그인</button>
	</div>
	</form>
</div>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>