<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name="pageTitle"></jsp:param>
</jsp:include>

<h1 style='display: inline-block;'>상품 신고 관리</h1>

<div class="input-group mb-3">
  <div class="input-group-prepend">
    <select class="btn btn-outline-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" id="searchType">
      <option class="dropdown-item" value="member_id" >신고자ID</option>
      <option class="dropdown-item" value="status" >처리여부</option>
      <option class="dropdown-item" value="category_id" >카테고리</option>
    </select>
  </div>
  <input type="text" class="form-control" aria-label="Text input with dropdown button" placeholder="검색어를 입력해 주세요" id="searchKeyword">
  <div id="statusRadioBtnDiv">
  	<input type="radio" name="statusRadio" value="N" checked="checked">대기
  	<input type="radio" name="statusRadio" value="Y">완료
  </div>
  <div id="categoryRadioBtnDiv">
  	<input type="radio" name="categoryRadio" value="A001" checked="checked">사기신고
  	<input type="radio" name="categoryRadio" value="A002">부적절한 게시글
  	<input type="radio" name="categoryRadio" value="A003">언어폭력
  </div>
  <button class="btn btn-outline-secondary" id="search">검색</button>
</div>

<div class="table-responsive">
<br /><br />
	<table class="table text-center" id="productReport-list-tbl">
		<tr>
		<th>No</th>
		<th>신고접수일</th>
		<th>카테고리</th>
		<th>작성자</th>
		<th>신고내용</th>
		<th>답변상태</th>
		<th>첨부파일</th>
		</tr>
	</table>
</div>



<!-- 페이징바 Div -->
<div id="pageBar"></div>

<script>
$(()=>{
	
	loadProductReportList(1);
	
	/* 검색버튼 누른 후  함수 호출*/
	$("#search").on("click", function(){
		var searchType = $("#searchType option:selected").val();
		console.log("searchType=");
		console.log(searchType);
		
		if(searchType == 'status'){
			var searchKeyword = $('input[name="statusRadio"]:checked').val();
			console.log("searchKeyword=");
			console.log(searchKeyword);
			loadProductReportList(1, searchType, searchKeyword);
		}
		else if(searchType == 'category_id'){
			var searchKeyword = $('input[name="categoryRadio"]:checked').val();
			console.log("searchKeyword=");
			console.log(searchKeyword);
			loadProductReportList(1, searchType, searchKeyword);
		}
		else{
			var searchKeyword = $("#searchKeyword").val();
			console.log("searchKeyword=");
			console.log(searchKeyword);
			loadProductReportList(1, searchType, searchKeyword);
			
		}
	});
	
	/* 검색타입에 따른 Div처리 */
	$("#statusRadioBtnDiv").hide();
	$("#categoryRadioBtnDiv").hide();
	
	$("#searchType").change(function(){
		var $searchType = $("#searchType option:selected").val();
		
		if($searchType == 'status'){
			$("#searchKeyword").hide();
			$("#categoryRadioBtnDiv").hide();
			$("#statusRadioBtnDiv").show();
		}
		else if($searchType == 'category_id'){
			$("#searchKeyword").hide();
			$("#statusRadioBtnDiv").hide();
			$("#categoryRadioBtnDiv").show();
		}
		else {
			$("#statusRadioBtnDiv").hide();
			$("#categoryRadioBtnDiv").hide();
			$("#searchKeyword").show();
		}
	});
	
	function loadProductReportList(cPage, searchType, searchKeyword){
		
		var searchType = searchType;
		var searchKeyword = searchKeyword;
		var type = type;
		$.ajax({
			url: "${pageContext.request.contextPath}/admin/loadProductReportList",
			type: "GET",
			data:{cPage:cPage,
				searchType:searchType,
				searchKeyword:searchKeyword
				},
			success: data=>{
				console.log(data);
				let $table = $("#productReport-list-tbl");
		    	$table.html("");
		    	let header = "<tr><th>No</th><th>신고접수일</th><th>카테고리</th><th>작성자</th><th>신고내용</th><th>처리상태</th><th>첨부파일</th></tr>";
		    	let	html = "";
		    	for(var i=0; i<data.list.length;i++){
		    		
		    		if(data.list[i].REPORT_CONTENTS.length > 12) 
		    			data.list[i].REPORT_CONTENTS = data.list[i].REPORT_CONTENTS.substring(0,12)+"..."
		    		
		    		html += "<tr>";
		    		html += "<td><a href='${pageContext.request.contextPath}/admin/productReportView.do?boardNo="+data.list[i].REPORT_NO+"'>"+data.list[i].REPORT_NO+"</a></td>";
		    		html += "<td>"+life(data.list[i].REPORT_DATE)+"</td>";
		    		if(data.list[i].CATEGORY_ID == 'A001'){
		    			html += "<td>사기신고</td>";
		    		}
		    		else if(data.list[i].CATEGORY_ID == 'A002'){
		    			html += "<td>부적절한 게시글</td>";
		    		}
		    		else if(data.list[i].CATEGORY_ID == 'A003'){
		    			html += "<td>언어폭력</td>";
		    		}
		    		html += "<td>"+data.list[i].MEMBER_ID+"</td>";
		    		html += "<td>"+data.list[i].REPORT_CONTENTS+"</td>";
		    		if(data.list[i].STATUS == 'N'){
		    			html += "<td>대기</td>";
		    		}
		    		else{
		    			html += "<td>완료</td>";
		    		}
		    		if(data.list[i].REPORT_IMAGE == null) {
		    			html += "<td>X</td>";
		    		}
		    		else{
		    			html += "<td>O</td>";
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
	        		loadProductReportList($(e.target).siblings("input").val(), searchType, searchKeyword);
            	});
	      	}
		});//end of ajax
	}//end of loadProductReportList();
		
	function life(date){
		var preDate = new Date(date);

		var year = preDate.getFullYear();
		var month = preDate.getMonth()+1;
		var date = preDate.getDate();

		if(month < 10) month = "0"+month;
		if(date < 10) date = "0"+date;

		return year+"/"+month+"/"+date;
	}
	
});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>