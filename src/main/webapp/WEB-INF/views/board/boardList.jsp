<%@page import="java.util.ArrayList"%>
<%@page import="com.pro.dong.board.model.vo.BoardCategory"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="com.pro.dong.common.util.Utils"%>
<%@page import="com.pro.dong.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	Member memberLoggedIn = (Member)request.getSession().getAttribute("memberLoggedIn");
	List<BoardCategory> list = new ArrayList<>();
	list = (List<BoardCategory>)request.getAttribute("boardCategoryList");
	String option = "";
	option += "<option value=''/>전체</option>";
	for(BoardCategory bc: list){
		option +=  "<option value=\""+bc.getCategoryId()+"\">"+bc.getCategoryName()+"</option>";
	}
%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<script>
$(function(){
	loadBoardList();
	
	$("#boardCategory").change(function(){
		var cPage = $("#cPage").val();
		var boardCategory = $("#boardCategory").val();
		console.log(boardCategory);
		console.log(cPage);
		loadBoardList(boardCategory,cPage);
	});
});
function loadBoardList(boardCategory, cPage){
	if(<%=memberLoggedIn==null%>){
		var memberId = "";		
	} else {
		var memberId = "<%=memberLoggedIn.getMemberId()%>";	
	}
	var cPage = cPage;
	var boardCategory = boardCategory;
	$("#cPage").val(cPage);
	$.ajax({
		url: "${pageContext.request.contextPath}/board/loadBoardList",
		type: "GET",
		data: {memberId:memberId,
			cPage:cPage,
			boardCategory:boardCategory},
		success: data=>{
			let header = "<tr><th>카테고리</th><th>번호</th><th>작성자</th><th>제목</th><th>작성일</th><th>조회수</th></tr>";
	    	let $table = $("#tbl-board");
	    	$table.html("");
			let	html = "";
	    	for(var i=0; i<data.list.length;i++){
	    		html += "<tr>";
	    		html += "<td>"+data.list[i].CATEGORY_NAME+"</td>";
	    		html += "<td>"+data.list[i].BOARD_NO+"</td>";
	    		html += "<td>"+data.list[i].MEMBER_ID+"</td>";
	    		html += "<td><a href='${pageContext.request.contextPath}/board/boardView.do?boardNo="+data.list[i].BOARD_NO+"'>"+data.list[i].BOARD_TITLE+"</a></td>";
	    		html += "<td>"+data.list[i].WRITE_DATE+"</td>";
	    		html += "<td>"+data.list[i].READ_COUNT+"</td>";
	    		html += "</tr>";
	    	}
	    	$table.append(header+html);
	    	$("#totalContents").text("총 "+data.totalContents+"건의 게시글이 있습니다");
			$("#pageBar").html(data.pageBar);

			
	    	},
	    	error : (x, s, e) => {
				console.log("ajax 요청 실패!",x,s,e);
	    	}
	});//end of ajax
	

	
}
</script>
 <h1>커뮤니티 게시판</h1>
 <script>
 
 
 </script>
<section id="board-container" class="container">
	<div class="row">
		<div class="col-md-12">
		<br /><br />
		<h4>인기글</h4>
			<table id="po-board" class="table table-striped table-hover">
				<tr>
					<th>글번호</th>
					<th>제목</th>
					<th>글쓴이</th>
					<th>작성일</th>
					<th>조회</th>
					<th>추천</th>
				</tr>
				<c:forEach items="${boardList}" var="list" varStatus="vs">
					<tr>
						<td>${list.BOARD_NO}</td>
						<td><a href='${pageContext.request.contextPath}/board/boardView.do?boardNo=${list.BOARD_NO}'>${list.BOARD_TITLE}</a></td>
						<td>${list.MEMBER_ID}</td>
						<td>${list.WRITE_DATE}</td>
						<td>${list.READ_COUNT}</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<div class="col-md-12">
			<br /><br /><br />
		</div>
	</div>

	<div class="col-md-3 mb-3">
      <label for="boardCategory">카테고리</label>
      <select class="custom-select" id="boardCategory" required>
     	<%=option %>
      </select>
    </div>
	<p id="totalContents"></p>
	<input type="button" value="글쓰기" id="btn-add" class="btn btn-outline-success" onclick="fn_goWriteBoard();"/>
	<table id="tbl-board" class="table table-striped table-hover">
		
	</table>
	<!-- pageBar 출력 -->
	<div id="pageBar">
	
	</div>
	<input type="hidden" name="cPage" id="cPage"/>
<script>
function fn_goWriteBoard(){
	location.href = "${pageContext.request.contextPath}/board/writeBoard.do";
	}
</script>
</section> 
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>