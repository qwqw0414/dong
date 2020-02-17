<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name="pageTitle"></jsp:param>
</jsp:include>

<script>
$(()=>{
	
	loadBoardList(1);
	
	/* 스위치 버튼 함수 */
	$("#customSwitch1").change(function(){
		var checked = $(this).prop("checked");
		if(checked == false){
			$(this).next().html("신고글보기");
			loadBoardList(1);
		}	
		else if(checked == true){
			$(this).next().html("일반글보기");
			loadReportBoardList(1);
		}
	});
	
	$("#search").on("click", function(){
		var checked = $("#customSwitch1").prop("checked");
		if(checked == false){
			loadBoardList(1);
		}
		else{
			loadReportBoardList(1);
		}
		$("#searchKeyword").val('');
	});
	
	function loadBoardList(cPage){
		var sido = $("#sido").val();
		var sigungu = $("#sigungu").val();
		var dong = $("#dong").val();
		var searchType = $("#searchType").val();
		var searchKeyword = $("#searchKeyword").val();
		var type = type;
		$.ajax({
			url: "${pageContext.request.contextPath}/admin/loadBoardList",
			type: "GET",
			data:{cPage:cPage,
				searchType:searchType,
				searchKeyword:searchKeyword,
				sido:sido,
				sigungu:sigungu,
				dong:dong
				},
			success: data=>{
				console.log(data);
				let $table = $("#member-list-tbl");
		    	$table.html("");
		    	let header = "<tr><th>No</th><th>카테고리</th><th>작성자</th><th>제목</th><th>작성일</th><th>조회수</th><th>누적신고수</th></tr>";
		    	let	html = "";
		    	for(var i=0; i<data.list.length;i++){
		    		html += "<tr>";
		    		html += "<td><a href='${pageContext.request.contextPath}/board/boardView.do?boardNo="+data.list[i].BOARD_NO+"'>"+data.list[i].BOARD_NO+"</a></td>";
		    		html += "<td>"+data.list[i].CATEGORY_ID+"</td>";
		    		html += "<td>"+data.list[i].MEMBER_ID+"</td>";
		    		html += "<td>"+data.list[i].BOARD_TITLE+"</td>";
		    		html += "<td>"+life(data.list[i].WRITE_DATE)+"</td>";
		    		html += "<td>"+data.list[i].READ_COUNT+"</td>";
		    		html += "<td>"+data.list[i].CNT+"</td>";
		    		html += "</tr>";
		    	}
		    	$table.append(header+html);
				$("#pageBar").html(data.pageBar);
			},
			error : (x, s, e) => {
				console.log("ajax 요청 실패!",x,s,e);
	    	},
			complete: (data)=>{
	        
	        	$("#pageBar a").click((e)=>{
	        		loadBoardList($(e.target).siblings("input").val());
            	});
	      	}
		});//end of ajax
	}//end of loadBoardList();
	
	function life(date){
		var preDate = new Date(date);

		var year = preDate.getFullYear();
		var month = preDate.getMonth()+1;
		var date = preDate.getDate();

		if(month < 10) month = "0"+month;
		if(date < 10) date = "0"+date;

		return year+"/"+month+"/"+date;
	}

	function loadReportBoardList(cPage){
		var sido = $("#sido").val();
		var sigungu = $("#sigungu").val();
		var dong = $("#dong").val();
		var searchType = $("#searchType").val();
		var searchKeyword = $("#searchKeyword").val();
		var type = type;
		console.log(searchType);
		console.log(searchKeyword);
		console.log(cPage);
		console.log(sido);
		console.log(sigungu);
		console.log(dong);
		$.ajax({
			url: "${pageContext.request.contextPath}/admin/loadReportBoardList",
			type: "GET",
			data:{cPage:cPage,
				searchType:searchType,
				searchKeyword:searchKeyword,
				sido:sido,
				sigungu:sigungu,
				dong:dong
				},
			success: data=>{
				console.log(data);
				let $table = $("#member-list-tbl");
		    	$table.html("");
		    	let header = "<tr><th>No</th><th>카테고리</th><th>작성자</th><th>제목</th><th>작성일</th><th>조회수</th><th>누적신고수</th><th>처리상태</th></tr>";
		    	let	html = "";
		    	for(var i=0; i<data.list.length;i++){
		    		html += "<tr>";
		    		html += "<td><a href='${pageContext.request.contextPath}/board/boardView.do?boardNo="+data.list[i].BOARD_NO+"'>"+data.list[i].BOARD_NO+"</a></td>";
		    		html += "<td>"+data.list[i].CATEGORY_ID+"</td>";
		    		html += "<td>"+data.list[i].MEMBER_ID+"</td>";
		    		html += "<td>"+data.list[i].BOARD_TITLE+"</td>";
		    		html += "<td>"+data.list[i].WRITE_DATE+"</td>";
		    		html += "<td>"+data.list[i].READ_COUNT+"</td>";
		    		html += "<td>"+data.list[i].CNT+"</td>";
		    		if(data.list[i].STATUS == 'N'){
		    			html += "<td>대기</td>";
		    		}
		    		else if(data.list[i].STATUS == 'Y'){
		    			html += "<td>완료</td>";
		    		}
		    		html += "</tr>";
		    	}
		    	$table.append(header+html);
				$("#pageBar").html(data.pageBar);
			},
			error : (x, s, e) => {
				console.log("ajax 요청 실패!",x,s,e);
	    	},
			complete: (data)=>{
	        
	        	$("#pageBar a").click((e)=>{
	        		loadBoardList($(e.target).siblings("input").val());
            	});
	      	}
		});//end of ajax
	}//end of loadBoardList();
	
	
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


}); //end of onload
</script>

<h1 style='display: inline-block;'>게시글 관리</h1>
<div style='display: inline;' class="custom-control custom-switch">
  <input type="checkbox" class="custom-control-input" id="customSwitch1">
  <label class="custom-control-label" for="customSwitch1">신고글보기</label>
</div>
<div class="wrapper">
  <div class="input-group">	
  <select  aria-label="First name" class="form-control" id="sido" >
	  <option value="">전체</option>
  </select>
  <select  aria-label="First name" class="form-control" id="sigungu" >
	<option value="">전체</option>
  </select>
  <select  aria-label="First name" class="form-control" id="dong" >
	<option value="">전체</option>
  </select>
  </div>
</div>

<div class="input-group mb-3">
  <div class="input-group-prepend">
    <select class="btn btn-outline-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" id="searchType">
      <option class="dropdown-item" value="board_title" >제목</option>
      <option class="dropdown-item" value="member_id" >작성자</option>
    </select>
  </div>
  <input type="text" class="form-control" aria-label="Text input with dropdown button" placeholder="검색어를 입력해 주세요" id="searchKeyword">
  <button class="btn btn-outline-secondary" id="search">검색</button>
</div>

<div class="table-responsive">
<br /><br />
	<table class="table text-center" id="member-list-tbl">
		<tr>
		<th>No</th>
		<th>카테고리</th>
		<th>작성자</th>
		<th>제목</th>
		<th>작성일</th>
		<th>조회수</th>
		</tr>
	</table>
</div>

<!-- 페이징바 Div -->
<div id="pageBar"></div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>