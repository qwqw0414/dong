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
#shopView-nav {width: 1000px; border: 1px solid black;}
#shopView-nav ul{list-style:none; margin:0; padding:0;}
#shopView-nav li{float: left;}
#shopView-nav ul li div{width: 150px;}
</style>

<div id="shopView-nav">
	<div>
		<ul>
			<li><div>내 상품</div></li>
			<li><div>상점문의</div></li>
			<li><div>찜 목록</div></li>
			<li><div>상점후기</div></li>
			<li><div>팔로우</div></li>
			<li><div>팔로워</div></li>
		</ul>
	</div>

	<div>
		<h1>내 상품</h1>
	</div>
	<div>
		<h1>상점 문의</h1>
	</div>
	<div>
		<h1>찜</h1>
	</div>
	<div>
		<h1>상점 후기</h1>
	</div>
	<div>
		<h1>팔로잉</h1>
	</div>
</div>





<jsp:include page="/WEB-INF/views/common/footer.jsp"/>