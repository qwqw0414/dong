<%@page import="com.pro.dong.common.util.Utils"%>
<%@page import="com.pro.dong.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	Member memberLoggedIn = (Member)request.getSession().getAttribute("memberLoggedIn");
%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<script>
$(function(){
	loadBoardList();
});
function loadBoardList(cPage){
	if(<%=memberLoggedIn==null%>){
		var memberId = "";		
	} else {
		var memberId = "<%=memberLoggedIn.getMemberId()%>";	
	}
	var cPage = cPage;
	console.log(memberId);
	console.log(cPage);
	$.ajax({
		url: "${pageContext.request.contextPath}/board/loadBoardList",
		type: "GET",
		data: {memberId:memberId,
			cPage:cPage},
		success: data=>{
	    		console.log(data);
	    	let $table = $("#tbl-board");
			let	html = "";
		
	    	for(var i=0; i<data.list.length;i++){
	    		html += "<tr>";
	    		html += "<td>"+data.list[i].BOARD_NO+"</td>";
	    		html += "<td>"+data.list[i].MEMBER_ID+"</td>";
	    		html += "<td>"+data.list[i].CATEGORY_ID+"</td>";
	    		html += "<td>"+data.list[i].BOARD_TITLE+"</td>";
	    		html += "<td>"+data.list[i].WRITE_DATE+"</td>";
	    		html += "<td>"+data.list[i].READ_COUNT+"</td>";
	    		html += "</tr>";
	    	}
	    	$table.html(html);
	    	$("#totalContents").text("총 "+data.totalContents+"건의 게시글이 있습니다");
			$("#pageBar").html(data.pageBar);
	    	},
	    	error : (x, s, e) => {
				console.log("ajax 요청 실패!");
			}
	});//end of ajax
}
</script>
 <h1>커뮤니티 게시판</h1>
<section id="board-container" class="container">
	<p id="totalContents"></p>
	<input type="button" value="글쓰기" id="btn-add" class="btn btn-outline-success" onclick="fn_goWriteBoard();"/>
	<table id="tbl-board" class="table table-striped table-hover">
		<tr>
			<th>번호</th>
			<th>작성자</th>
			<th>구분</th>
			<th>제목</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
	</table>
	<!-- pageBar 출력 -->
	<div id="pageBar">
	
	</div>
	
<script>
function fn_goWriteBoard(){
	location.href = "${pageContext.request.contextPath}/board/writeBoard.do";
	}
</script>
</section> 
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>