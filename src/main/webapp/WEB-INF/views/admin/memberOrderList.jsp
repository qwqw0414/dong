<%@page import="com.pro.dong.common.util.Utils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<script>
$(() => {
	loadMemberOrderList(1);
	
	$("#searchMemberOrder").click(function (){
		
		loadMemberOrderList(1);
		
	});
	
	$("#memberOrderAll").click(function (){
		location.reload();
	});


function loadMemberOrderList(cPage){
	var sido = $("#sido").val();
	var sigungu = $("#sigungu").val();
	var dong = $("#dong").val();
	var searchType = $("#searchType").val();
	var searchKeyword = $("#searchKeyword").val();
	var start = $("#startDate").val();
	var end = $("#endDate").val();
	
	
	$.ajax({
		url : "${pageContext.request.contextPath}/admin/memberOrderListEnd",
		type : "GET",
		data: {
			cPage: cPage,
			searchType: searchType,
			searchKeyword: searchKeyword,
			start: start,
			end: end,
			sido: sido,
			sigungu: sigungu,
			dong:dong
		}, 
		dataType:"json",
		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		success: data => {
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
		},complete: () => {
			$("#pageBar a").click((e) => {
				loadMemberOrderList($(e.target).siblings("input").val());
			});
		}
	});
	}/* end of loadMemberOrderList */
	
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
		},complete: (data)=>{
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
			let html = "";
			$.each(data, function(index, data){
				html += "<option value='"+data+"'>"+data+"</option>";				
			});//end of forEach
			$("#sigungu").html(html);
		},
		error: (x,s,e)=>{
			console.log("실패",x,s,e);
		},complete: (data)=>{
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
				let html = "";
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
	
}); //end of (()=>)
	

</script>

<h1>회원 거래내역 관리</h1>

<div class="wrapper">
  <div class="input-group">	
  <select  aria-label="First name" class="form-control" id="sido" >
  <option value=''>전체</option>
  </select>
  <select  aria-label="First name" class="form-control" id="sigungu" >
  <option value=''>전체</option>
  </select>
  <select  aria-label="First name" class="form-control" id="dong" >
  <option value=''>전체</option>
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
		<div class="col col-lg-2">
			<input type="text" class='form-control' id="startDate" placeholder='시작날짜선택' readonly>
		</div>
		<span>~</span>
		<div class="col-md-auto">
			<input type="text" class='form-control' id="endDate" placeholder='종료날짜선택' readonly>
		</div>
   <button class="btn btn-outline-secondary" id="searchMemberOrder">검색</button>
   <button class="btn btn-outline-secondary" id="memberOrderAll">전체</button>
</div>

<div class="table-responsive">
<br /><br />
	<table class="table text-center" id="member-ordeList-tbl">
		
	</table>
</div>
<div id="pageBar">
	
</div>


<!-- 달력 스크립트 -->
<script type="text/javascript">
  $(document).ready(function () {
          $.datepicker.setDefaults($.datepicker.regional['ko']); 
          $( "#startDate" ).datepicker({
               changeMonth: true, 
               changeYear: true,
               nextText: '다음 달',
               prevText: '이전 달', 
               dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
               dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], 
               monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
               monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
               dateFormat: "yymmdd",
               maxDate: 0,                       // 선택할수있는 최소날짜, ( 0 : 오늘 이후 날짜 선택 불가)
               onClose: function( selectedDate ) {    
                    //시작일(startDate) datepicker가 닫힐때
                    //종료일(endDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
                   $("#endDate").datepicker( "option", "minDate", selectedDate );
               }    

          });
          $( "#endDate" ).datepicker({
               changeMonth: true, 
               changeYear: true,
               nextText: '다음 달',
               prevText: '이전 달', 
               dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
               dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], 
               monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
               monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
               dateFormat: "yymmdd",
               maxDate: 0,                       // 선택할수있는 최대날짜, ( 0 : 오늘 이후 날짜 선택 불가)
               onClose: function( selectedDate ) {    
                   // 종료일(endDate) datepicker가 닫힐때
                   // 시작일(startDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 시작일로 지정
                   $("#startDate").datepicker( "option", "maxDate", selectedDate );
               }    

          });    
  });
</script>




<jsp:include page="/WEB-INF/views/common/footer.jsp"/>