<%@page import="com.pro.dong.shop.model.vo.Shop"%>
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
	border-radius: 50%;
}
#shopInfoDiv{
	width: 1100px;
	height: 300px;
	display: inline-block;
}
.img-thumbnail{
	border: 2px solid lightgray !important;
} 
#shopDetailInfoDiv{
	display: inline-block;
	position: absolute;
	width: 600px;	
	left: 350px;
	top: 60px;
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
#up_btn{
	position: absolute;
	left: 240px;
	width: 50px;
	height: 54px;
}
#shopImgDiv{
	width: 300px;
	height: 300px;
	text-align: center;
	padding-top: 35px;
	margin-bottom: 30px;
}
#shopNameSpan{
	font-weight: bold;
}
</style>

<input type="hidden" name="memberLoggedIn" value="<%= memberLoggedIn.getMemberId()%>"/>

 <div id="shopView" class="mx-center">
	<div id="shopDiv">
		<div id="shopImgDiv">
			<c:if test="${map.IMAGE == null}">
				<img id="shopImg1" class="img-thumbnail" src="${pageContext.request.contextPath}/resources/upload/shopImage/shopping-store.png" alt="" />
			</c:if>
			<c:if test="${map.IMAGE != null}">
				<img id="shopImg1" class="img-thumbnail" src="${pageContext.request.contextPath}/resources/upload/shopImage/${map.IMAGE}" alt="" />
			</c:if>
		</div>
		<button id="imgUpBtn" type="button" class="btn btn-outline-success btn-sm" data-toggle="modal" data-target="#exampleModal">수정</button>
		<div id="shopDetailInfoDiv">
			<div id="shopNameSpanDiv">
				<img id="shopIcon" src="${pageContext.request.contextPath}/resources/images/shopIcon.png" />
				<span id="shopNameSpan">${map.SHOP_NAME}</span> &nbsp;&nbsp;&nbsp;<button onclick="shopNameUp();" id="shopNameBtn" type="button" class="btn btn-outline-success btn-sm">수정</button><br />
			</div>
			<div id="shopNameInputDiv">
				<input id="shopNameInput" type="text"  value="${map.SHOP_NAME}"/>
				<button id="shopNameUpdateBtn" onclick="shopNameUpdateEnd();" type="button" class="btn btn-outline-success btn-sm">수정</button>
				<span id="shopNameCheck"></span>
			</div><hr />
			<img src="https://assets.bunjang.co.kr/bunny_desktop/images/shop-open@2x.png" width="14" height="13">상점오픈일 ${map.SINCE} 일째
			&nbsp;&nbsp;&nbsp;
			<img src="https://assets.bunjang.co.kr/bunny_desktop/images/shop-user@2x.png" width="14" height="13">상점방문수 10명
			&nbsp;&nbsp;&nbsp;
			<img src="https://assets.bunjang.co.kr/bunny_desktop/images/shop-sell@2x.png" width="14" height="13">상품판매 0회
			&nbsp;&nbsp;&nbsp;
			<img src="https://assets.bunjang.co.kr/bunny_desktop/images/shop-dell@2x.png" width="14" height="13">택배발송 2회<hr />
			<div id="shopInfoSpanDiv">
				<img id="shopIcon" src="${pageContext.request.contextPath}/resources/images/shopInfoIcon.png" />
				<span id="shopInfoDetail">${map.SHOP_INFO}</span> &nbsp;&nbsp;&nbsp;
				<button onclick="showUpdate();" id="hiddenBtn" type="button" class="btn btn-outline-success btn-sm">수정</button><br />
			</div>
			<div id="shopInfoTextDiv">
				<textarea  name="updateInfo" id="updateInfo" cols="30" rows="2">${map.SHOP_INFO }</textarea>
				<button onclick="shopUpdateEnd();" type="button" class="btn btn-outline-success btn-sm" id="up_btn">수정</button>
			</div>
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
				
				var $shopNameSpanDiv = $("#shopNameSpanDiv");
				var $shopNameInputDiv = $("#shopNameInputDiv");
				
				$shopNameSpanDiv.show();
				$shopNameInputDiv.hide();
			},
			error : (x, s, e) => {
				console.log("ajax 요청 실패!");
			}
		});
	}
	
	function shopNameUp(){
		var $shopNameInputDiv = $("#shopNameInputDiv");
		var $shopNameSpanDiv = $("#shopNameSpanDiv");
		
		$shopNameInputDiv.show();
		$shopNameSpanDiv.hide();
	}
	
	$(function(){
		var $shopInfoTextDiv = $("#shopInfoTextDiv");
		var $shopNameInputDiv = $("#shopNameInputDiv");
		
		$shopNameInputDiv.hide();
		$shopInfoTextDiv.hide();
		
	}); 
	
	function showUpdate(){
		
		var $shopInfoTextDiv = $("#shopInfoTextDiv");
		$shopInfoTextDiv.show();
		
		var $shopInfoSpanDiv = $("#shopInfoSpanDiv");
		$shopInfoSpanDiv.hide();
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
				var $shopInfoTextDiv = $("#shopInfoTextDiv");
				$shopInfoTextDiv.hide();
				
				$('#shopInfoDetail').html(data.SHOP_INFO);

				var $shopInfoSpanDiv = $("#shopInfoSpanDiv");
				$shopInfoSpanDiv.show();
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
	/* 주영시작 */
	#shopInquiryText{
		outline: none;
		resize: none;
	}
	#shopInquiryCommentText{
		outline: none;
		resize: none;
	}
	#shopInquiryText::placeholder {
		padding-top: 25px;
		padding-left: 5px;
	}
	#shopInquiryTextDiv{
		margin-top: 20px;
		margin-bottom: 0px;
	}
	#shopInquiryBtn{
		background-color: white;
		outline: none;
		border: 1px solid lightgray;
		width: 70px;
		height: 30px;
		margin: 10px 10px;
		
	}
	#shopInquiryBtnDiv{
		margin-top: 0px;
		border: 1px solid lightgray;
		width: 740px;
		text-align: right;
	}
	#inquiryContentCheck{
		float: left;
		margin-top: 15px;
		margin-left: 10px;
	}
	#inquiryWriterTag{
		font-weight: bold;
	}
	#inquiryImgTag{
		width: 50px;
		height: 50px;
		border-radius: 50%;
		margin-bottom: -60px;
	}
	#inquiryDetail{
		margin-left: 80px;
	}
	#commentInsertDiv{
		display: block;
	}
	#commentDeleteDiv{
		display: block;
	}
	.commentBtn{
		background-color: white;
		outline: none;
		border: 1px solid lightgray;
		margin-left: 70px;
	}
	.commentDelBtn{
		background-color: white;
		outline: none;
		border: 1px solid lightgray;
		margin-left: 5px;
	}
	#cancleRecommentBtn{
		position: relative;
		top: -8px;
	}
	#shopInquiryCommentEndBtn{
		background-color: white;
		outline: none;
		border: 1px solid lightgray;
		margin-left: 5px;
		margin-bottom: -60px;
		position: relative;
		top: -8px;
	}
	#inquiryCommentDiv{
		margin-left: 35px;
	}
	.recommentDiv{
		margin-left: 100px;
	}
	.replyIcon{
		width: 50px;
		height: 50px;
		display: inline-block;
		margin-left: -80px;
		/* margin-bottom: -50px; */
	}
	/* .replyIconDiv{
		display: inline-block;
	} */
	#inquiryRecommentDetail{
		margin-left: 35px;
   	    margin-top: -17px;
	}
	
	/* 주영 끝 */
	</style>
	
	<div id="shopView-nav">
		<div style="height: 20px;">
			<ul>
				<li><div class="shop-nav-selected shop-nav">내 상품</div></li>
				<li><div id="shopInquiryDiv" onclick="selectInquiry();" class="shop-nav-disabled shop-nav">상점문의</div></li>
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
				<h3>상점 문의&nbsp;<span id="totalInquiry" style="color:green;"></span></h3>
				<div id="shopInquiryTextDiv">
					<textarea name="shopInquiryText" id="shopInquiryText"  maxlength="100" cols="100" rows="3" placeholder="문의내용을 입력하세요."></textarea>
				</div>
				<div id="shopInquiryBtnDiv">
					<span id="inquiryContentCheck">0/100</span>
					<button onclick="insertInquiry();" id="shopInquiryBtn" disabled="disabled"><img src="https://assets.bunjang.co.kr/bunny_desktop/images/register@2x.png" width="15" height="16" >등록</button>
				</div>
				<div id="shopInquiryList">
				<!-- select해온 문의사항 리스트 -->
				</div></div>
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
			case "상점문의": $("#shopView-nav #nav-inquiry").show(); $("#shopInquiryTotalDiv").show();break;
			case "찜 목록": $("#shopView-nav #nav-wishlist").show();break;
			case "상점후기": $("#shopView-nav #nav-review").show();break;
			case "팔로우": $("#shopView-nav #nav-follow").show();break;
			case "팔로워": $("#shopView-nav #nav-follower").show();break;
		}
	})
});
/* 주영 시작 */
$(()=>{
	$("#shopInquiryTotalDiv").hide();
});

$("#shopInquiryText").keyup(function() {
	var content = $(this).val();
	console.log("content.length="+content.length);
	
	if(content.length > 0){
		$("#shopInquiryBtn").prop("disabled", false);
	}
	
	if(content.length == 0){
		$("#shopInquiryBtn").prop("disabled", true);
	}
	
	var inquiryContentCheck = $("#inquiryContentCheck");
	inquiryContentCheck.html(content.length + '/100');
	
});

function selectInquiry(){
	var shopNo = ${map.SHOP_NO};
	$.ajax({
		url : "${pageContext.request.contextPath}/shop/selectShopInquriy",
		method : "POST",
		data : {shopNo : shopNo},
		success : data => {
			console.log(data);
			let $totalInquiry = $("#totalInquiry");
			$totalInquiry.html(data.totalInquiry);
			var memberId = $("[name=memberLoggedIn]").val();
			
			let $listDiv = $("#shopInquiryList");
			let	html = "";
			for(var i=0; i<data.list.length;i++){
				/* 댓글이라면 */
				if(data.list[i].INQUIRY_LEVEL == 1){
					html += "<hr width='745px'  align='left'/>";
					html += "<img id='inquiryImgTag' src='${pageContext.request.contextPath}/resources/upload/shopImage/"+data.list[i].IMAGE+"'/>";
					html += "<div id='inquiryDetail'>";
					html += "<span id='inquiryWriterTag'>"+data.list[i].MEMBER_ID+"</span>";
					html += "&nbsp;&nbsp;";
					html += "<span>"+data.list[i].WRITE_DAY +"</span>";
					html += "<p>"+data.list[i].INQUIRY_CONTENT+"</p>";
					html += "</div>";
					if(memberId == data.list[i].MEMBER_ID){
						html += "<button onclick='insertInquiryComment(this);' value="+data.list[i].INQUIRY_NO+" id='insertInquiryCommentBtn' class='commentBtn' >"
						html += "<img  src='https://assets.bunjang.co.kr/bunny_desktop/images/reply@2x.png' width='17' height='17'>";
						html +=	"댓글";
				    	html += "</button>";
						}
					if("${map.MEMBER_ID}" == memberId){
				    	html += "<button id='deleteCommentBtn' value="+data.list[i].INQUIRY_NO+" onclick='deleteComment(this);' class='commentDelBtn'>";
				    	html += "<img src='https://assets.bunjang.co.kr/bunny_desktop/images/trash-sm@2x.png' width='15' height='17'>";
				    	html += "삭제";
				    	html += "</button>";
				    	html += "<div class='inquiryCommentDiv' id='inquiryCommentDiv'></div>";
						}
					}
				/* 대댓글이라면 */
				else{
					html += "<div class='recommentDiv'>";
					/* html += "<hr width='745px'  align='left'/>"; */
					html += "<img class='replyIcon' src='${pageContext.request.contextPath}/resources/images/reply.PNG'/>";
					html += "<img id='inquiryImgTag' src='${pageContext.request.contextPath}/resources/upload/shopImage/"+data.list[i].IMAGE+"'/>";
					html += "<div id='inquiryRecommentDetail'>";
					html += "<span id='inquiryWriterTag'>"+data.list[i].MEMBER_ID+"</span>";
					html += "&nbsp;&nbsp;";
					html += "<span>"+data.list[i].WRITE_DAY +"</span>";
					html += "<p>"+data.list[i].INQUIRY_CONTENT+"</p>";
					html += "</div>";
					html += "</div>";
				}
			}
			$listDiv.html(html);
			
		},
		error : (x, s, e) => {
			console.log("ajax 요청 실패!");
		}
	});
}

function insertInquiry(){
	$("#inquiryContentCheck").html("0/100");
	var memberId = $("[name=memberLoggedIn]").val(); 
	var inquiryContent = $("#shopInquiryText").val();
	var shopNo = ${map.SHOP_NO};
	$.ajax({
		url : "${pageContext.request.contextPath}/shop/insertShopInquriy",
		method : "POST",
		data : {inquiryContent : inquiryContent,
				memberId : memberId,
				shopNo : shopNo},
		success : data => {
			console.log("insertdata="+data);
			$("#shopInquiryText").val('');
			/* 이중 에이작스  */
			selectInquiry();
			/* 이중 에이작스  */
		},
		error : (x, s, e) => {
			console.log("ajax 요청 실패!");
		}
	});
	
}

function deleteComment(btn){
	
	var deleteCommentBtn = $(btn).val();
	console.log(deleteCommentBtn);
	
	$.ajax({
		url : "${pageContext.request.contextPath}/shop/deleteShopInquriy",
		method : "POST",
		data : {deleteCommentBtn : deleteCommentBtn},
		success : data => {
			console.log(data);
			selectInquiry();
		},
		error : (x, s, e) => {
			console.log("ajax 요청 실패!");
		}
	});
}

function insertInquiryComment(btn){
	$(btn).hide();
	console.log($(btn).next());
	$(btn).next().css('margin-left','80px');
	console.log("댓글추가함수에들어왔다");
	console.log($(btn).next().next());
	/* var inquiryRefNo = $("#insertInquiryCommentBtn").val(); */
	var inquiryRefNo = $(btn).val();
	console.log(inquiryRefNo);
	let html = "";
	html += "<br/>";
	/* html += "<div class='inquiryCommentDiv' id='inquiryCommentDiv'>"; */
	html += "<textarea id='shopInquiryCommentText' cols='80' rows='1' placeholder='댓글내용을 입력하세요.'></textarea>&nbsp;&nbsp;";
	html += "<button onclick='insertInquiryCommentEnd();' value='"+inquiryRefNo+"' id='shopInquiryCommentEndBtn'>";
	html += "<img src='https://assets.bunjang.co.kr/bunny_desktop/images/register@2x.png' width='15' height='14' >";
	html += "등록";
	html += "</button>";
	html += "<button onclick='cancleRecommentBtn(this);' id='cancleRecommentBtn' class='commentDelBtn'>";
	html += "<img src='https://assets.bunjang.co.kr/bunny_desktop/images/trash-sm@2x.png' width='15' height='14'>";
	html += "취소";
	html += "</button>";
	html += "</div>";
	$(btn).next().next().html(html);
	
}

function cancleRecommentBtn(btn){
	console.log("취소버튼함수에들어왔다");
	$(btn).prev().prev().parent().empty();
	$("#insertInquiryCommentBtn").show();
	$("#deleteCommentBtn").css('margin-left','5px');
	
}

function insertInquiryCommentEnd(){
	var inquiryRefNo = $("#shopInquiryCommentEndBtn").val();
	console.log(inquiryRefNo);
	var shopInquiryCommentText = $("#shopInquiryCommentText").val();
	var shopInquiryCommentWriter = $("[name=memberLoggedIn]").val();
	var shopInquiryCommentShopNo = ${map.SHOP_NO}
	
	$.ajax({
		url : "${pageContext.request.contextPath}/shop/insertInquiryComment",
		method : "POST",
		data : {inquiryRefNo : inquiryRefNo,
				shopInquiryCommentText : shopInquiryCommentText,
				shopInquiryCommentWriter : shopInquiryCommentWriter,
				shopInquiryCommentShopNo : shopInquiryCommentShopNo},
		success : data => {
			console.log(data);
			selectInquiry();
		},
		error : (x, s, e) => {
			console.log("ajax 요청 실패!");
		}
	});
}

/* 주영 끝 */
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>