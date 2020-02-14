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
	
	function loadProductReportList(cPage){
		
		var searchType = $("#searchType").val();
		var searchKeyword = $("#searchKeyword").val();
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
		    	let header = "<tr><th>No</th><th>신고접수일</th><th>카테고리</th><th>작성자</th><th>신고내용</th><th>답변상태</th><th>첨부파일</th></tr>";
		    	let	html = "";
		    	for(var i=0; i<data.list.length;i++){
		    		html += "<tr>";
		    		html += "<td><a href='${pageContext.request.contextPath}/admin/boardView.do?boardNo="+data.list[i].REPORT_NO+"'>"+data.list[i].REPORT_NO+"</a></td>";
		    		html += "<td>"+data.list[i].REPORT_DATE+"</td>";
		    		if(data.list[i].CATEGORY_ID = 'A001'){
		    			html += "<td>사기신고</td>";
		    		}
		    		else if(data.list[i].CATEGORY_ID = 'A002'){
		    			html += "<td>부적절한 게시글</td>";
		    		}
		    		else if(data.list[i].CATEGORY_ID = 'A003'){
		    			html += "<td>언어폭력</td>";
		    		}
		    		html += "<td>"+data.list[i].MEMBER_ID+"</td>";
		    		html += "<td>"+data.list[i].REPORT_COMMENT+"</td>";
		    		if(data.list[i].STATUS == 'N'){
		    			html += "<td>답변대기</td>";
		    		}
		    		else{
		    			html += "<td>답변완료</td>";
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
	        		loadProductReportList($(e.target).siblings("input").val());
            	});
	      	}
		});//end of ajax
	}//end of loadProductReportList();
		
});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>