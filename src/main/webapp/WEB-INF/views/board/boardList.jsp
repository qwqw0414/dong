<%@page import="java.util.ArrayList"%>
<%@page import="com.pro.dong.board.model.vo.BoardCategory"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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

<style>
/*  .cube {
  margin: 50px auto;
  width: 1000px;
  height: 600px;
  border-left: 15px solid #3EC8AC;
  border-right: 15px solid #4E90A4;
  border-radius: 5px;
  -webkit-box-sizing: border-box;
  -moz-box-sizing: border-box;
  box-sizing: border-box;
  background-position: 0 0, 0 100%;
  background-repeat: no-repeat;
  -webkit-background-size: 100% 20px;
  -moz-background-size: 100% 20px;
  background-size: 100% 20px;
  background-image: -webkit-linear-gradient(left, #3EC8AC 0%, #4E90A4 100%), -webkit-linear-gradient(left, #3EC8AC 0%, #4E90A4 100%);
  background-image: -moz-linear-gradient(left, #3EC8AC 0%, #4E90A4 100%), -moz-linear-gradient(left, #3EC8AC 0%, #4E90A4 100%);
  background-image: -o-linear-gradient(left, #3EC8AC 0%, #4E90A4 100%), -o-linear-gradient(left, #3EC8AC 0%, #4E90A4 100%);
  background-image: linear-gradient(to right, #3EC8AC 0%, #4E90A4 100%), linear-gradient(to right, #3EC8AC 0%, #4E90A4 100%);
}  */
/* body {
  display: -webkit-box;
  display: flex;
  -webkit-box-pack: center;
          justify-content: center;
  -webkit-box-align: center;
          align-items: center;
  height: 100vh;
} */

*, *::before, *::after {
  box-sizing: border-box;
}

@-webkit-keyframes rotate {
  100% {
    -webkit-transform: rotate(1turn);
            transform: rotate(1turn);
  }
}

@keyframes rotate {
  100% {
    -webkit-transform: rotate(1turn);
            transform: rotate(1turn);
  }
}
.rainbow {
  position: relative;
  z-index: 0;
  width: 1000px;
  height: 600px;
  border-radius: 10px;
  overflow: hidden;
  padding: 2rem;
}
.rainbow::before {
  content: '';
  position: absolute;
  z-index: -2;
  left: -50%;
  top: -50%;
  width: 200%;
  height: 200%;
  background-color: #399953;
  background-repeat: no-repeat;
  background-size: 50% 50%, 50% 50%;
  background-position: 0 0, 100% 0, 100% 100%, 0 100%;
  background-image: -webkit-gradient(linear, left top, left bottom, from(#399953), to(#399953)), -webkit-gradient(linear, left top, left bottom, from(#fbb300), to(#fbb300)), -webkit-gradient(linear, left top, left bottom, from(#d53e33), to(#d53e33)), -webkit-gradient(linear, left top, left bottom, from(#377af5), to(#377af5));
  background-image: linear-gradient(#399953, #399953), linear-gradient(#fbb300, #fbb300), linear-gradient(#d53e33, #d53e33), linear-gradient(#377af5, #377af5);
  -webkit-animation: rotate 4s linear infinite;
          animation: rotate 4s linear infinite;
}
.rainbow::after {
  content: '';
  position: absolute;
  z-index: -1;
  left: 6px;
  top: 6px;
  width: calc(100% - 12px);
  height: calc(100% - 12px);
  background: white;
  border-radius: 5px;
}

</style>

<script>

$(()=>{
	
	loadBoardList(1);
	
	function loadBoardList(cPage){
		if(<%=memberLoggedIn==null%>){
			var memberId = "";		
		} else {
			var memberId = "<%=memberLoggedIn.getMemberId()%>";	
		}
		var boardCategory = $("#boardCategory").val();
		var searchType = $("#searchType").val();
		var searchKeyword = $("#searchKeyword").val();
		console.log("boardCategory"+boardCategory);
		console.log("searchType"+searchType);
		console.log("searchKeyword"+searchKeyword);
		console.log("cPage"+cPage);
		$.ajax({
			url: "${pageContext.request.contextPath}/board/loadBoardList",
			type: "GET",
			data: {memberId:memberId,
				cPage:cPage,
				boardCategory:boardCategory,
				searchType:searchType,
				searchKeyword:searchKeyword},
			success: data=>{
				
				let header = "<tr><th>글번호</th><th colspan='2'>제목</th><th>글쓴이</th><th>작성일</th><th>조회</th></tr>";
		    	let $table = $("#tbl-board");
		    	$table.html("");
		    	//공지사항
				let	html = "";
		    	for(var i=0; i<data.noticeList.length;i++){
		    		html += "<tr>";
		    		html += "<td><span class='badge badge-pill badge-danger'>공지</span></td>";
		    		html += "<td colspan='2'><a href='${pageContext.request.contextPath}/board/boardView.do?boardNo="+data.noticeList[i].BOARD_NO+"'>"+data.noticeList[i].BOARD_TITLE+"</a></td>";
		    		html += "<td>"+data.noticeList[i].MEMBER_ID+"</td>";
		    		html += "<td>"+life(data.noticeList[i].WRITE_DATE)+"</td>";
		    		html += "<td>"+data.noticeList[i].READ_COUNT+"</td>";
		    		html += "</tr>";
		    	}
				//일반 게시글
		    	for(var i=0; i<data.list.length;i++){
		    		html += "<tr>";
		    		html += "<td>"+data.list[i].BOARD_NO+"</td>";
		    		html += "<td colspan='2'><a href='${pageContext.request.contextPath}/board/boardView.do?boardNo="+data.list[i].BOARD_NO+"'>"+data.list[i].BOARD_TITLE+"</a></td>";
		    		html += "<td>"+data.list[i].MEMBER_ID+"</td>";
		    		html += "<td>"+life(data.list[i].WRITE_DATE)+"</td>";
		    		html += "<td>"+data.list[i].READ_COUNT+"</td>";
		    		html += "</tr>";
		    	}
		    	$table.append(header+html);
				$("#pageBar").html(data.pageBar);

		    	},
		    	error : (x, s, e) => {
					console.log("ajax 요청 실패!",x,s,e);
		    	},
		    	complete: ()=>{
	                $("#pageBar a").click((e)=>{
	                	loadBoardList($(e.target).siblings("input").val());
	                });
	            }
		});//end of ajax
		
	}//end of loadBoardList
	
		//카테고리로 정렬
		$("#boardCategory").change(function(){
			$("#searchKeyword").val('');
			loadBoardList(1);
		});
		//검색어 입력
		$("#searchKeyword").keyup((e)=>{if(e.keyCode == 13) search();});
		$("#searchBoard").click(function search(){
			search();
		});
	function search(){
		var cPage = $("#cPage").val();
		var boardCategory = $("#boardCategory").val();
		var searchType = $("#searchType").val();
		var searchKeyword = $("#searchKeyword").val();
		if(searchKeyword.length==0){
			alert("검색어를 입력하세요");
			$("#searchKeyword").focus();
			return;
		} else {
			loadBoardList(1);
		}
	}//end of search
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
<!--  <h1>커뮤니티 게시판</h1> -->
 <script>
 
 
 </script>
 
 
 

 
<section id="board-container" class="container">
   <!-- <div class="cube">  -->
<div class="rainbow">
	<div class="row">
		<div class="col-md-12">
		<br /><br />
		<h4><img id="iconbox" src="${pageContext.request.contextPath}/resources/images/fire.png" width="20px" height="20px"/>우리동네 인기글</h4>
			<table id="po-board" class="table table-hover">
				<tr>
					<th>글번호</th>
					<th>제목</th>
					<th>글쓴이</th>
					<th>작성일</th>
					<th>조회</th>
					<th>추천</th>
				</tr>
				<c:if test="${not empty boardList}">
				<c:forEach items="${boardList}" var="list" varStatus="vs">
					<tr>
						<td id="popBoardNo" value="${list.BOARD_NO}">${list.BOARD_NO}</td>
						<td><a href='${pageContext.request.contextPath}/board/boardView.do?boardNo=${list.BOARD_NO}'>${list.BOARD_TITLE}</a></td>
						<td>${list.MEMBER_ID}</td>
						<td>${list.WRITE_DATE}</td>
						<td>${list.READ_COUNT}</td>
						<td>${list.CNT}</td>
					</tr>
				</c:forEach>
				</c:if>
				<c:if test="${empty boardList}">
					
						<td colspan="6" class="text-center">인기글이 없습니다.</td>
					
				</c:if>
			</table>
		</div>
		<div class="col-md-12">
			<br /><br /><br />
		</div>
	</div>
	</div>
		<br /><br /><br />
	<div class="col-md-12 ">
		<div class="col-md-8">
			<div class="input-group">
				<label for="boardCategory" class="sr-only">카테고리</label> <select
					class="custom-select" id="boardCategory" required>
					<%=option%>
				</select> <label for="searchKeyword" class="sr-only">검색</label> <select
					class="custom-select" id="searchType" required>
					<option value="member_id" selected>아이디</option>
					<option value="board_title">글제목</option>
				</select> <input style="margin-left: 20px;" type="text" size="40"
					id="searchKeyword" placeholder="검색어를 입력하세요">
				<div class="input-group-append">
					<button style="margin-left: 20px;" class="btn btn-primary sub-btn"
						id="searchBoard">검색하기</button>
				<input type="button" value="글쓰기" id="btn-add"
					class="btn btn-outline-success main-btn"
					onclick="fn_goWriteBoard();" />
				</div>
			</div>
		</div>
	</div>
	<br />

	<table id="tbl-board" class="table table-hover">
		
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