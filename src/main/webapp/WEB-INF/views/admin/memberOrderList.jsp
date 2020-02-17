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
				html += "<tr><td>"+cate.ORDER_NO+"</td><td>"+cate.MEMBER_ID+"</td><td>"+cate.PRODUCT_NO+"</td><td>"+cate.DONG+"</td><td>"+cate.PRICE+"</td><td>"+cate.DATE+"</td></tr>";
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
	<!-- 	<div class="col col-lg-2">
			<input type="text" class='form-control' id="startDate"placeholder='시작날짜선택' readonly>
		</div>
		<span>~</span>
		<div class="col-md-auto">
			<input type="text" class='form-control' id="endDate"placeholder='종료날짜선택' readonly>
		</div> -->
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