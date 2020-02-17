<%@page import="com.pro.dong.common.util.Utils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
				html += "<tr><td>"+cate.ORDER_NO+"</td><td>"+cate.MEMBER_ID+"</td><td>"+cate.PRODUCT_NO+"</td><td>"+cate.DONG+"</td><td>"+cate.PRICE+"</td><td>"+cate.DATE+"</td></tr>";
			});
			$table.append(header+html);
			$("#pageBar").html(data.pageBar);
			$("#totalOrder").text(data.totalOrder);
			
		},error: (x,s,e) => {
			console.log("memberOrderList@ajax 실패실패!!");
		}
	});
	
	$.ajax({
		url: "${pageContext.request.contextPath}/admin/loadSidoList",
		dataType: "json",
		type: "GET",
		success: data=>{
			console.log(data);
			let html = "<option value=''>전체</option>";
			$.each(data, function(index, data){
				html += "<option value='"+data+"'>"+data+"</option>";				
			});//end of forEach
			$("#sido").html(html);
		},
		error: (x,s,e)=>{
			console.log("실패",x,s,e);
		}
		
	});//end of ajax

	$("#sido").on("change", function(){
		var sido = $("#sido").val();
		console.log(sido);
		loadSigunguList(sido);
		loadDongList('');
	});

	function loadSigunguList(sido){
		var sido = sido;
	$.ajax({
		url: "${pageContext.request.contextPath}/admin/loadSigunguList",
		data:{sido:sido},
		dataType: "json",
		type: "GET",
		success: data=>{
			console.log(data);
			let html = "<option value=''>전체</option>";
			$.each(data, function(index, data){
				html += "<option value='"+data+"'>"+data+"</option>";				
			});//end of forEach
			$("#sigungu").html(html);
		},
		error: (x,s,e)=>{
			console.log("실패",x,s,e);
		}
	});//end of ajax
	}//end of loadSigunguList

	$("#sigungu").on("change", function(){
		var sigungu = $("#sigungu").val();
		console.log(sigungu);
		loadDongList(sigungu);
	});

	function loadDongList(sigungu){
	var sigungu = sigungu;
	$.ajax({
		url: "${pageContext.request.contextPath}/admin/loadDongList",
		data:{sigungu:sigungu},
		dataType: "json",
		type: "GET",
		success: data=>{
			console.log(data);
			let html = "<option value=''>전체</option>";
			$.each(data, function(index, data){
				html += "<option value='"+data+"'>"+data+"</option>";				
			});//end of forEach
			$("#dong").html(html);
		},
		error: (x,s,e)=>{
			console.log("실패",x,s,e);
		}
	});//end of ajax
}//end of loadDongList
}

</script>

<h1>회원 거래내역 관리</h1>

<div class="wrapper">
  <div class="input-group">	
  <select  aria-label="First name" class="form-control" id="sido" >
  </select>
  <select  aria-label="First name" class="form-control" id="sigungu" >
  </select>
  <select  aria-label="First name" class="form-control" id="dong" >
  </select>
  </div>
</div>

<div class="input-group mb-3">
  <div class="input-group-prepend">
    <select class="btn btn-outline-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" id="searchType">
		<option value="member_id">아이디</option>
		<option value="order_no">주문번호</option>
	</select>
  </div>
  <input type="text" class="form-control" aria-label="Text input with dropdown button" placeholder="검색어를 입력해 주세요" id="searchKeyword">
   <button class="btn btn-outline-secondary" id="searchMemberOrder">검색</button>
   <button class="btn btn-outline-secondary" id="memberOrderAll">전체</button>

</div>


	<!-- 	<div class="col col-lg-2">
			<input type="text" class='form-control' id="startDate"placeholder='시작날짜선택' readonly>
		</div>
		<span>~</span>
		<div class="col-md-auto">
			<input type="text" class='form-control' id="endDate"placeholder='종료날짜선택' readonly>
		</div> -->
		
	      
	      <!-- <div id="search-status">
	      	<input type="hidden" name="searchType" value="status"/>
	      	<input type="radio" name="searchKeyword" value="I" checked/> 입급내역
	      	<input type="radio" name="searchKeyword" value="O"/> 출금내역
	      </div> -->

		<!-- <div class="input-group mb-3">
			<div class="input-group-prepend">
				<select class="btn btn-outline-secondary dropdown-toggle"
					data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"
					id="searchType">
					<option value="member_id">아이디</option>
					<option value="order_no">주문번호</option>
					<option value="dong">동네(동)</option>
				</select>
			</div>
			<input type="text" class="form-control"
				aria-label="Text input with dropdown button"
				placeholder="검색어를 입력해 주세요" id="searchKeyword">
			<button style="margin-left: 20px;" class="btn btn-primary btn-sm"
				id="searchMemberOrder">검색하기</button>
			<button style="margin-left: 30px;" class="btn btn-primary btn-sm"
				id="memberOrderAll">전체보기</button>
		</div> -->




<div class="table-responsive">
<br /><br />
	<table class="table text-center" id="member-ordeList-tbl">
		
	</table>
</div>
<div id="pageBar">
	
</div>
<input type="hidden" name="cPage" id="cPage"/>





<jsp:include page="/WEB-INF/views/common/footer.jsp"/>