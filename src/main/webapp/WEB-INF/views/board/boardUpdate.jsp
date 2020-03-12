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
Board b = (Board)request.getAttribute("board"); 
List<BoardCategory> list = new ArrayList<>();
list = (List<BoardCategory>)request.getAttribute("boardCategoryList");
Member memberLoggedIn = (Member)request.getSession().getAttribute("memberLoggedIn");

System.out.println("listt="+list);

String option = "";
option += "<option value=''/>전체</option>";
for(BoardCategory bc: list){
	if("Y".equals(memberLoggedIn.getIsAdmin())){
		option += "<option value=\""+bc.getCategoryId()+"\">"+bc.getCategoryName()+"</option>";
	}
	else{
		if(bc.getCategoryId().equals("A03")){
			continue;
		}
		else{
		option += "<option value=\""+bc.getCategoryId()+"\">"+bc.getCategoryName()+"</option>";
			
		}
	} 
}  
%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<style>
div#board-container{width:400px; margin:0 auto; text-align:center;}
div#board-container input,div#board-container button{margin-bottom:15px;}
/* 부트스트랩 : 파일라벨명 정렬*/
div#board-container label.custom-file-label{text-align:left;}

.head_inflow{
    padding-top: 50px;
    padding-bottom: 34px;
    border-color: #000;

    display: inline-block;
    position: relative;
    width: 100%;
    padding-top: 38px;
    padding-bottom: 29px;
    border-bottom: 1px solid #333333;
    vertical-align: top;
}
#title{
    font-size: 30px;
}
/* .profileWriter{
    color: #999;
} */

#writedate{
	float: right;
}
.cont_inflow{
    margin-top: 3px;
    font-size: 15px;
    line-height: 25px;
    width: 670px;
    margin-top: 35px;
    padding-right: 35px;
    border-right: 1px solid #f0f0f0;
}
#inputtitle{
	width: 400px;
}
.contents{
    border-bottom: 1px solid #f0f0f0; 
}
.contentsBox{
    overflow: hidden;
    margin-top: 17px;
    margin-bottom: -6px;
    line-height: 22px;
    word-break: break-all;
    border-color: #000;
    display: flex;
    position: relative;
    width: 100%;
    padding-bottom: 50px;
    vertical-align: top;

}
.img{
    display: block;
    position: relative;
    width: 100%;
    height: 100%;
    margin-top: 8px;
    margin-top: 13px;
}
.line{
    position: absolute;
    top: 0;
    right: 0;
    bottom: 0;
    left: 0;
    border: 1px solid #dcdcdc;
}
.btnBox{
    position: relative;
    width: 100%;
    padding-top: 20px;
    padding-bottom: 20px; 
    border-color: #000;
    border-bottom: 1px solid #f0f0f0;
}
.commentBox{
    overflow: hidden;
    margin-top: 17px;
    margin-bottom: -6px;
    line-height: 22px;
    word-break: break-all;
    border-color: #000;
    display: flex;
    position: relative;
    width: 100%;
    padding-bottom: 50px;
    border-bottom: 1px solid #f0f0f0;
    vertical-align: top;
}
.sideOther{
    position: absolute;
    right: 0;
    width: 263px;
    padding: 35px 0 0 35px;
    background-color: #fff;
}
#boardUpdateBtn{
	width: 90px;
	height: 40px;
	margin-top: 10px;
    float: right;
}

#iconbox {
	width: 15px;
	height: 15px;
}
#changeSpan{
	color: #28A745;
}
#boardContent{
	height:500px;
	width:600px;
}
</style>

<div class="section">
	<%-- <form action="${pageContext.request.contextPath}/board/boardUpdateEnd.do"
		  method="post"
		  enctype="multipart/form-data"
		  onsubmit="return validate();"> --%>
    <!-- head -->
    <div class="head_inflow">
    <span id="changeSpan">제목 수정</span>
        <div id="title"><strong><input type="text" class="form-control" id="inputtitle" value="${board.boardTitle}" required></strong></div>
        	<div class="profileWriter">
			<span id="span"><img id="iconbox"
				src="${pageContext.request.contextPath}/resources/images/writer.png" />&nbsp;${board.memberId}</span>
			&nbsp; <span id="span"><img id="iconbox"
				src="${pageContext.request.contextPath}/resources/images/text.png" />&nbsp;${board.readCount}</span>
			<br /> <span id="span"><img id="iconbox"
				src="${pageContext.request.contextPath}/resources/images/clock.png" />&nbsp;${board.writeDate}</span>
		</div>
		  
        <button type="button"  id="boardUpdateBtn" class="btn btn-outline-success btn-block" >확인</button>
    </div>

    <!-- content -->
    <div class="cont_inflow">

        <div class="contents">
       	
       	<%--<span id="changeSpan">카테고리 수정</span>
  			  <div class="input-group mb-3">
				 <div class="input-group-prepend">
				    <label class="input-group-text" for="inputGroupSelect01">카테고리</label>
				 </div>
				 <select class="custom-select" id="boardCategory" name="boardCategory" required>
				   <%=option%> 
				 </select>
				</div> --%>
			<%-- <div id="category">카테고리</div>
			<select class="custom-select" id="boardCategory" name="boardCategory"><!-- </select> -->
            <select class="form-control" name="select" id="categoryId" style="width: 150px; display: inline-block;" required="required">
               <option value="${board.categoryId}">카테고리 선택</option>
               <option value="A01"><c:if test="${board.categoryId eq 'A01'?'selected':''}"></c:if>자유</option>
               <option value="A02"><c:if test="${board.categoryId eq 'A02'?'selected':''}"></c:if>홍보</option>
               <option value="A04"><c:if test="${board.categoryId eq 'A04'?'selected':''}"></c:if>정보</option> 
            </select>  --%>
            
            <!-- 내용 -->
            <span id="changeSpan">내용 수정</span>
            <div class="contentsBox">
                <textarea class="form-control" name="boardContent" id="boardContent" placeholder="내용" required>${board.boardContents }</textarea>
            </div>
            <!-- 이미지 -->
            <span id="changeSpan">첨부파일 수정</span>
            <c:if test="${attachment.attachmentNo != null}"> 
    	<%--  <form action="${pageContext.request.contextPath}/board/updateFile.do"
		  method="post"
		  enctype="multipart/form-data"
		  onsubmit="return validate();">  --%>
    
			<div class="img" id="boardViewImg" style="margin:auto; width: 600px; height: 500px; overflow: hidden">
				<img style="width: 600px; height: 500px;" src="${pageContext.request.contextPath}/resources/upload/board/${attachment.renamedFileName}"/>
				<input type="hidden" name="renamedFileName" id="fileName" value="${attachment.renamedFileName}">
				<input type="hidden" name="oldFileName" value="">
				<input type="hidden" name="orininalFileName" value="${attachment.originalFileName}">
				<input type="hidden" id="boardNo" value="${board.boardNo}" >
				<span class="line" id="span">
				</span>
			</div>
			<div class="checks"> <input type="checkbox" id="ex_chk"> <label for="ex_chk">기존파일 삭제하기</label> </div>
			<!-- </form> -->
		 </c:if>
			<div class="custom-file">
				    <input type="file" class="custom-file-input" name="upFile" id="upFile" >
				    <label class="custom-file-label" for="upFile">수정할 파일을 선택하세요</label>
			</div>
        </div>

        <!-- 댓글 -->
        <div class="commentBox"> 
<hr />
            
        </div>
<br /><br />
<!-- <span id="changeSpan">댓글란 입니다.</span> -->
    </div>

    <!-- sideother -->
    <div class="sideOther"></div>
</div>

<script>
$(()=>{
	
	var $boardNo = $(".contents #boardNo");
	var $boardTitle = $("#title #inputtitle");
	var $categoryId = $("#category #categoryId");
	var $boardContents = $(".contentsBox #boardContent");
	var $renamedFileName = $("#boardViewImg #fileName");
	
		
	/* 수정 에이작스 */
		$("#boardUpdateBtn").click(function (){
			var result = confirm("게시글을 수정하시겠습니까?");
			
			if(result>0){
			
			$.ajax({
				url: "${pageContext.request.contextPath}/board/boardUpdateEnd.do",
				data: {
					boardNo: $boardNo.val(),
					boardTitle: $boardTitle.val(),
					//categoryId: $categoryId.val(),
					boardContents: $boardContents.val()
				},
				dataType:"json",
				type:"POST", 
				success: data => {
					console.log(data);
					if(data > 0){
						console.log("성공");
						alert("게시글 수정을 완료하였습니다.");
						/* 경로설정 */
						location.href="${pageContext.request.contextPath}/board/boardView.do?boardNo="+${board.boardNo};
						
 					}else{
						console.log("불가불가불가");
						alert("게시글 수정에 실패하였습니다.");
						location.href="${pageContext.request.contextPath}/board/boardList.do";
					}
				},error: (x,s,e) => {
				}
			});
			}else{
				return;
			}
			 
		});
	
	
	
	$(".checks #ex_chk").click((e)=>{
		deleteFile(e.target);
	});
	
	
	function deleteFile(input){
		var $fileName = $("#fileName");
		//var fileName = $(this).prop('files')[0].name;
		//var $fileName = $(input).siblings("[type=hidden]");
		$.ajax({
			url: "${pageContext.request.contextPath}/board/deleteFile",
			type: "post",
			data: {fileName:$fileName.val()},
			dataType: "json",
			success: data =>{
				$fileName.val('');
			},
			error: (a,b,c)=>{
				console.log(a,b,c);
			}
		})
	}
	
	/* 	$(".custom-file #upFile").change((e)=>{
	var fileName = $(this).prop('files')[0].name;
	
	$(this).next(".custom-file-label").html(fileName);
	updateFile();.
	});  */

	$(function(){
	//파일명 노출하기
	$("#upFile").on("change", function(){
		var fileName = $(this).prop('files')[0].name;
		
		$(this).next(".custom-file-label").html(fileName);
		//updateFile();
		
		/* $(this).next(".custom-file-label")
			   .html(fileName); */
		});
	}); 


	function updateFile(input) {
		var $fileName = $("#fileName");

		$.ajax({
			url: "${pageContext.request.contextPath}/board/updateFile",
			type: "post",
			data:{fileName:$fileName.val()},
			dataType:"json",
			success: data => {
				$fileName.val('');
			},
			error: (x, s, e) => {
				console.log("실패", x, s, e);
			}
		});
	}
	  
	 

	}); 
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>