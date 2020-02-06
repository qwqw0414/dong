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

#fileUpdate{
	width: 90px;
	height: 40px;
	margin-top: 10px;
    float: right;
    margin-right: 10px;
}
#fileDelete{
	width: 90px;
	height: 40px;
	margin-top: 10px;
    float: right;
}
</style>

<body>

   <!--nav-->

  <div class="container-fluid">
    <div class="section row">
      <div id="filebox" class="img-holder col-lg-4 col-md-4 col-12" style="border: 2px solid #28a745; margin:0 auto;">
        <div style="background-image: url('../img/naim_ver_080801.png');height:100%;background-size:contain;" class="image"></div>
 
        <%-- <button type="button"  id="filebtn"
				class="btn btn-outline-success btn-block"
				onclick="fileDownload('','');">
			첨부파일${vs.count}  ${a.originalFileName }
		</button> --%> 
        
      </div>
      <div class="text-holder col-lg-6 col-md-7 col-12">

        <table class="product">
          <caption style="caption-side: top;"><button type="button"  id="fileDelete" class="btn btn-outline-success btn-block">삭제</button>
            <p><button type="button"  id="fileUpdate" class="btn btn-outline-success btn-block">수정</button><b>${board.boardTitle }</b></p>
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
            </tr>
           
            <!--display : none-->
            <tr>
              <th scope="row">내용</th>
              <td><textarea class="form-control" name="boardContent" placeholder="내용" required>${board.boardContents }</textarea></td>
            </tr>
            
          </tbody>
       
        </table>
        <!--table-->
      </div>
	</div>
	<br>
	<br>
</div>

  
</body>

	<%-- <input type="text" class="form-control" placeholder="제목" name="boardTitle" id="boardTitle" value="${board.boardTitle }" required>
	<input type="text" class="form-control" name="boardWriter" value="${memberLoggedIn.memberId}" readonly required>
	 <c:forEach items="" var="a" varStatus="vs">
		<button type="button" 
				class="btn btn-outline-success btn-block"
				onclick="fileDownload('','');">
			첨부파일${vs.count}  ${a.originalFileName }
		</button>
	</c:forEach> 
	<input type="text" class="form-control" name="categoryId" value="${board.categoryId}" readonly required>
	<input type="text" class="form-control" name="writeDate" value="${board.writeDate}" readonly required>
	<input type="text" class="form-control" name="writeDate" value="${board.readCount}" readonly required>

	
     <textarea class="form-control" name="boardContent" placeholder="내용" required>${board.boardContents }</textarea>
 --%>



<jsp:include page="/WEB-INF/views/common/footer.jsp"/>