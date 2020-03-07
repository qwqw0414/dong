<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>

<div id="boardReportViewTotalDiv">
<div class="modal fade bd-example-modal-xl" tabindex="-1" role="dialog" aria-labelledby="myExtraLargeModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<h1 class="text-center" style="margin-top:40px;">신고내역</h1>
			<div class="table-responsive">
				<br /><br />
				<table class="table text-center" id="boardReport-list-tbl">
				<tr>
					<th>No</th>
					<th>카테고리</th>
					<th>작성자</th>
					<th>신고내용</th>
					<th>작성일</th>
					<th>처리상태</th>
				</tr>
				</table>
			</div>
		</div>
	</div>
</div>
</div>
<script>
$(()=>{
	
	$("#adminLook").on('click', function(){
		loadReportList();
	});
	
	function loadReportList(){
		var boardNo = ${board.boardNo};
		console.log(boardNo);
		$.ajax({
			url: "${pageContext.request.contextPath}/board/selectBoardReportList",
			data: {
				boardNo : boardNo
			},
			dataType:"json",
			type:"GET",
			contentType: "application/json; charset=utf-8",
			success: data => {
				let $table = $("#boardReport-list-tbl");
		    	$table.html("");
		    	let header = "<tr><th>No</th><th>카테고리</th><th>작성자</th><th>신고내용</th><th>작성일</th><th>처리상태</th></tr>";
		    	let	html = "";
				console.log(data);
				for(var i = 0; i<data.list.length; i++){
					html += "<tr>";
		    		html += "<td>"+data.list[i].REPORT_NO+"</td>";
		    		html += "<td>"+data.list[i].RCATEGORY+"</td>";
		    		html += "<td>"+data.list[i].MEMBER_ID+"</td>";
		    		html += "<td>"+data.list[i].REPORT_COMMENT+"</td>";
		    		html += "<td>"+life(data.list[i].WRITE_DATE)+"</td>";
		    		if(data.list[i].STATUS == "Y"){
			    		html += "<td><button id='statusOk' disabled>처리완료</button></td>";
		    		}
		    		if(data.list[i].STATUS == "N"){
			    		html += "<td><button value='"+data.list[i].REPORT_NO+"' id='statusOk'>처리대기</button></td>";
		    		}
		    		html += "</tr>";
				}
				$table.append(header+html);
			},error:(x,s,e) => {
				console.log(x, s, e);
			}
		}); 
	}
	
	$(document).on("click", "#boardReport-list-tbl #statusOk", function(e){
		var reportNo = $(e.target).val();
		console.log(reportNo);
		
		$.ajax({
			url: "${pageContext.request.contextPath}/board/updateReportStatus",
			data: {
				reportNo : reportNo
			},
			dataType:"json",
			type:"GET",
			contentType: "application/json; charset=utf-8",
			success: data => {
				console.log(data);
				loadReportList();
			},error:(x,s,e) => {
				console.log(x, s, e);
			}
		}); 
	});
	
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
