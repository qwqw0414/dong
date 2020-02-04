<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<style>
#loggin-btn{margin-right: 60px}
</style>

<%
	//아이디 저장
	boolean saveId = false;
	String memberId = "";
	Cookie[] cookies = request.getCookies();
	
	if(cookies != null){
		for(Cookie c : cookies){
			String k = c.getName();	
			String v = c.getValue();
			System.out.println(k + " = " + v);
			System.out.println("cccccccccc111 = " + c);
			if("saveId".equals(k)){
				saveId = true;
				memberId = v;
			}
		}
	}
%>

<div id="memberLogin" >

	<h1>로그인</h1>
	<form action="${pageContext.request.contextPath}/member/memberLoginId.do" method="post">
	<div class="login-form" id="loginPage">
		<input type="text" name="memberId" id="memberId" placeholder="로그인할 아이디를 입력해주세요." class="form-control form-control-lg"
		value="<%=saveId?memberId:""%>"/>
		<br />
		<input type="password" name="password" id="password" placeholder="비밀번호를 입력해주세요." class="form-control form-control-lg"/>
	</div>
	
	<div class="enroll-btn custom-control custom-checkbox" >
		<button type="submit" id="loggin-btn" class="btn btn-outline-primary btn-lg btn-pre">로그인</button>
 		<input type="checkbox" class="custom-control-input" id="saveId" name="saveId" <%=saveId?"checked":"" %>>
  		<label class="custom-control-label" for="saveId" >아이디 저장</label>
	</div>
	
	
	</form>
</div>



<jsp:include page="/WEB-INF/views/common/footer.jsp"/>