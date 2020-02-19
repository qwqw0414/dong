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

<div id="saleListPageBar"></div>
<h2 class ="text-center">구매 내역</h2>
<hr class="divide-sub"/>
<div class="mx-auto">
<table id="orderList-wrapper" class="mx-auto" ></table>
</div>

<div id="orderListPageBar"></div>
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
				let html = "<tr class='orderListTitle'><th>주문번호</th><th>상품정보</th><th>상품금액</th><th>판매자</th><th>배송상태</th><th>인수확인</th><th>거래상태<th></tr>";
				for(var i=0; i<data.orderList.length;i++){
					html += "<tr><td name='orderNo'>"+data.orderList[i].ORDER_NO+"</td>";
					html += "<td><img src='${pageContext.request.contextPath}/resources/upload/product/"+data.orderList[i].PHOTO+"' class='mr-3'>"+data.orderList[i].TITLE+"</td>";
					html += "<td>"+data.orderList[i].PRICE+"</td>";
					html += "<td>"+data.orderList[i].SHOP_NAME+"</td>";
					if(data.orderList[i].CHECK_SEND==="N"){
						html += "<td>배송 준비중</td>";	
					} else {
						html += "<td>배송완료</td>";	
					}
					if(data.orderList[i].CHECK_RECEIVE==="N"){
					html += "<td><button class='btn btn-primary main-btn' name='updateReceive'>인수확인</button></td>";	
					}else {		
					html += "<td><button class='btn btn-primary sub-btn' disabled>인수완료</button></td>";	
					}
					if(data.orderList[i].CHECK_SEND==="Y"&&data.orderList[i].CHECK_RECEIVE==="Y"){
						html += "<td>거래종료</td></tr>";
					} else {
						html += "<td>거래 진행중</td></tr>";
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
				let html = "<tr class='saleListTitle'><th>주문번호</th><th>상품정보</th><th>상품금액</th><th>판매자</th><th>배송상태</th><th>인수확인</th><th>거래상태<th></tr>";
				for(var i=0; i<data.saleList.length;i++){
					html += "<tr><input type='hidden' value='"+data.saleList[i].PRODUCT_NO+"'/><td name='orderNo'>"+data.saleList[i].ORDER_NO+"</td>";
					html += "<td><img src='${pageContext.request.contextPath}/resources/upload/product/"+data.saleList[i].PHOTO+"' class='mr-3'>"+data.saleList[i].TITLE+"</td>";
					html += "<td>"+data.saleList[i].PRICE+"</td>";
					html += "<td>"+data.saleList[i].SHOP_NAME+"</td>";
					if(data.saleList[i].CHECK_SEND==="N"){
						html += "<td><button class='btn btn-primary main-btn' name='updateSend'>배송</button></td>";	
					} else {
						html += "<td><button class='btn btn-primary sub-btn' disabled>배송완료</button></td>";	
					}
					if(data.saleList[i].CHECK_RECEIVE==="N"){
					html += "<td>인수 대기</td>";	
					}else {		
					html += "<td>인수완료</td>";	
					}
					if(data.saleList[i].CHECK_SEND==="Y"&&data.saleList[i].CHECK_RECEIVE==="Y"){
						html += "<td>거래종료</td></tr>";
					} else {
						html += "<td>거래 진행중</td></tr>";
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
		console.log(orderNo);
		console.log(productNo);
		if(confirm("상품을 인수하셨습니까?")){
		$.ajax({
			url: "${pageContext.request.contextPath}/member/updateReceive",
			data:{orderNo:orderNo,
				productNo:productNo},
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
		console.log(orderNo);
		console.log(productNo);
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
	
});//end of onload
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
