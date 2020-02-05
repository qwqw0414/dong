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
	display: inline-block;
}
#shopImg1{
	width: 300px;
	height: 400px;
	display: inline-block;
}
#shopInfoDiv{
	width: 1100px;
	height: 300px;
	display: inline-block;
}
#shopImageDiv{
	display: inline-block;
	position: relative;
	top: -130px;
}
#shopDetailInfoDiv{
	display: inline-block;
	position: relative;
	left: 80px;
	top: 50px;
}
</style>

<input type="hidden" name="memberLoggedIn" value="<%= memberLoggedIn.getMemberId()%>"/>

 <div id="shopView" class="mx-center">
	<div id="shopDiv">
		<div id="shopImageDiv">
			<img id="shopImg1" src="${pageContext.request.contextPath}/resources/images/dog.png" alt="" />
		</div>
		<div id="shopDetailInfoDiv">
			${map.SHOP_NAME} &nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-outline-success btn-sm">수정</button><br /><br />
			<img src="https://assets.bunjang.co.kr/bunny_desktop/images/shop-open@2x.png" width="14" height="13">상점오픈일 ${map.SINCE} 일 전
			&nbsp;&nbsp;&nbsp;
			<img src="https://assets.bunjang.co.kr/bunny_desktop/images/shop-user@2x.png" width="14" height="13">상점방문수 10명
			&nbsp;&nbsp;&nbsp;
			<img src="https://assets.bunjang.co.kr/bunny_desktop/images/shop-sell@2x.png" width="14" height="13">상품판매 0회
			&nbsp;&nbsp;&nbsp;
			<img src="https://assets.bunjang.co.kr/bunny_desktop/images/shop-dell@2x.png" width="14" height="13">택배발송 2회
			<br /><br /><span id="shopInfoDetail">${map.SHOP_INFO}</span> &nbsp;&nbsp;&nbsp;
			<button id="hiddenBtn" onclick="updateInfo();" type="button" class="btn btn-outline-success btn-sm">수정</button><br />
			<textarea  name="updateInfo" id="updateInfo" cols="30" rows="10">${map.SHOP_INFO }</textarea>
			<button  type="button" class="btn btn-outline-success btn-sm">수정</button><br />
		</div>
	</div>
	<script>
	$(function(){
		var $textarea = $("#updateInfo");
		$textarea.hide();
		
	});
	
	function updateInfo(){
		var $btn = $("#hiddenBtn");
		var $info = $("#shopInfoDetail");
		console.log($btn);
		console.log($info);
		$btn.hide();
		$info.hide();
	}
	
	
	/* function updateShopInfo(){
		var memberId = $("[name=memberLoggedIn]").val();
		$.ajax({
			url : "${pageContext.request.contextPath}/shop/updateShopInfo",
			data : {memberId : memberId}
			success : data => {
				console.log(data);
								
			},
			error : (x, s, e) => {
				console.log("ajax 요청 실패!");
			}
		});
	}; */
	</script>
	
	<!-- 넘어오면 다 내꺼 -->
	<style>
	#shopView-nav {}
	#shopView-nav ul{list-style:none; margin:0; padding:0;}
	#shopView-nav li{float: left;}
	#shopView-nav ul li div{width: 183px; font-size: 1em; text-align: center; padding: 15px;}
	#shopView-nav .shop-nav-selected{border: 1px black  solid; border-bottom: 0px; font-weight: bold;}
	#shopView-nav .shop-nav-disabled{border: 1px gray solid; border-bottom: 1px black soid; background-color: rgba(238, 243, 243); color: rgb(90, 90, 90); opacity: 0.8;}
	#shopView-nav .shop-nav{cursor: pointer;}
	#shopView-nav #shop-contents{margin-top: 80px;}
	</style>
	
	<div id="shopView-nav">
		<div style="height: 20px;">
			<ul>
				<li><div class="shop-nav-selected shop-nav">내 상품</div></li>
				<li><div class="shop-nav-disabled shop-nav">상점문의</div></li>
				<li><div class="shop-nav-disabled shop-nav">찜 목록</div></li>
				<li><div class="shop-nav-disabled shop-nav">상점후기</div></li>
				<li><div class="shop-nav-disabled shop-nav">팔로우</div></li>
				<li><div class="shop-nav-disabled shop-nav">팔로워</div></li>
			</ul>
		</div>
	
		<div id="shop-contents">
			<div id="nav-product">
				<h1>내 상품</h1>
			</div>
			<div id="nav-inquiry">
				<h1>상점 문의</h1>
			</div>
			<div id="nav-wishlist">
				<h1>찜</h1>
			</div>
			<div id="nav-review">
				<h1>상점 후기</h1>
			</div>
			<div id="nav-follow">
				<h1>팔로우</h1>
			</div>
			<div id="nav-follower">
				<h1>팔로워</h1>
			</div>
		</div>
	</div>

 </div>

<script>
$(()=>{
	var $shopNav = $("#shopView-nav .shop-nav");

	$("#shopView-nav #shop-contents").children().hide();
	$("#shopView-nav #nav-product").show();

	$("#shopView-nav .shop-nav").click((e)=>{
		
		try {
			$shopNav.removeClass("shop-nav-selected");
			$shopNav.addClass("shop-nav-disabled");
			$(e.target).removeClass("shop-nav-disabled");
			$(e.target).addClass("shop-nav-selected");
		} catch (error) {}

		$(e.target).html()

		$("#shopView-nav #shop-contents").children().hide();

		console.log($(e.target).attr("id"));

		switch ($(e.target).text()) {
			case "내 상품": $("#shopView-nav #nav-product").show();break;
			case "상점문의": $("#shopView-nav #nav-inquiry").show();break;
			case "찜 목록": $("#shopView-nav #nav-wishlist").show();break;
			case "상점후기": $("#shopView-nav #nav-review").show();break;
			case "팔로우": $("#shopView-nav #nav-follow").show();break;
			case "팔로워": $("#shopView-nav #nav-follower").show();break;
		}
	})



});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>