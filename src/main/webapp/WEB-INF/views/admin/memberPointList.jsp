<%@page import="com.pro.dong.common.util.Utils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>


<h1 style='display: inline-block;'>회원포인트 관리</h1>
<div style='display: inline;' class="custom-control custom-switch">
  <input type="checkbox" class="custom-control-input" id="customSwitch1">
  <label class="custom-control-label" for="customSwitch1">충전내역 보기</label>
</div>

<div class="input-group mb-3">
  <div class="input-group-prepend">

	</div>
  <input type="text" class="form-control" aria-label="Text input with dropdown button" placeholder="검색할 아이디를 입력해 주세요" id="searchKeyword">
		<div class="col col-lg-2">
			<input type="text" class='form-control' id="startDate" placeholder='시작날짜선택' readonly>
		</div>
		<span>~</span>
		<div class="col-md-auto">
			<input type="text" class='form-control' id="endDate" placeholder='종료날짜선택' readonly>
		</div>
   <button class="btn btn-outline-secondary" id="searchMemberPoint">검색</button>
   <button class="btn btn-outline-secondary" id="memberPointAll">전체</button>	
   <br />
</div>



<div class="table-responsive">
<br /><br />
	<table class="table text-center" id="member-pointList-tbl">
		
	</table>
</div>
<div id="pageBar"></div>

<script>
$(() => {
	loadMemberPointList(1);
	
	/* 스위치 버튼 함수 */
		$("#customSwitch1").change(function(){
		var checked = $(this).prop("checked");
		if(checked == false){
			$(this).next().html("충전내역 보기");
			loadMemberPointList(1);
		}	
		else if(checked == true){
			$(this).next().html("사용내역 보기");
			loadMemberPointOutList(1);
		}
	});

	$("#searchMemberPoint").on("click", function (){
		var searchType = $("#searchType").val();
		var searchKeyword = $("#searchKeyword").val();
		var start = $("#startDate").val();
		var end = $("#endDate").val();
		var checked = $("#customSwitch1").prop("checked");
		
		if(checked == false){
			loadMemberPointList(1);
		}
		else{
			loadMemberPointOutList(1);
		}
		$("#searchKeyword").val('');
		
	});	
	
	$("#memberPointAll").click(function (){
		location.reload();		
	});


	function loadMemberPointList(cPage){
		var searchType = $("#searchType").val();
		var searchKeyword = $("#searchKeyword").val();
		var start = $("#startDate").val();
		var end = $("#endDate").val();

		
		$.ajax({
			url: "${pageContext.request.contextPath}/admin/memberPointListEnd",
			type: "GET",
			data: {
				cPage:cPage,
				searchType: searchType,
				searchKeyword: searchKeyword,
				start: start,
				end: end
			},
			dataType:"json",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success: data => {
				console.log("memberPointList@ajax실행즁"+data);
				let header = "<tr><th>아이디</th><th>충전금액</th><th>충전날짜</th><th>잔여포인트</th><th>상태(입/출)</th></tr>";
				let $table = $("#member-pointList-tbl");
				$table.html("");
				let html = "";
				data.list.forEach(cate => {
					if(cate.STATUS === "I"){
						html += "<tr><td>"+cate.MEMBER_ID+"</td><td>"+cate.POINT_AMOUNT+"</td><td>"+cate.DATE+"</td><td>"+cate.POINT+"</td><td>"+"충전"+"</td></tr>";
					}
				});
				$table.append(header+html);
				
				$("#pageBar").html(data.pageBar);
				$("#totalPoint").text(data.totalPoint);
				
			},error : (x,s,e) => {
				console.log("memberPointList@ajax 실패실패!!!");
			},complete: (data) => {
				$("#pageBar").click((e) => {
					loadMemberPointList($(e.target).siblings("input").val());
				});
			}
		});/* end of ajax */
	}/* end of loadMemberPointList */
	
	/* ================================================================================= */
	function loadMemberPointOutList(cPage){
		var searchType = $("#searchType").val();
		var searchKeyword = $("#searchKeyword").val();
		var start = $("#startDate").val();
		var end = $("#endDate").val();

		
		$.ajax({
			url: "${pageContext.request.contextPath}/admin/memberPointOutListEnd",
			type: "GET",
			data: {
				cPage:cPage,
				searchType: searchType,
				searchKeyword: searchKeyword,
				start: start,
				end: end
			},
			dataType:"json",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success: data => {
				console.log("memberPointOutList@ajax실행즁"+data);
				let header = "<tr><th>아이디</th><th>충전금액</th><th>충전날짜</th><th>잔여포인트</th><th>상태(입/출)</th></tr>";
				let $table = $("#member-pointList-tbl");
				$table.html("");
				let html = "";
				data.list.forEach(cate => {
					if(cate.STATUS !== "I"){
						html += "<tr><td>"+cate.MEMBER_ID+"</td><td>"+cate.POINT_AMOUNT+"</td><td>"+cate.DATE+"</td><td>"+cate.POINT+"</td><td>"+"사용"+"</td></tr>";
					}
				});
				$table.append(header+html);
				
				$("#pageBar").html(data.pageBar);
				$("#totalPoint").text(data.totalPoint);
				
			},error : (x,s,e) => {
				console.log("memberPointOutList@ajax 실패실패!!!");
			},complete: () => {
				$("#pageBar").click((e) => {
					loadMemberPointOutList($(e.target).siblings("input").val());
				});
			}
		});/* end of ajax */
	}/* end of loadMemberPointOutList */
	
});
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