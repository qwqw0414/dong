<%@page import="com.pro.dong.common.util.Utils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<script>
$(function () {
	loadMemberOrderList();
	
	$("#searchMemberOrder").click(function (){
		var cPage = $("#cPage").val();
		var searchType = $("#searchType").val();
		var searchKeyword = $("#searchKeyword").val();
		
		if(searchKeyword.length == 0){
			alert("검색어를 입력하세요.");
			$("#searchKeyword").focus();
			return;
		}else{
			loadMemberOrderList(searchType,searchKeyword,cPage);
		}
	});
	
	$("#memberOrderAll").click(function (){
		location.reload();
	});
});

function loadMemberOrderList(searchType, searchKeyword, cPage){
	var cPage = cPage;
	var searchType = searchType;
	var searchKeyword = searchKeyword;
	
	$("#cPage").val(cPage);
	
	$.ajax({
		url : "${pageContext.request.contextPath}/admin/memberOrderListEnd",
		type : "GET",
		data: {
			cPage: cPage,
			searchType: searchType,
			searchKeyword: searchKeyword
		}, success: data => {
			console.log("memberOrderList@ajax 진행!");
			let header = "<tr><th>주문번호</th><th>회원아이디</th><th>주문내역</th><th>주소(동)</th><th>상품가격</th><th>주문날짜</th></tr>";
			let $table = $("#member-ordeList-tbl");
			$table.html("");
			let html = "";
			data.list.forEach(cate => {
				html += "<tr><td>"+cate.ORDER_NO+"</td><td>"+cate.MEMBER_ID+"</td><td>"+cate.PRODUCT_NO+"</td><td>"+cate.DONG+"</td><td>"+cate.PRICE+"</td><td>"+cate.ORDER_DATE+"</td></tr>";
			});
			$table.append(header+html);
			$("#pageBar").html(data.pageBar);
			$("#totalOrder").text(data.totalOrder);
			
		},error: (x,s,e) => {
			console.log("memberOrderList@ajax 실패실패!!");
		}
	});
}

</script>

<h1>회원 거래내역 관리</h1>

	<div class="col-md-6 ">
	    <div class="input-group">
		  <label for="searchKeyword" class="sr-only">검색</label>
		  <select class="custom-select" id="searchType" required>
	     	<option value="member_id">아이디</option>
	     	<option value="order_no">주문번호</option>
	     	<option value="dong">동네(동)</option>
	      </select>
	      
	      <!-- <div id="search-status">
	      	<input type="hidden" name="searchType" value="status"/>
	      	<input type="radio" name="searchKeyword" value="I" checked/> 입급내역
	      	<input type="radio" name="searchKeyword" value="O"/> 출금내역
	      </div> -->
	      
		  <input style="margin-left: 20px;" type="text" size="30" id="searchKeyword" placeholder="검색어를 입력하세요">
		  <div class="input-group-append">
	      <button style="margin-left: 20px;" class="btn btn-primary btn-sm" id="searchMemberOrder">검색하기</button> 
	      <button style="margin-left: 30px;" class="btn btn-primary btn-sm" id="memberOrderAll">전체보기</button>
          </div>
	    </div>
    </div>

<div class="table-responsive">
<br /><br />
	<table class="table text-center" id="member-ordeList-tbl">
		
	</table>
</div>
<div id="pageBar">
	
</div>
<input type="hidden" name="cPage" id="cPage"/>



<jsp:include page="/WEB-INF/views/common/footer.jsp"/>