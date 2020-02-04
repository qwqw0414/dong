<%@page import="java.util.Date"%>
<%@page import="com.pro.dong.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<%
	Member memberLoggedIn = (Member)request.getSession().getAttribute("memberLoggedIn");
%>
<style>
#shopView{width: 1100px;}
#shopDiv{
	margin-bottom: 50px;
}
#shopImg{
	width: 300px;
	height: 300px;
	display: inline-block;
}
#shopInfoDiv{
	width: 1100px;
	height: 300px;
	background: orange;
}
</style>

<input type="hidden" name="memberLoggedIn" value="<%= memberLoggedIn.getMemberId()%>"/>

 <div id="shopView" class="mx-center">
	<div id="shopDiv">
		<div id="shopInfoDiv">
			<img id="shopImg" src="${pageContext.request.contextPath}/resources/images/dog.png" alt="" />
			<img src="https://assets.bunjang.co.kr/bunny_desktop/images/shop-open@2x.png" width="14" height="13">상점오픈일 ${map.SINCE} 일 전
				${map.SHOP_INFO}
			
		</div>
	</div>
	
			<div class="sc-cZBZkQ kdAIzz">
			<div class="sc-ecaExY gIQILP">
			</div>
			<div class="sc-ecaExY gIQILP">
			<img src="https://assets.bunjang.co.kr/bunny_desktop/images/shop-user@2x.png" width="14" height="13" alt="상점방문수 아이콘">상점방문수<div class="sc-gbzWSY gvMbZA">3,450 명</div>
			</div>
			<div class="sc-ecaExY gIQILP">
			<img src="https://assets.bunjang.co.kr/bunny_desktop/images/shop-sell@2x.png" width="14" height="13" alt="상품판매 아이콘">상품판매<div class="sc-gbzWSY gvMbZA">0 회</div>
			</div>
			<div class="sc-ecaExY gIQILP">
			<img src="https://assets.bunjang.co.kr/bunny_desktop/images/shop-dell@2x.png" width="14" height="13" alt="상퓸발송 아이콘">택배발송<div class="sc-gbzWSY gvMbZA">2 회</div>
			</div>
			</div>
			<div class="sc-jqIZGH fizQpi">
			</div>
			<div class="sc-jGxEUC ecWIjT"><button class="sc-ESoVU ldCXVj">소개글 수정</button>
			</div>
			</div>
	
	<!-- 넘어오면 다 내꺼 -->
	<style>
	#shopView-nav {border: 1px solid black;}
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

 </div>







<jsp:include page="/WEB-INF/views/common/footer.jsp"/>