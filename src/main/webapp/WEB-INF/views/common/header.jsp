<%@page import="com.pro.dong.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%
	Member memberLoggedIn = (Member)request.getSession().getAttribute("memberLoggedIn");
%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>동네한바퀴</title>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.1.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/js.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/css.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/animation.css" />
<!-- 카카오 맵 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ea166326e5dc5657d4a2feb24b4cfe0b&libraries=services"></script>
</head>
<style>
#headerImgDiv{
	width: 100%;
	text-align: center;
	margin-bottom: 50px;
}
#bogiImg{
	width:20px;
	height: 20px;
}
#headerMenu{
	width:30px;
	height: 30px;
}
#saleImg{
	width:35px;
	height: 40px;
    margin-left: 20px;
}
#shopImg{
	width:35px;
	height: 40px;
	margin-left: 20px;
}
#chatImg{
	width:38px;
	height: 40px;
	margin-left: 20px;
}
#button-addon2{
    height: 38px;
}
</style>

<body>

<%if(memberLoggedIn == null){%>
<!-- 모달 -->
<div class="modal-bg" style="font-family: 'MapoPeacefull';">
    <div class="modal-dialog" style="margin-top: 20px;" id="modal-log">
        <div class="modal-content" style="height: 660px; width: 500px;">
<!-- 모달바디 -->
            <div class="modal-body" id="login-page">
				<jsp:include page="/WEB-INF/views/member/memberLogin.jsp"/>
			</div>

			<div class="modal-body" id="enroll-page">
				<jsp:include page="/WEB-INF/views/member/memberEnroll.jsp"/>
			</div>
			
			<div class="modal-body" id="findId-page">
				<jsp:include page="/WEB-INF/views/member/findId.jsp"/>
			</div>

			<div class="modal-body" id="findPwd-page">
				<jsp:include page="/WEB-INF/views/member/findPassword.jsp"/>
			</div>

        </div>
    </div>
</div>

<script>
$(()=>{

	$("#modal-log .modal-body").hide();
	$("#modal-log #login-page").show();

	$("#modal-log #login-bottom #btn-go-enroll").click(()=>{
		$("#modal-log .modal-body").hide();
		$("#modal-log #enroll-page").show();
	});
	$("#modal-log #login-bottom #btn-go-findId").click(()=>{
		$("#modal-log .modal-body").hide();
		$("#modal-log #findId-page").show();
	});
	$("#modal-log #login-bottom #btn-go-findPwd").click(()=>{
		$("#modal-log .modal-body").hide();
		$("#modal-log #findPwd-page").show();
	});
});
</script>
<%}%>

<header>
<nav class="navbar navbar-expand-md navbar-light bg-light">

	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
		aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>

	<div class="collapse navbar-collapse" id="navbarSupportedContent">
		<ul class="navbar-nav mr-auto">
			<!-- 회원 -->
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown"
					aria-haspopup="true" aria-expanded="false">
					회원
				</a>
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">

					<a class="dropdown-item" href="${pageContext.request.contextPath}/member/memberEnroll.do">회원가입</a>
					<c:if test="${memberLoggedIn == null }">
						<a class="dropdown-item" href="${pageContext.request.contextPath}/member/memberLogin.do">로그인</a>
					</c:if>
					<c:if test="${memberLoggedIn != null }">
						<a class="dropdown-item"
							href="${pageContext.request.contextPath }/member/memberLogOut.do">로그아웃</a>
					</c:if>
					<a class="dropdown-item" href="${pageContext.request.contextPath}/member/findPassword.do">비밀번호
						찾기</a>
					<a class="dropdown-item" href="${pageContext.request.contextPath}/member/findId.do">아이디 찾기</a>
					<a class="dropdown-item" href="${pageContext.request.contextPath}/member/memberView.do">내 정보</a>
					
				</div>
			</li>

			<!-- 커뮤니티 -->
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown"
					aria-haspopup="true" aria-expanded="false">
					커뮤니티
				</a>
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="${pageContext.request.contextPath}/board/boardList.do">게시글</a>
					<a class="dropdown-item" href="${pageContext.request.contextPath}/board/boardComment.do">댓글</a>
				</div>
			</li>

			<!-- 상품 -->
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown"
					aria-haspopup="true" aria-expanded="false">
					상품
				</a>
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">

					<a class="dropdown-item" href="${pageContext.request.contextPath}/product/productReg.do">상품 등록</a>

				</div>
			</li>
			<!-- 상점 -->
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown"
					aria-haspopup="true" aria-expanded="false">
					상점
				</a>
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">

					<a class="dropdown-item" href="${pageContext.request.contextPath}/shop/shopView.do">내 상점</a>

				</div>
			</li>
			
			<!-- 관리자 -->
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown"
					aria-haspopup="true" aria-expanded="false">
					관리자
				</a>
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">


					

					<a class="dropdown-item" href="${pageContext.request.contextPath}/admin/memberList.do">회원관리</a>
					<a class="dropdown-item" href="${pageContext.request.contextPath}/admin/productList.do">상품관리</a>


				</div>
			</li>

		</ul>
	</div>
</nav>

<!-- 페이지 시작 -->
<div class="container" style="width: 1400px;">
	<div id="headerImgDiv" class="text-center">
		<a href="${pageContext.request.contextPath}">
			<img id="headerImg" src="${pageContext.request.contextPath}/resources/images/header.PNG"/>
		</a>
	</div>

	<!-- 카테고리 바 -->
	<div class="row text-right" style="width: 1200px;">
		<div id="categoryDiv" class="col-md-1"> 
			<img id="headerMenu" src="${pageContext.request.contextPath}/resources/images/menuImg.PNG"/>
			<div class="cate-list text-left" style="display: none;">
				<p>전체 카테고리</p>
				<hr>
				<div id="cate-autowire" style="width: 220px;">
					<div id="category-list-pre" class="cate-list-content">
						<ul></ul>
					</div>
					<div id="category-list-end" class="cate-list-content">
						<ul></ul>
					</div>
				</div>
			</div>
		</div>
	
		<!--검색창-->
		<div class="input-group col-md-6">
  			<input type="text" class="form-control" placeholder="상품명,지역명,@상점명 입력" aria-label="Recipient's username" aria-describedby="button-addon2">
  			<div class="input-group-append">
    			<button class="btn btn-outline-secondary" type="button" id="button-addon2">
    				<img id="bogiImg" src="${pageContext.request.contextPath}/resources/images/bogi.png"/>
    			</button>
 			</div>
		</div>
		
		<!--메뉴-->
		<div class="col-md text-left">
			<a style="color:black; text-decoration: none;" href=""><img id="saleImg" src="${pageContext.request.contextPath}/resources/images/sale.PNG"/> 판매하기</a>
			<a style="color:black; text-decoration: none;" href="${pageContext.request.contextPath}/shop/shopView.do"><img id="shopImg" src="${pageContext.request.contextPath}/resources/images/shop.PNG"/> 내 상점</a>
			<a style="color:black; text-decoration: none;"href=""><img id="chatImg" src="${pageContext.request.contextPath}/resources/images/chat.PNG"/> 동네톡</a>
		</div>
	</div>


</header>

<script>
$(()=>{
var $preList = $("header #categoryDiv #category-list-pre");
var $endList = $("header #categoryDiv #category-list-end");
var $cateList = $("#categoryDiv .cate-list");
var $categoryBar = $("header #categoryDiv #headerMenu");
var $categoryDiv = $("header #categoryDiv");
var isCateShow = false;
// 카테고리 검색 창 활성화
	$categoryDiv.mouseenter((e)=>{
		$(e.target).find(".cate-list").show();
	});

// 창 비활성화
	$categoryDiv.mouseleave((e)=>{
		setTimeout(function() {
			if(!isCateShow){
				$(e.target).find(".cate-list").hide();
				isCateShow = false;
			}
		},300);
	});

	$cateList.mouseenter(()=>{isCateShow = true});

	$cateList.mouseleave((e) => {
		$("header #categoryDiv .cate-list").hide();
		$endList.children("ul").html("");
		$("header #categoryDiv #cate-autowire").css("width","220px");
		isCateShow = false;
	});

//  대분류 불러오기
	$.ajax({
		url:"${pageContext.request.contextPath}/product/categoryList",
		type: "GET",
		dataType: "json",
		success: data => {
			let html = "";
			
			data.forEach(cate => {
				html += "<li><p>"+cate.categoryName+"</p><input type='hidden' value='"+cate.categoryId+"'></li>";
			});
			
			$preList.children("ul").html(html);
		},
		error: (x,s,e)=>{
			console.log("실패",x,s,e);
		},
		complete: ()=>{
			loadEndList();
		}
	});
// 소분류 불려오기
	function loadEndList(){
		$preList.find("li").mouseenter((e)=>{

			setTimeout(function() {

				//카테고리 div 확장
				$(e.target).parents("#cate-autowire").css("width","440px");
				var categoryRef = $(e.target).siblings("input").val();

				$.ajax({
					url: "${pageContext.request.contextPath}/product/categoryList",
					data: {categoryRef: categoryRef},
					type: "GET",
					dataType: "json",
					success: data => {
						let html = "";

						data.forEach(cate => {
							html += "<li><p>" + cate.categoryName + "</p><input type='hidden' value='" + cate.categoryId + "'></li>";
						});

						$endList.children("ul").html(html);
					},
					error: (x, s, e) => {
						console.log("실패", x, s, e);
					}
				});

			}, 100);
		});
		
	}
});


// $("#categoryDiv .categoryA").hover(function(e){
	
// 	var $categoryOneList =  $("#categoryOneList");
	
// 	$.ajax({
// 		url:"${pageContext.request.contextPath}/product/categoryView",
// 		type: "GET",
// 		dataType: "json",
// 		success: data => {
// 			console.log("성공");
			
// 			let categoryHtml = "";
// 			for(var i=0; i<data.cateboryList.length; i++){
// 				categoryHtml += "<li><a href='#'>"+data.cateboryList[i].CATEGORY_NAME+"</a></li>";
// 			}
// 			$categoryOneList.html(categoryHtml);
			
// 		},
// 		error: (x,s,e)=>{
// 			console.log("실패",x,s,e);
// 		}
// 	});
// });
</script>




<section>
	<div class="container_" id="section" style="width: 1200px; margin: auto;">
	
	
	
	
	