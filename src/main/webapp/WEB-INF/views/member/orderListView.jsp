<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<h1 class ="text-center">거래 내역 페이지</h1>
<hr class="divide-m" />
<h2 class ="text-center">판매 내역</h2>
<hr class="divide-sub"/>
<div class="mx-auto">
<table id="saleList-wrapper" class="mx-auto" ></table>
</div>
<br />
<div id="saleListPageBar"></div>
<br /><br />
<h2 class ="text-center">구매 내역</h2>
<hr class="divide-sub"/>
<div class="mx-auto">
<table id="orderList-wrapper" class="mx-auto" ></table>
</div>
<br />
<div id="orderListPageBar"></div>
<div id="review-wrapper">
	<jsp:include page="/WEB-INF/views/member/productReview.jsp"/>
</div>


<script>
$(()=>{
	loadOrderList(1);
	loadSaleList(1);
	function loadOrderList(cPage){
		$.ajax({
			url: "${pageContext.request.contextPath}/member/loadOrderList",
			data:{cPage: cPage},
			type: "GET",
			success: data=>{
				console.log(data);
				let html = "<tr class='orderListTitle text-center'><th>주문번호</th><th>상품정보</th><th>상품금액</th><th>판매자</th><th>배송상태</th><th>인수확인</th><th>거래상태<th></tr>";
				if(data.orderList.length==0){
					html += "<tr><td class='text-center orderListContent' colspan='7'><h2>구매내역이 없습니다</h2></td></tr>";
				} else {
					for(var i=0; i<data.orderList.length;i++){
						html += "<tr class='text-center'><input type='hidden' value='"+data.orderList[i].PRODUCT_NO+"'/><td name='orderNo'>"+data.orderList[i].ORDER_NO+"</td>";
						html += "<td class='text-left orderListImg'><img src='${pageContext.request.contextPath}/resources/upload/product/"+data.orderList[i].PHOTO+"' class='mr-3'><a href='${pageContext.request.contextPath}/product/productView.do?productNo="+data.orderList[i].PRODUCT_NO+"'>"+data.orderList[i].TITLE+"</a></td>";
						html += "<td name='price'>"+numberComma(data.orderList[i].PRICE)+"원</td>";
						html += "<td name='shopName' id="+data.orderList[i].SHOP_NO+">"+data.orderList[i].SHOP_NAME+"</td>";
						if(data.orderList[i].CHECK_SEND==="N"){
							html += "<td><span class='badge badge-warning'>배송 준비중</span></td>";	
						} else {
							html += "<td><span class='badge badge-success'>배송완료</span></td>";	
						}	
						if(data.orderList[i].CHECK_RECEIVE==="N"){
						html += "<td><button class='btn btn-warning' name='updateReceive'>인수확인</button></td>";	
						}else {		
						html += "<td><button class='btn btn-primary main-btn' disabled>인수완료</button></td>";	
						}
						if(data.orderList[i].CHECK_SEND==="Y"&&data.orderList[i].CHECK_RECEIVE==="Y"){
							if(data.orderList[i].REVIEW_NO!=null){
								html += "<td><span class='badge badge-success'>리뷰 작성 완료</span></td></tr>";
							}else {
							html += "<td><button type='button' id='reviewBtn' class='btn btn-primary main-btn' data-toggle='modal' data-target='#productReviewModal'><span class='reviewBtnTxt'>거래완료(후기 작성)</span></button></td></tr>";
							}
						} else {
							html += "<td><span class='badge badge-warning'>거래 진행중</span></td></tr>";
						}
					}
					
				}
				$("#orderList-wrapper").html(html);
				$("#orderListPageBar").html(data.pageBar);
			},
			error : (x, s, e) => {
				console.log("ajax 요청 실패!",x,s,e);
	    	},
	    	complete: ()=>{
                $("#orderListPageBar a").click((e)=>{
                	loadOrderList($(e.target).siblings("input").val());
                });
            }
		});//end of ajax
	}//end of loadOrderList
	
	function loadSaleList(cPage){
		$.ajax({
			url: "${pageContext.request.contextPath}/member/loadSaleList",
			data:{cPage: cPage},
			type: "GET",
			success: data=>{
				let html = "<tr class='saleListTitle text-center'><th>주문번호</th><th>상품정보</th><th>상품금액</th><th>판매자</th><th>배송상태</th><th>인수확인</th><th>거래상태<th></tr>";
				if(data.saleList.length==0){
					html += "<tr><td class='text-center saleListContent' colspan='7'><h2>판매내역이 없습니다</h2></td></tr>";
				} else {
					for(var i=0; i<data.saleList.length;i++){
						html += "<tr class='text-center'><input type='hidden' value='"+data.saleList[i].PRODUCT_NO+"'/><td name='orderNo'>"+data.saleList[i].ORDER_NO+"</td>";
						html += "<td class='text-left saleListImg'><img src='${pageContext.request.contextPath}/resources/upload/product/"+data.saleList[i].PHOTO+"' class='mr-3'><a href='${pageContext.request.contextPath}/product/productView.do?productNo="+data.saleList[i].PRODUCT_NO+"'>"+data.saleList[i].TITLE+"</a></td>";
						html += "<td name='price'>"+numberComma(data.saleList[i].PRICE)+"원</td>";
						html += "<td name='shopName'>"+data.saleList[i].SHOP_NAME+"</td>";
						if(data.saleList[i].CHECK_SEND==="N"){
							html += "<td><button class='btn btn-warning btn-send' name='updateSend'>배송</button></td>";	
						} else {
							html += "<td><button class='btn btn-primary main-btn btn-send' disabled>배송완료</button></td>";	
						}
						if(data.saleList[i].CHECK_RECEIVE==="N"){
						html += "<td><span class='badge badge-warning'>인수 대기</span></td>";	
						}else {		
						html += "<td><span class='badge badge-success'>인수 완료</span></td>";	
						}
						if(data.saleList[i].CHECK_SEND==="Y"&&data.saleList[i].CHECK_RECEIVE==="Y"){
							html += "<td><span class='badge badge-success'>거래 완료</span></td></tr>";
						} else {
							html += "<td><span class='badge badge-warning'>거래 진행중</span></td></tr>";
						}
					}
				}
				$("#saleList-wrapper").html(html);
				$("#saleListPageBar").html(data.pageBar);
			},
			error : (x, s, e) => {
				console.log("ajax 요청 실패!",x,s,e);
	    	},
	    	complete: ()=>{
                $("#saleListPageBar a").click((e)=>{
                	loadSaleList($(e.target).siblings("input").val());
                });
            }
		});//end of ajax
	}//end of loadSaleList
	
	//인수확인
	$(document).on("click", "#orderList-wrapper [name=updateReceive]", function(e){
		var btnReceive = $(e.target);
		var orderNo = btnReceive.parent("td").siblings("[name=orderNo]").text();
		var productNo = btnReceive.parent("td").siblings("input").val();
		var shopName = btnReceive.parent("td").siblings("[name=shopName]").text();
		console.log(orderNo);
		console.log(productNo);
		console.log(shopName);
		if(confirm("상품을 인수하셨습니까?")){
		$.ajax({
			url: "${pageContext.request.contextPath}/member/updateReceive",
			data:{orderNo:orderNo,
				productNo:productNo,
				shopName:shopName},
			success: data=>{
				console.log(data);
				loadOrderList(1);
			},
			error : (x, s, e) => {
				console.log("ajax 요청 실패!",x,s,e);
	    	}
		});//end of ajax
		}
	});//인수확인 끝
	
	//배송확인
	$(document).on("click", "#saleList-wrapper [name=updateSend]", function(e){
		var btnSend = $(e.target);
		var orderNo = btnSend.parent("td").siblings("[name=orderNo]").text();
		var productNo = btnSend.parent("td").siblings("input").val();
		var shopName = btnSend.parent("td").siblings("[name=shopName]").text();
		console.log(orderNo);
		console.log(productNo);
		console.log(shopName);
		if(confirm("배송 완료하시겠습니까?")){
		 $.ajax({
			url: "${pageContext.request.contextPath}/member/updateSend",
			data:{orderNo:orderNo,
				productNo:productNo},
			success: data=>{
				console.log(data);
				loadSaleList(1);
			},
			error : (x, s, e) => {
				console.log("ajax 요청 실패!",x,s,e);
	    	}
		});//end of ajax
		}
	});//인수확인 끝
	
	function numberComma(num) {
		return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
});//end of onload
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
