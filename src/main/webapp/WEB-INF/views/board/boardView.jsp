<%@page import="com.pro.dong.common.util.Utils"%>
<%@page import="com.pro.dong.member.model.vo.Member"%>
<%@page import="com.pro.dong.board.model.vo.Board"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<style>
div#board-container{width:400px; margin:0 auto; text-align:center;}
div#board-container input,div#board-container button{margin-bottom:15px;}
/* 부트스트랩 : 파일라벨명 정렬*/
div#board-container label.custom-file-label{text-align:left;}

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
$(function(){
	$("#boardUpdate").click(function(){
		location.href = "${pageContext.request.contextPath}/board/boardUpdate.do?boardNo="+${board.boardNo};
	});
});

</script>

<body>

   <!--nav-->

  <div class="container-fluid">
    <div class="section row">
      <div id="filebox" class="img-holder col-lg-4 col-md-4 col-12" style="border: 2px solid #28a745; margin:0 auto;">
      </div>
      <div class="text-holder col-lg-6 col-md-7 col-12">

        <table class="product">
          <caption style="caption-side: top;"> 
          <!-- 작성자와 로그인한 아이디가 같을시에만 삭제,수정가능 -->
          <c:if test="${board.memberId == memberLoggedIn.memberId || memberLoggedIn.isAdmin eq 'Y'}">
          <!-- 게시물 삭제는 작성자와 관리자만 가능(관리자 추가 예정) -->
          <button type="button"  id="boardDelete" class="btn btn-outline-success btn-block" >삭제</button>
          </c:if>
          <c:if test="${board.memberId == memberLoggedIn.memberId || memberLoggedIn.isAdmin eq 'Y'}">
            <button type="button"  id="boardUpdate" class="btn btn-outline-success btn-block" >수정</button>
          </c:if>
            <b>${board.boardTitle}</b>
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
               <td>
               <input type="text" class="form-control" name="writeDate" value="${board.categoryId}" readonly required>
			   <%-- <select class="form-control" name="select" id="categoryId" style="width: 150px; display: inline-block;" required="required">
               <option value="">카테고리 선택</option>
               <option value="A01"><c:if test="${board.categoryId eq 'A01'?'selected':''}">자유</c:if></option>
               <option value="A02"><c:if test="${board.categoryId eq 'A02'?'selected':''}">홍보</c:if></option>
               <option value="A03"><c:if test="${board.categoryId eq 'A03'?'selected':''}">정보</c:if></option> 
               </select>   --%>             
            </td>
            </tr>
            <tr>
              <th scope="col">작성일</th>
              <td><input type="text" class="form-control" name="writeDate" value="${board.writeDate}" readonly required></td>
			<input type="hidden" class="form-control" name="boardNo" id="boardNo" value="${board.boardNo}" readonly required>
            </tr>
            <!--display : none-->
            <tr>
              <th scope="row">내용</th>
              <td><textarea class="form-control" name="boardContent" placeholder="내용" readonly required>${board.boardContents }</textarea></td>
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
		
	/* 삭제 에이작스 */
		$("#boardDelete").click(function (){
			var result = confirm("게시글을 삭제하시겠습니까?");
			
			if(result>0){
			
			$.ajax({
				url: "${pageContext.request.contextPath}/board/boardDelete.do",
				data: {
					boardNo: $boardNo.val()
				},
				dataType:"json",
				type:"POST",
				success: data => {
					console.log(data);
					if(data > 0){
						console.log("성공");
						/* 경로설정 */
/* 						location.href="${pageContext.request.contextPath}/board/boardList.do" */
 					}else{
						console.log("불가불가불가");
					}
				},error: (x,s,e) => {
					alert("삭제가 완료되었습니다.");
					location.href="${pageContext.request.contextPath}/board/boardList.do";
				}
			});
			}else{
				return;
			}
			 
		});
		

	}); 
 
 
</script>

<%--==================현규시작================ --%>
<hr />



<%--==================현규끝================ --%>




  
</body>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>