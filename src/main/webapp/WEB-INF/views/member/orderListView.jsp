<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<h1>거래 내역 페이지</h1>
<hr class="divide-m" />
<div class="mx-auto">
<table id="orderList-wrapper" class="mx-auto" ></table>
</div>

<div id="pageBar"></div>
<script>
$(()=>{
	loadOrderList(1);
	
	function loadOrderList(cPage){
		$.ajax({
			url: "${pageContext.request.contextPath}/member/loadOrderList",
			data:{cPage: cPage},
			type: "GET",
			success: data=>{
				console.log(data);
				let html = "";
				for(var i=0; i<data.orderList.length;i++){
					html += "<tr><th>주문번호</th><th>상품정보</th><th>상품금액</th><th>판매자</th><th>배송상태</th><th>인수확인</th><th>거래상태<th></tr>";
					html += "<tr><td>"+data.orderList[i].ORDER_NO+"</td>";
					html += "<td><img src='${pageContext.request.contextPath}/resources/upload/product/"+data.orderList[i].PHOTO+"' width='64px' class='mr-3'>"+data.orderList[i].TITLE+"</td>";
					html += "<td>"+data.orderList[i].PRICE+"</td>";
					html += "<td>"+data.orderList[i].SHOP_NAME+"</td>";
					if(data.orderList[i].CHECK_SEND==="N"){
						html += "<td>배송 준비중</td>";	
					} else {
						html += "<td>배송완료</td>";	
					}
					if(data.orderList[i].CHECK_RECEIVE==="N"){
					html += "<td><button class='btn btn-primary main-btn'>인수확인</button></td>";	
					}else {		
					html += "<td><button class='btn btn-primary main-btn' disabled>인수완료</button></td>";	
					}
					if(data.orderList[i].CHECK_SEND==="Y"&&data.orderList[i].CHECK_RECEIVE==="Y"){
						html += "<td>거래종료</td></tr>";
					} else {
						html += "<td>거래 진행중</td></tr>";
					}
				}
				console.log(html);
				$("#orderList-wrapper").html(html);
				$("#pageBar").html(data.pageBar);
			},
			error : (x, s, e) => {
				console.log("ajax 요청 실패!",x,s,e);
	    	},
	    	complete: ()=>{
                $("#pageBar a").click((e)=>{
                	loadOrderList($(e.target).siblings("input").val());
                });
            }
		});//end of ajax
	}//end of loadOrderList
});//end of onload
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
