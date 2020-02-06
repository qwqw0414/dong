<%@page import="java.util.Date"%>
<%@page import="com.pro.dong.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<%
	Member memberLoggedIn = (Member)request.getSession().getAttribute("memberLoggedIn");
%>
<style>
#shopView{
	width: 1100px;
}
#shopDiv{
	display: inline-block;
	position: relative;
}
#shopImg1{
	width: 200px;
	height: 200px;
	display: inline-block;
	padding: auto;
	/* margin-bottom: 50px; */
	/* border-radius: 50%; */
	/* border: 2px solid black; */
}
#shopInfoDiv{
	width: 1100px;
	height: 300px;
	display: inline-block;
}
#shopDetailInfoDiv{
	display: inline-block;
	position: absolute;
	width: 600px;	
	left: 350px;
	top: 30px;
}
.my-hr3 {
    border: 0;
    height: 3px;
    background: #ccc;
}
#imgUpBtn{
	position: absolute;
	top: 250px;
	left: 120px;
}
#shopImgDiv{
	width: 300px;
	height: 300px;
	border: 2px solid black;
	border-radius: 50%;
	text-align: center;
	padding-top: 35px;
	margin-bottom: 30px;
}
</style>

<input type="hidden" name="memberLoggedIn" value="<%= memberLoggedIn.getMemberId()%>"/>

 <div id="shopView" class="mx-center">
	<div id="shopDiv">
	<div id="shopImgDiv">
	<c:if test="${map.IMAGE == null}">
		<img id="shopImg1" class="img-circle" src="${pageContext.request.contextPath}/resources/upload/shopImage/shopping-store.png" alt="" />
	</c:if>
	<c:if test="${map.IMAGE != null}">
		<img id="shopImg1" class="img-thumbnail" src="${pageContext.request.contextPath}/resources/upload/shopImage/${map.IMAGE}" alt="" />
	</c:if>
	</div>
		<button id="imgUpBtn" type="button" class="btn btn-outline-success btn-sm" data-toggle="modal" data-target="#exampleModal">수정</button>
		<div id="shopDetailInfoDiv">
			<span id="shopNameSpan">asdasdasd</span> &nbsp;&nbsp;&nbsp;<button onclick="shopNameUp();" id="shopNameBtn" type="button" class="btn btn-outline-success btn-sm">수정</button><br /><br />
			<input id="shopNameInput" type="text"  value="${map.SHOP_NAME}"/>
			<button id="shopNameUpdateBtn" onclick="shopNameUpdateEnd();" type="button" class="btn btn-outline-success btn-sm">수정</button>
			<span id="shopNameCheck"></span><br />
			<img src="https://assets.bunjang.co.kr/bunny_desktop/images/shop-open@2x.png" width="14" height="13">상점오픈일 ${map.SINCE} 일째
			&nbsp;&nbsp;&nbsp;
			<img src="https://assets.bunjang.co.kr/bunny_desktop/images/shop-user@2x.png" width="14" height="13">상점방문수 10명
			&nbsp;&nbsp;&nbsp;
			<img src="https://assets.bunjang.co.kr/bunny_desktop/images/shop-sell@2x.png" width="14" height="13">상품판매 0회
			&nbsp;&nbsp;&nbsp;
			<img src="https://assets.bunjang.co.kr/bunny_desktop/images/shop-dell@2x.png" width="14" height="13">택배발송 2회
			<br /><br /><span id="shopInfoDetail">${map.SHOP_INFO}</span> &nbsp;&nbsp;&nbsp;
			<button onclick="showUpdate();" id="hiddenBtn" type="button" class="btn btn-outline-success btn-sm">수정</button><br />
			<textarea  name="updateInfo" id="updateInfo" cols="30" rows="3">${map.SHOP_INFO }</textarea>
			<button onclick="shopUpdateEnd();" type="button" class="btn btn-outline-success btn-sm" id="up_btn">수정</button>
		</div>
	</div>
	
	<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">회원 이미지 등록</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<form id="ajaxFrom" method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath}/shop/shopImageUpload.do" >
			<div class="modal-body">
				<!-- 파일 선택 div -->
				<div class="input-group mb-3" style="padding:0px;">
		  			<div class="input-group-prepend" style="padding:0px;">
		    			<!-- <span class="input-group-text">회원이미지</span> -->
		  			</div>
		  			<div class="custom-file">
		  				<input type="hidden" name="memberId" value="<%=memberLoggedIn.getMemberId() %>" />
		    			<input type="file" class="custom-file-input" name="upFile" id="upShopFile" >
		    			<label class="custom-file-label" for="upFile" id="fileName">파일을 선택하세요</label>
		  			</div>
				</div>
				<!-- 파일 선택 div -->
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
				<button disabled id="shopImgUpdateBtn" type="submit" class="btn btn-primary">수정하기</button>
			</div>
			</form>
		</div>
	</div>
</div>
	
<script>
/* 첨부파일 관련 */
$(function(){
//파일선택 | 취소시에 파일명 노출하기
	$("[name=upFile]").on("change", function(){
		//파일 입력 취소
		if($(this).prop("files")[0] === undefined){
			$(this).next(".custom-file-label").html("파일을 선택하세요.");
			$("#shopImgUpdateBtn").attr("disabled", true);
			return;
		}
		var fileName = $(this).prop('files')[0].name;
		$(this).next(".custom-file-label").html(fileName);
		$("#shopImgUpdateBtn").attr("disabled", false);
		});
	});
	
	function fileUpload(){
		/* var form = $("#ajaxFrom")[0];
		console.log("form="+form);
		
		var formData = new FormData(form);
		formData.append("upShopFile", $("#upShopFile")[0].files[0]);

		
		console.log("formData="+formData); */
		
		/* $.ajax({
			url : "${pageContext.request.contextPath}/shop/shopImageUpload",
			contentType : false,
			enctype: 'multipart/form-data',
			success : data => {
				console.log(data);
			},
			error : (x, s, e) => {
				console.log("ajax 요청 실패!");
			}
		}); */
		//location.href = "${pageContext.request.contextPath}/shop/shopImageUpload.do"
	}
	
	/* 상점수정 관련 */
	$("#shopNameInput").keyup(function() {
		var shopName = $("#shopNameInput").val();
		var memberId = $("[name=memberLoggedIn]").val();
		var currentShopName = $("#shopNameSpan").text();
		$.ajax({
			url : "${pageContext.request.contextPath}/shop/shopNameCheck",
			method : "POST",
			data : {memberId : memberId,
				    shopName : shopName},
			success : data => {
				if(currentShopName == shopName){
					$("#shopNameUpdateBtn").attr("disabled", false);
				}
				else if(shopName.length == 0){
					$("#shopNameCheck").html("상점명을 입력하세요.");
					$("#shopNameCheck").css("color", "red");
					$("#shopNameUpdateBtn").attr("disabled", true);
				}
				else if(data.checkResult == "9"){
					$("#shopNameCheck").html("이미 사용중인 상점명입니다.");
					$("#shopNameCheck").css("color", "red");
					$("#shopNameUpdateBtn").attr("disabled", true);
				}
				else if(data.checkResult == "1"){
					$("#shopNameSpan").html(data.SHOP_NAME);
					$("#shopNameCheck").html("사용가능한 상점명입니다.");
					$("#shopNameCheck").css("color", "blue");
					$("#shopNameUpdateBtn").attr("disabled", false);
				}
			},
			error : (x, s, e) => {
				console.log("ajax 요청 실패!");
			}
		});
	})
	
	function shopNameUpdateEnd(){
		var shopName = $("#shopNameInput").val();
		var memberId = $("[name=memberLoggedIn]").val();
		console.log("memberId="+memberId);
		console.log("shopName="+shopName);
		
		$.ajax({
			url : "${pageContext.request.contextPath}/shop/updateShopName",
			method : "POST",
			data : {memberId : memberId,
				    shopName : shopName},
			success : data => {
				console.log(data);
				console.log(data.SHOP_NAME);
				
				$("#shopNameCheck").html("");
				$("#shopNameSpan").html(data.SHOP_NAME);
				
				var $shopNameInput = $("#shopNameInput");
				var $shopNameUpdateBtn = $("#shopNameUpdateBtn");
				
				$shopNameInput.hide();
				$shopNameUpdateBtn.hide();
				
				var $shopNameSpan = $("#shopNameSpan");
				var $shopNameBtn = $("#shopNameBtn");
				
				 $shopNameSpan.show();
				 $shopNameBtn.show();
			},
			error : (x, s, e) => {
				console.log("ajax 요청 실패!");
			}
		});
		
	}
	
	function shopNameUp(){
		var $shopNameSpan = $("#shopNameSpan");
		var $shopNameBtn = $("#shopNameBtn");
		
		$shopNameSpan.hide();
		$shopNameBtn.hide();
		
		var $shopNameInput = $("#shopNameInput");
		var $shopNameUpdateBtn = $("#shopNameUpdateBtn");
		
		$shopNameInput.show();
		$shopNameUpdateBtn.show();
	}
	
	$(function(){
		var $textarea = $("#updateInfo");
		var $update_btn = $("#up_btn");
		
		$textarea.hide();
		$update_btn.hide();
		
		var $shopNameInput = $("#shopNameInput");
		var $shopNameUpdateBtn = $("#shopNameUpdateBtn");
		
		$shopNameInput.hide();
		$shopNameUpdateBtn.hide();
	}); 
	
	function showUpdate(){
		var $textarea = $("#updateInfo");
		var $update_btn = $("#up_btn");
		
		$textarea.show();
		$update_btn.show();
		
		var $shopInfoSpan = $("#shopInfoDetail");
		var $update_btn1 = $("#hiddenBtn");
		
		$shopInfoSpan.hide();
		$update_btn1.hide();
	};
	
	function shopUpdateEnd(){
		var memberId = $("[name=memberLoggedIn]").val();
		var updateInfo = $("#updateInfo").val();
		
		console.log("memberId="+memberId);
		console.log("updateInfo="+updateInfo);

		$.ajax({
			url : "${pageContext.request.contextPath}/shop/updateShopInfo",
			method : "POST",
			data : {memberId : memberId,
					updateInfo : updateInfo},
			success : data => {
				console.log(data);
				var $textarea = $("#updateInfo");
				var $update_btn = $("#up_btn");
				
				$textarea.hide();
				$update_btn.hide();
				
				var $shopInfoSpan = $("#shopInfoDetail");
				var $update_btn1 = $("#hiddenBtn");
				 $('#shopInfoDetail').html(data.SHOP_INFO);
				 console.log(data.SHOP_INFO);
				
				$shopInfoSpan.show();
				$update_btn1.show();
			},
			error : (x, s, e) => {
				console.log("ajax 요청 실패!");
			}
		});
	};
	</script>
	<hr class="my-hr3"/><br />
	
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