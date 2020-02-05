<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//아이디 저장
boolean saveId = false;
String memberId = "";
Cookie[] cookies = request.getCookies();

if(cookies != null){
	for(Cookie c : cookies){
		String k = c.getName();	
		String v = c.getValue();
		if("saveId".equals(k)){
			saveId = true;
			memberId = v;
		}
	}
}
%>
<div id="memberLogin-container" class="text-center">
	<div id="memberLogin-content">
		<h1>로그인</h1>
		<form action="${pageContext.request.contextPath}/member/memberLoginId.do" method="post">
			<div class="login-form" id="loginPage">
				<input type="text" name="memberId" id="memberId" placeholder="로그인할 아이디를 입력해주세요."
					class="form-control form-control-lg" value="<%=saveId?memberId:""%>" />

				<br />
				<input type="password" name="password" id="password" placeholder="비밀번호를 입력해주세요."
					class="form-control form-control-lg" />
			</div>
			<br />
			<br />
			<button type="submit" id="loggin-btn" class="btn btn-outline-success btn-lg btn-block">로그인</button>

			<div class="custom-checkbox " id="login-checkbox">
				<input type="checkbox" class="custom-control-input " id="saveId" name="saveId"
					<%=saveId?"checked":"" %>>
				<label class="custom-control-label" for="saveId">아이디 저장</label>
			</div>
			<br />
			<hr />
		</form>
		<div id="login-bottom">
			<button class="btn page-swap" id="btn-go-enroll">회원가입</button>|
			<button class="btn page-swap" id="btn-go-findId">아이디 찾기</button>|
			<button class="btn page-swap" id="btn-go-findPwd">비밀번호 찾기</button>
		</div>
	</div>
</div>