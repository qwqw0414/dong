<%@page import="com.pro.dong.common.util.Utils"%>
<%@page import="com.pro.dong.member.model.vo.Member"%>
<%@page import="com.pro.dong.board.model.vo.Board"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.pro.dong.board.model.vo.BoardCategory"%>
<%@page import="java.util.List"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
/* 	Board b = (Board)request.getAttribute("board");
List<BoardCategory> list = new ArrayList<>();
list = (List<BoardCategory>)request.getAttribute("boardCategoryList");
String option = "";
for(BoardCategory bc: list){
	option +=  "<option value=\""+bc.getCategoryId()+"\">"+bc.getCategoryName()+"</option>";
} */
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


#boardUpdateBtn{
	width: 90px;
	height: 40px;
	margin-top: 10px;
    float: right;
}
#titleinput{
	border: 1px;
}
</style>

 <script>
/* //수정버튼
function boardUpdateBtn(){
	var result = confirm("수정하시겠습니까?");
	
	if(result){
	location.href = "${pageContext.request.contextPath}/board/boardUpdateEnd.do?boardNo="+${board.boardNo};
	}
} */

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
            <button type="button"  id="boardUpdateBtn" class="btn btn-outline-success btn-block" >확인</button>
            <b><input id="titleinput" value="${board.boardTitle}"></b>
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
               <%-- <select class="custom-select" id="boardCategory" name="boardCategory">
				   ${board.categoryId}
			   </select> --%>
              <select class="form-control" name="select" id="categoryId" style="width: 150px; display: inline-block;" required="required">
               <option value="">카테고리 선택</option>
               <option value="A01"><c:if test="${board.categoryId eq 'A01'?'selected':''}"></c:if>자유</option>
               <option value="A02"><c:if test="${board.categoryId eq 'A02'?'selected':''}"></c:if>홍보</option>
               <option value="A03"><c:if test="${board.categoryId eq 'A03'?'selected':''}"></c:if>정보</option> 
            </select> 
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
              <td><textarea class="form-control" name="boardContent" id="boardContent" placeholder="내용" required>${board.boardContents }</textarea></td>
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
	var $boardTitle = $(".product #titleinput");
	var $categoryId = $(".product #categoryId");
	var $boardContents = $(".product #boardContent");
		
	/* 수정 에이작스 */
		$("#boardUpdateBtn").click(function (){
			var result = confirm("게시글을 수정하시겠습니까?");
			
			if(result>0){
			
			$.ajax({
				url: "${pageContext.request.contextPath}/board/boardUpdateEnd.do",
				data: {
					boardNo: $boardNo.val(),
					boardTitle: $boardTitle.val(),
					categoryId: $categoryId.val(),
					boardContents: $boardContents.val()
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