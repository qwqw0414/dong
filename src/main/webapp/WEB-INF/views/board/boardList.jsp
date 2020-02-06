<%@page import="java.util.ArrayList"%>
<%@page import="com.pro.dong.board.model.vo.BoardCategory"%>
<%@page import="java.util.List"%>
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
	
	//카테고리로 정렬
	$("#boardCategory").change(function(){
		var cPage = $("#cPage").val();
		var boardCategory = $("#boardCategory").val();
		var boardCategory = $("#boardCategory").val();
		var searchType = $("#searchType").val();
		console.log(boardCategory);
		console.log(cPage);
		loadBoardList(searchType,searchKeyword,boardCategory,cPage);
	});
	
	//검색어 입력
	$("#searchBoard").click(function(){
		var cPage = $("#cPage").val();
		var boardCategory = $("#boardCategory").val();
		var searchType = $("#searchType").val();
		var searchKeyword = $("#searchKeyword").val();
		if(searchKeyword.length==0){
			alert("검색어를 입력하세요");
			$("#searchKeyword").focus();
			return;
		} else {
			loadBoardList(searchType,searchKeyword,boardCategory,cPage);
		}
		
	});
	
	
});
function loadBoardList(searchType,searchKeyword, boardCategory, cPage){
	if(<%=memberLoggedIn==null%>){
		var memberId = "";		
	} else {
		var memberId = "<%=memberLoggedIn.getMemberId()%>";	
	}
	var cPage = cPage;
	var boardCategory = boardCategory;
	var searchType = searchType;
	var searchKeyword = searchKeyword;
	$("#cPage").val(cPage);
	$.ajax({
		url: "${pageContext.request.contextPath}/board/loadBoardList",
		type: "GET",
		data: {memberId:memberId,
			cPage:cPage,
			boardCategory:boardCategory,
			searchType:searchType,
			searchKeyword:searchKeyword},
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
<section id="board-container" class="container">
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
		<div class="form-group mx-sm-3 mb-2 mx-auto">
	    <div class="input-group mb-3">
		  <label for="searchKeyword" class="sr-only">검색</label>
		  <select class="custom-select" id="searchType" required>
	     	<option value="member_id" selected>아이디</option>
	     	<option value="board_title">글제목</option>
	      </select>
		  <input type="text" size="30" id="searchKeyword" placeholder="검색어를 입력하세요">
		  <div class="input-group-append">
	      <button class="btn btn-primary mb-2" id="searchBoard">검색하기</button>
          </div>
	    </div>
	  </div>
	<input type="hidden" name="cPage" id="cPage"/>
<script>
function fn_goWriteBoard(){
	location.href = "${pageContext.request.contextPath}/board/writeBoard.do";
	}
</script>
</section> 
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>