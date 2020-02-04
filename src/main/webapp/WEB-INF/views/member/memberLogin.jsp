<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

 <style>
        /* #memberLogin-container{
            border-top: solid green 2px;
            border-bottom: solid green 2px;
        } */
        #memberLogin-content{
            width: 500px;
            height: 550px;
            margin: 0 auto;
            border-top: solid green 2px;
            border-bottom: solid green 2px;
        }
        #memberLogin-content h1{
            padding-top: 50px;
            padding-bottom: 60px;
        }
        #memberLogin-content #memberId {
            width: 500px;
            margin: 0 auto;
        }
        #memberLogin-content #password {
            width: 500px;
            margin: 0 auto;
        }
        #memberLogin-content .custom-checkbox {
            padding-right: 365px;
        }
         #login-bottom a{
            text-decoration: none;
            color: gray;
        }
      

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

<div id="memberLogin-container" class="text-center" >
	<div id="memberLogin-content">
	<h1>로그인</h1>
	<form action="${pageContext.request.contextPath}/member/memberLoginId.do" method="post">
	<div class="login-form" id="loginPage">
		<input type="text" name="memberId" id="memberId" placeholder="로그인할 아이디를 입력해주세요." class="form-control form-control-lg"
		value="<%=saveId?memberId:""%>"/>
		
        <br />
		<input type="password" name="password" id="password" placeholder="비밀번호를 입력해주세요." class="form-control form-control-lg"/>
	</div>
		<br />
		<br />
		<button type="submit" id="loggin-btn" class="btn btn-outline-success btn-lg btn-block">로그인</button>
		
		<div class="custom-checkbox " id="login-checkbox">
                <input type="checkbox" class="custom-control-input " id="saveId" name="saveId" <%=saveId?"checked":"" %>>
                <label class="custom-control-label" for="saveId" >아이디 저장</label>
        </div>
		<br />
		<hr />
		<div id="login-bottom">
			<a href="${pageContext.request.contextPath}/member/findId.do">아이디 찾기 &nbsp | &nbsp   </a>
			<a href="${pageContext.request.contextPath}/member/findPassword.do">비밀번호 찾기 &nbsp | &nbsp</a>
			<a href="${pageContext.request.contextPath}/member/memberEnroll.do">회원가입</a>
		</div>
	
	</form>
</div>
</div>



<jsp:include page="/WEB-INF/views/common/footer.jsp"/>