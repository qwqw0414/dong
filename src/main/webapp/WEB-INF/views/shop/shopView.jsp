<%@page import="com.pro.dong.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<%
	Member memberLoggedIn = (Member)request.getSession().getAttribute("memberLoggedIn");
	System.out.println("memberLoggedIn="+memberLoggedIn);
%>
<style>
#shopDiv{
	background: yellow;
	margin-bottom: 50px;
}
#shopImg{
	background: red;
}
#shopInfoDiv{
	background: blue;
}
#shopImg{
	width: 200px;
	height: 300px;
}
</style>
 
<div id="shopDiv">
	<div id="shopImgDiv">
		<img id="shopImg" src="${pageContext.request.contextPath}/resources/images/dog.png" alt="" />
		<input type="hidden" name="memberLoggedIn" value="<%= memberLoggedIn.getMemberId()%>"/>
	</div>
	<div id="shopInfoDiv">
		
	</div>
</div>
 
<!-- 넘어오면 다 내꺼 -->
<style>
.size{
	width: 890px;
}
</style>

<ul class="nav nav-tabs size" >

	<li class="nav-item">
		<a class="nav-link " href="#"></a>
	</li>
	<li class="nav-item">
		<a class="nav-link active" href="#">상품</a>
	</li>
	<li class="nav-item">
		<a class="nav-link " href="#"></a>
	</li>
	<li class="nav-item">
		<a class="nav-link " href="#"></a>
	</li>

	<li class="nav-item">
		<a class="nav-link" href="#">상점문의</a>
	</li>
	<li class="nav-item">
		<a class="nav-link " href="#"></a>
	</li>
	<li class="nav-item">
		<a class="nav-link " href="#"></a>
	</li>

	<li class="nav-item">
		<a class="nav-link" href="#">찜</a>
	</li>
	<li class="nav-item">
		<a class="nav-link " href="#"></a>
	</li>
	<li class="nav-item">
		<a class="nav-link " href="#"></a>
	</li>

	<li class="nav-item">
		<a class="nav-link" href="#">상점후기</a>
	</li>
	<li class="nav-item">
		<a class="nav-link " href="#"></a>
	</li>
	<li class="nav-item">
		<a class="nav-link " href="#"></a>
	</li>
	
	<li class="nav-item">
		<a class="nav-link" href="#">팔로우</a>
	</li>
	<li class="nav-item">
		<a class="nav-link " href="#"></a>
	</li>
	<li class="nav-item">
		<a class="nav-link " href="#"></a>
	</li>
	
	<li class="nav-item">
		<a class="nav-link" href="#">팔로워</a>
	</li>
	<li class="nav-item active">
		<a class="nav-link" href="#"></a>
	</li>
	
</ul>




<jsp:include page="/WEB-INF/views/common/footer.jsp"/>