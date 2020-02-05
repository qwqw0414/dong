<%@page import="com.pro.dong.common.util.Utils"%>
<%@page import="com.pro.dong.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	Member memberLoggedIn = (Member)request.getSession().getAttribute("memberLoggedIn");
%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<style>
div#board-container{width:400px; margin:0 auto; text-align:center;}
div#board-container input,div#board-container button{margin-bottom:15px;}
/* 부트스트랩 : 파일라벨명 정렬*/
div#board-container label.custom-file-label{text-align:left;}
</style>

<!-- board_no
member_id
category_id
board_title
board_contents
write_date
read_count -->

<div id="board-container">
	<input type="text" class="form-control" placeholder="제목" name="boardTitle" id="boardTitle" 
		   value="${board.boardTitle }" required>
	<input type="text" class="form-control" name="boardWriter" value="${memberLoggedIn.memberId}" readonly required>
	<input type="text" class="form-control" name="categoryId" value="${board.categoryId}" readonly required>
	<input type="text" class="form-control" name="writeDate" value="${board.writeDate}" readonly required>

	 <c:forEach items="" var="a" varStatus="vs">
		<button type="button" 
				class="btn btn-outline-success btn-block"
				onclick="fileDownload('','');">
			첨부파일${vs.count}  ${a.originalFileName }
		</button>
	</c:forEach> 
	
     <textarea class="form-control" name="boardContent" placeholder="내용" required>${board.boardContents }</textarea>

</div>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>