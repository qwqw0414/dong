<%@page import="com.pro.dong.common.util.Utils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>


<h1 style='display: inline-block;'>회원포인트 관리</h1>

<div class="input-group mb-3">
  <div class="input-group-prepend">
     <select class="custom-select" id="searchType" required>
	     <option value="member_id">아이디</option>
	    <option value="reg_date">충전날짜</option>
	    <option value="status">충전/사용</option>
	 </select>

		<!--  <div id="search-status">
	      	<input type="hidden" name="searchType" value="status"/>
	      	<input type="radio"  id="inputRadio" name="searchKeyword" value="I" checked/> 입급내역
	      	<input type="radio" id="outputRadio" name="searchKeyword" value="O"/> 출금내역
	      </div> -->
  </div>
  <input type="text" class="form-control" aria-label="Text input with dropdown button" placeholder="검색어를 입력해 주세요" id="searchKeyword">
   <button class="btn btn-outline-secondary" id="searchMemberPoint">검색</button>
   <button class="btn btn-outline-secondary" id="memberPointAll">전체</button>	
   <br />
		<div class="col col-lg-2">
			<input type="text" class='form-control' id="startDate" placeholder='시작날짜선택' readonly>
		</div>
		<span>~</span>
		<div class="col-md-auto">
			<input type="text" class='form-control' id="endDate" placeholder='종료날짜선택' readonly>
		</div>
 		<button class="btn btn-outline-secondary" id="searchDate">검색</button>
</div>



<div class="table-responsive">
<br /><br />
	<table class="table text-center" id="member-pointList-tbl">
		
	</table>
</div>
<div id="pageBar">
	
</div>
<input type="hidden" name="cPage" id="cPage"/>


<script>
$(function (){
	

	loadMemberPointList();
	
	$("#searchMemberPoint").click(function (){
		var cPage = $("#cPage").val();
		var searchType = $("#searchType").val();
		var searchKeyword = $("#searchKeyword").val();
		
		loadMemberPointList(searchType,searchKeyword,cPage/* ,start,end */);

	});	
	
	$("#memberPointAll").click(function (){
		location.reload();		
	});

	$("#searchDate").click(function (){
		var cPage = $("#cPage").val();
		var start = $("#startDate").val();
		var end = $("#endDate").val();
		
		loadMemberPointDate(cPage,start,end);
	});


	function loadMemberPointDate(cPage,start,end){
		var cPage = cPage;
		var start = start;
		var end = end; 
		
		$("#cPage").val(cPage);
		
		$.ajax({
			url: "${pageContext.request.contextPath}/admin/memberPointDate",
			type: "GET",
			data: {
				cPage:cPage,
				start: start,
				end: end 
			},
			success: data => {
				console.log("memberPointDate@ajax실행즁"+data);
				let header = "<tr><th>아이디</th><th>충전금액</th><th>충전날짜</th><th>잔여포인트</th><th>상태(입/출)</th></tr>";
				let $table = $("#member-pointList-tbl");
				$table.html("");
				let html = "";
				data.list.forEach(cate => {
					html += "<tr><td>"+cate.MEMBER_ID+"</td><td>"+cate.POINT_AMOUNT+"</td><td>"+cate.DATE+"</td><td>"+cate.POINT+"</td><td>"+cate.STATUS+"</td></tr>";
				});
				$table.append(header+html);
				$("#pageBar").html(data.pageBar);
				$("#totalPoint").text(data.totalPoint);
				
			},error : (x,s,e) => {
				console.log("memberPointDate@ajax 실패실패!!!");
			}
			
		});/* end of ajax */
		
	}/* end of loadMemberPointDate */
	
	
	
	
	
	
	
function loadMemberPointList(searchType,searchKeyword,cPage/* ,start,end */){
	var cPage = cPage;
	var searchType = searchType;
	var searchKeyword = searchKeyword;
	if($("#searchType").val()=="충전"){
		option = "I";
	}else if($("#searchType").val()=="사용"){
		option = "O";
	}else
		option = "";

	
	$("#cPage").val(cPage);
	
	$.ajax({
		url: "${pageContext.request.contextPath}/admin/memberPointListEnd",
		type: "GET",
		data: {
			cPage:cPage,
			searchType: searchType,
			searchKeyword: searchKeyword
			/* start: start,
			end: end */
		},
		success: data => {
			console.log("memberPointList@ajax실행즁"+data);
			let header = "<tr><th>아이디</th><th>충전금액</th><th>충전날짜</th><th>잔여포인트</th><th>상태(입/출)</th></tr>";
			let $table = $("#member-pointList-tbl");
			$table.html("");
			let html = "";
			data.list.forEach(cate => {
				html += "<tr><td>"+cate.MEMBER_ID+"</td><td>"+cate.POINT_AMOUNT+"</td><td>"+cate.DATE+"</td><td>"+cate.POINT+"</td><td>"+cate.STATUS+"</td></tr>";
			});
			$table.append(header+html);
			$("#pageBar").html(data.pageBar);
			$("#totalPoint").text(data.totalPoint);
			
		},error : (x,s,e) => {
			console.log("memberPointList@ajax 실패실패!!!");
		}
	});/* end of ajax */
	}/* end of loadMemberPointList */
});/* end of function */
</script>


















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