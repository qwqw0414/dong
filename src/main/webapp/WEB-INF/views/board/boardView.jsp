<%@page import="com.pro.dong.common.util.Utils"%>
<%@page import="com.pro.dong.member.model.vo.Member"%>
<%@page import="com.pro.dong.board.model.vo.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	Member memberLoggedIn = (Member)request.getSession().getAttribute("memberLoggedIn");
	Board b = (Board)request.getAttribute("board");
%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<style>
div#board-container{width:400px; margin:0 auto; text-align:center;}
div#board-container input,div#board-container button{margin-bottom:15px;}
/* 부트스트랩 : 파일라벨명 정렬*/
div#board-container label.custom-file-label{text-align:left;}

    border: 5px solid white;
}

p {
    font-size: 18px;
    margin:10px 0 0;
}

body,
td {
    font-size: 18px;
}
/*table 속성*/
table{text-align: left;}
.cost{height:50px;font-size:24px;}
caption {
    padding: 0;
    font-size: 36px;
    line-height: 44px;
    font-weight: 900;
    color: #000;
    margin-bottom: 100px;
}

th {
    width: 30%;
    font-size: 18px;
    line-height: 27px;
    font-weight: bold;
}

th,
td {
    padding-left: 10px;
}

.fill {
    background-color: rgba(51, 51, 51, 0.1);

}

tr {
    height: 40px;
}

td {
    width: 350px;
}

.head {
    border: 5px solid white;
}

body,
td {
    font-size: 18px;
}

#filebtn{
	width: 150px;
	height: 40px;
	margin-top: 10px;
    float: right;
}

#filebox{
	border-radius: 10px;
}

#boardUpdate{
	width: 90px;
	height: 40px;
	margin-top: 10px;
    float: right;
    margin-right: 10px;
}
#boardDelete{
	width: 90px;
	height: 40px;
	margin-top: 10px;
    float: right;
}
</style>

 <script>
//수정버튼
/* function boardUpdateBtn(){
	location.href = "${pageContext.request.contextPath}/board/boardUpdate.do";
} */

//삭제버튼
/* function boardDeleteBtn(){
	var result = confirm("게시글을 삭제하시겠습니까?");
	
	if(result=true){
		location.href = "${pageContext.request.contextPath}/board/boardDelete.do?boardNo="+${board.boardNo};
	}else{
		alert("삭제 불가합니다.");
	} */
/* 	var result = confirm("정말로 삭제하시겠습니까?");
	if(!result)
		return false;
	
	return location.href = "${pageContext.request.contextPath}/board/boardDelete.do?boardNo="+${board.boardNo};
} 
	
} */ 

/* function fileDownload(oName, rName){
	//한글파일명이 있을 수 있으므로, 명시적으로 encoding
	oName = encodeURIComponent(oName);
	location.href="${pageContext.request.contextPath}/board/fileDownload.do?oName="+oName+"&rName="+rName;
} */
</script> 

<body>

   <!--nav-->

  <div class="container-fluid">
    <div class="section row">
      <div id="filebox" class="img-holder col-lg-4 col-md-4 col-12" style="border: 2px solid #28a745; margin:0 auto;">
        <div style="background-image: url('../img/naim_ver_080801.png');height:100%;background-size:contain;" class="image"></div>      
      </div>
      <div class="text-holder col-lg-6 col-md-7 col-12">

        <table class="product">
          <caption style="caption-side: top;"> 
          <!-- 작성자와 로그인한 아이디가 같을시에만 삭제,수정가능 -->
          <% if(b.getMemberId().equals(memberLoggedIn.getMemberId())){ %>
          <!-- 게시물 삭제는 작성자와 관리자만 가능(관리자 추가 예정) -->
          <button type="button"  id="boardDelete" class="btn btn-outline-success btn-block" onclick="boardDeleteBtn();">삭제</button>
          <% } %>
            <p>
			<% if(b.getMemberId().equals(memberLoggedIn.getMemberId())){%>       
            <button type="button"  id="boardUpdate" class="btn btn-outline-success btn-block" onclick="boardUpdateBtn();">수정</button>
            <% } %>
            <b>${board.boardTitle }</b></p>
          </caption>
          <tbody>
            <tr>
              <th scope="col">작성자</th>
              <td><input type="text" class="form-control" name="boardWriter" value="${board.memberId}" readonly required></td>
            </tr>
            <tr>
              <th scope="col">조회수</th>
              <td><input type="text" class="form-control" name="writeDate" value="${board.readCount}" readonly required></td>
            </tr>
            <tr>
               <th scope="col">카테고리</th>
               <td><input type="text" class="form-control" name="categoryId" value="${board.categoryId}" readonly required></td> 
            </tr>
            <tr>
              <th scope="col">작성일</th>
              <td><input type="text" class="form-control" name="writeDate" value="${board.writeDate}" readonly required></td>
			<input type="hidden" class="form-control" name="boardNo" id="boardNo" value="${board.boardNo}" readonly required>
            </tr>
            <!--display : none-->
            <tr>
              <th scope="row">내용</th>
              <td><textarea class="form-control" name="boardContent" placeholder="내용" required>${board.boardContents }</textarea></td>
            </tr>
            <tr>
              <th scope="col">첨부파일</th>
<%--               <td><input type="text" class="form-control" name="upFile" id="upFile" value="${attachmentList.renamedFileName}" readonly></td>--%>
<%--  	<c:forEach items="${attachmentList}" var="a" varStatus="vs">
		<button type="button" 
				class="btn btn-outline-success btn-block"
				onclick="fileDownload('${a.originalFileName}','${a.renamedFileName }');">
			첨부파일${vs.count} - ${a.originalFileName }
		</button>
	</c:forEach>  --%>
            </tr>
			
       
        </table>
        <!--table-->
      </div>
	</div>
	<br>
	<br>
</div>
<script>
 $(()=>{
	var $boardNo = $(".product #boardNo");
	
	$("#boardUpdate").click(function (){
		 
		$.ajax({
			url: "${pageContext.reuqest.contextPath}/board/boardUpdate.do?boardNo="+${board.boardNo}",
			data: {
				boardNo: $boardNo.val()
			},
			dataType:"json",
			type:"GET", 
			success: data => {
				console.log(data);
				if(data > 0){
					console.log("성공");
					/* 경로설정 */
					location.href="${pageContext.request.contextPath}/board/boardList.do"
				}else{
					console.log("불가불가불가");
				}
			},error: (x,s,e) => {
				console.log("board수정 ajax요청 실패!",x,s,e);
			}
		});
	});
}); 
</script>

<%--==================현규시작================ --%>
<hr />



<%--==================현규끝================ --%>




  
</body>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>