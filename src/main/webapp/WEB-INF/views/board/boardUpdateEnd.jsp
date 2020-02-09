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
function boardUpdateEndBtn(){
	location.href = "${pageContext.request.contextPath}/board/boardUpdateEnd.do";
}

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
          <button type="button"  id="boardDelete" class="btn btn-outline-success btn-block" onclick="boardUpdateEndBtn();">확인</button>
            <p>
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
             <%-- <td><input type="text" class="form-control" name="categoryId" value="${board.categoryId}" readonly required></td> --%>
              <td><select class="form-control" name="select"
               style="width: 150px; display: inline-block;" required="required">
               <option value="">카테고리 선택</option>
               <option value="A01 "<%="A01".equals(b.getCategoryId())?"selected":""%>>자유</option>
               <option value="A02" <%="A02".equals(b.getCategoryId())?"selected":""%>>홍보</option>
               <option value="A03" <%="A03".equals(b.getCategoryId())?"selected":""%>>정보</option>
               
            </select>
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

<%--==================현규시작================ --%>
<hr />



<%--==================현규끝================ --%>




  
</body>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>