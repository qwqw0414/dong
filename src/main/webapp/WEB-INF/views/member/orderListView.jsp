<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<h1>거래 내역 페이지</h1>
<ul class="list-unstyled" id="orderList-wrapper">
  <li class="media">
    <!-- <img src="..." class="mr-3" alt="..."> -->
    <div class="media-body">
      <h5 class="mt-0 mb-1" id="orderList-title">123123123</h5>
      <table>
      <tr><th>AAA</th><th>BBB</th><th>CCC</th></tr>
      <tr><td>aaa</td><td>bbb</td><td>ccc</td></tr>
      </table>
    </div>
  </li>
</ul>
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
					html += "<li class='media'>";
					html += "<img src='${pageContext.request.contextPath}/resources/upload/product/"+data.orderList[i].PHOTO+"' width='64px' class='mr-3'>";
					html += "<div class='media-body'>";
					html += "<table><tr><th>주문번호</th><th>상품정보</th><th>상품금액</th>판매자<th></th><th>배송상태</th></tr>";
					html += "<span class='orderList-content'><small>"+(data.orderList[i].CHECK_SEND==='N')?'발송전':'발송완료'+"</small></span>";
					
					html += "<tr><td>"+data.orderList[i].ORDER_NO+"</td>";
					html += "<td>"+data.orderList[i].TITLE+"</td>";
					html += "<td>"+data.orderList[i].PRICE+"</td>";
					html += "<td>"+data.orderList[i].SHOP_NO+"</td>";
					html += "<td>"+data.orderList[i].ORDER_NO+"</td></tr>";
					
					if(data.orderList[i].CHECK_RECEIVE==="N"){
					html += "<button class='btn btn-primary main-btn'>인수확인</button>";	
					}else {		
					html += "<button class='btn btn-primary main-btn' disabled>인수완료</button>";	
					}
					html += "</div></li>";
				}
				console.log(html);
				$("#orderList-wrapper").append(html);
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
