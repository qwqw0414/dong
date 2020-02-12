<%@page import="com.pro.dong.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<%
	Member memberLoggedIn = (Member)request.getSession().getAttribute("memberLoggedIn");
%>
<style>
td{
	padding-top: 75px !important;
}
#img-td{
	padding-top: 8px !important;
}
#btn-td{
	padding-top: 55px !important;
}
select{
    width: 110px !important;
}
</style>
<script>
$(()=>{
	
	loadMyProductList(1);
	
	function loadMyProductList(cPage){
		
		var memberId = '${memberLoggedIn.getMemberId()}';
		
		$.ajax({
			url:"${pageContext.request.contextPath}/shop/loadMyProduct",
			contentType: "application/json; charset=utf-8",
			data:{
				memberId:memberId,
				cPage:cPage
			},
			dataType:"json",
			success:data=>{
				console.log("성@@@@@@@@@@@@@@@@@");
				console.log(data);
				
				let $table = $("#product-tbl");
				let header = "<thead><tr><th scope='col'>사진</th><th scope='col'>판매상태</th><th scope='col'>상품명</th><th scope='col'>가격</th><th scope='col'>최근수정일</th><th scope='col'>기능</th></tr></thead>";
				$table.html("");
				
				let html = "";
				data.product.forEach(product=>{
					html += "<tr>";
					html +=	"<tbody>";
					html += "<td id='img-td'><img style='width:152px; height:152px;' src='${pageContext.request.contextPath}/resources/upload/product/"+product.PHOTO+"'/></td>";
					html += "<td><select class='custom-select'><option value='member_id' selected>판매중</option><option value='board_title'>판매완료</option></select></td>"
					html += "<td>"+product.TITLE+"</td>";
					html += "<td>"+numberComma(product.PRICE)+"원</td>";
					html += "<td>"+product.REG_DATE+"</td>";
					html += "<td id='btn-td'><button type='button' class='btn btn-outline-primary btn-sm'>수정</button><br />";
			      	html += "<button type='button' class='btn btn-outline-danger btn-sm' style='width: 45px;'>UP</button></td>";
					html += "</tbody>";
					html += "</tr>";
					
				});
				
				$table.append(header+html);
				$("#pageBar").html(data.pageBar);
			},
			error:(x,s,e)=>{
				console.log("실패",x,s,e);
			},
			complete:(data)=>{
				$("#pageBar a").click((e)=>{
					loadMyProductList($(e.target).siblings("input").val());
	            });
			}
			
		});
	}
	
});
</script>

<h1>상품관리</h1>

<table class="table text-center" id="product-tbl">
 
     
</table>

<div id="pageBar"></div>





















<jsp:include page="/WEB-INF/views/common/footer.jsp"/>