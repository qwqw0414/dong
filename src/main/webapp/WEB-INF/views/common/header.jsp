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
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.1.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/js.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/css.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/animation.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.7.2/animate.min.css">
		
<!-- 카카오 맵 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ea166326e5dc5657d4a2feb24b4cfe0b&libraries=services"></script>
<!-- 우편번호 -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- 달력 -->
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<!-- end of 달력 -->
</head>

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
<div style="width: 1100px; margin: auto;" class="text-dark">
	<ul class="nav justify-content-end">
		<li class="nav-item dropdown">
			<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				${ memberLoggedIn == null ? "" : (memberLoggedIn.isAdmin == "Y" ? "관리자":memberLoggedIn.memberName)}${ memberLoggedIn == null ? "" : "님 환영합니다."}
			</a>
			<div class="dropdown-menu" aria-labelledby="navbarDropdown">
				<!-- 관리자 -->
				<c:if test='${memberLoggedIn != null && memberLoggedIn.isAdmin == "Y"}'>
					<a class="dropdown-item" href="${pageContext.request.contextPath}/admin/memberList.do">회원관리</a>
					<a class="dropdown-item" href="${pageContext.request.contextPath}/admin/memberPointList.do">회원포인트관리</a>
					<a class="dropdown-item" href="${pageContext.request.contextPath}/admin/memberOrderList.do">회원거래내역관리</a>
				<div class="dropdown-divider"></div>
					<a class="dropdown-item" href="${pageContext.request.contextPath}/admin/productList.do">상품관리</a>
					<a class="dropdown-item" href="${pageContext.request.contextPath}/admin/productReportList.do">상품신고관리</a>
					<a class="dropdown-item" href="${pageContext.request.contextPath}/admin/kingOfDongnae.do">동네왕</a>
				<div class="dropdown-divider"></div>
					<a class="dropdown-item" href="${pageContext.request.contextPath}/admin/boardList.do">게시글관리</a>
				</c:if>
				<!-- 회원 -->
				<c:if test='${memberLoggedIn != null && memberLoggedIn.isAdmin == "N"}'>
					<a class="dropdown-item" href="${pageContext.request.contextPath}/member/memberView.do">내 정보 (포인트 충전)</a>
					<a class="dropdown-item" href="${pageContext.request.contextPath}/board/boardList.do">동네 게시판</a>
					<a class="dropdown-item" href="${pageContext.request.contextPath}/shop/myPoductManage.do">내 상품 관리</a>
				</c:if>
				<div class="dropdown-divider"></div>
				<a class="dropdown-item" href="${pageContext.request.contextPath }/member/memberLogOut.do">로그아웃</a>
			</div>
		</li>
	</ul>
</div>
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
  			<input type="text" class="form-control" placeholder="상품명, 지역명, @상점명 입력" id="search-bar" aria-label="Recipient's username" aria-describedby="button-addon2">
  			<div class="input-group-append">
    			<button class="btn btn-outline-secondary" type="button" id="btn-search">
    				<img id="bogiImg" src="${pageContext.request.contextPath}/resources/images/bogi.png"/>
    			</button>
 			</div>
		</div>
		
		<!--메뉴-->
		<div class="col-md text-left" id="header-iconMenu">
			<a style="color:black; text-decoration: none;" href="${pageContext.request.contextPath}/product/productReg.do">
			<img id="saleImg" src="${pageContext.request.contextPath}/resources/images/sale.PNG"/> 판매하기
			</a>
			<a style="color:black; text-decoration: none;" href="${pageContext.request.contextPath}/shop/shopView.do?memberId=<%=memberLoggedIn != null ? memberLoggedIn.getMemberId() : ""%>"><img id="shopImg" src="${pageContext.request.contextPath}/resources/images/shop.PNG"/> 내 상점</a>
			<a style="color:black; text-decoration: none;" id="a-chat"><img id="chatImg" src="${pageContext.request.contextPath}/resources/images/chat.PNG"/> 동네톡</a>
			<a style="color:black; text-decoration: none;" href="${pageContext.request.contextPath}/member/hallOfFame.do"><img src="${pageContext.request.contextPath}/resources/images/king.png" id="kingImg"/>동네왕</a>
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
var _error = "";

// 에러 
	$(window).keypress((e)=>{
		if(e.keyCode == 13 && _error == 'error'){
			location.href = "${pageContext.request.contextPath}/admin/error.do";
			return;
		}
		_error += e.key;
	});

	$("header #a-chat").click(chatList);

// 채팅
	function chatList(){
		var width = 360;
		var height = 660;
		var top = (window.screen.height / 2) - (height / 2);
		var left = (window.screen.width / 2) - (width / 2);
		var memberId = '${memberLoggedIn.memberId}';
		let url = "";

		url = "${pageContext.request.contextPath}/ws/admin.do";

		window.open(url,"chatView", "width="+width+",height="+height+", top="+top+", left="+left);
	}

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

	// 검색 기능
	$("header #btn-search").click(search);
	$("header #search-bar").keyup((e)=>{if(e.keyCode == 13) search();});
	$("header .cate-list-content").children("ul").click((e)=>{
		var $target = $(e.target).siblings("input");
		location.href = "${pageContext.request.contextPath}/product/productList.do?keyword=&categoryId="+$target.val();
	});

	function search(categoryId){
		var keyWord = $("header #search-bar").val();

		if(keyWord.length == 0) return;
		
		var reg = /^@/;		
		if(reg.test(keyWord)){
			keyWord = keyWord.substring(1);
			location.href = "${pageContext.request.contextPath}/shop/shopList.do?keyword="+keyWord;
		}
		else{
			location.href = "${pageContext.request.contextPath}/product/productList.do?keyword="+keyWord+"&categoryId=";
		}

	}

	function productView(productNo){
		location.href = "${pageContext.request.contextPath}/product/productView.do?productNo="+productNo;
	}
	

});
</script>

<c:if test="${memberLoggedIn != null}">
<script>
popupDongnaeKing();
//다시보지않음
function getCookie(name) {
	   var cookieName = name + "=";
	   var x = 0;
	   while ( x <= document.cookie.length ) {
	      var y = (x+cookieName.length);
	      if ( document.cookie.substring( x, y ) == cookieName) {
	         if ((lastChrCookie=document.cookie.indexOf(";", y)) == -1)
	            lastChrCookie = document.cookie.length;
	         return decodeURI(document.cookie.substring(y, lastChrCookie));
	      }
	      x = document.cookie.indexOf(" ", x ) + 1;
	      if ( x == 0 )
	         break;
	      }
	   return "";
	}
//동네왕 팝업
function popupDongnaeKing(){
	var url = "${pageContext.request.contextPath}/member/kingOfDongnae.do";
	var name = "이달의 동네왕";
	var option = "width = 1200, height = 500, top = 100, left = 200";
	var result = getCookie('popup');
	if (result == 'end') {
		   return false;
		}
	else {
	window.open(url, name, option);
	}
}

</script>
</c:if>


<section>
	<div class="container_" id="section" style="width: 1200px; margin: auto;">
	
	
	
	
	