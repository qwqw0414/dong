<%@page import="java.util.ArrayList"%>
<%@page import="com.pro.dong.board.model.vo.BoardReportCategory"%>
<%@page import="java.util.List"%>
<%@page import="com.pro.dong.common.util.Utils"%>
<%@page import="com.pro.dong.member.model.vo.Member"%>
<%@page import="com.pro.dong.board.model.vo.Board"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

div{
    margin: 10px;
    padding: 0;
}
input{
	border: 0px;
}
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
span{
	color: #999;
}
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
    padding-top: 50px;
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
    padding-top: 50px;
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
#likeBtn{
	
}
</style>

<script>
$(function(){
	$("#boardUpdate").click(function(){
		location.href = "${pageContext.request.contextPath}/board/boardUpdate.do?boardNo="+${board.boardNo};
	});
});

$(function(){
	$("#likeBtn").click(function(){
		if(${memberLoggedIn.memberId == board.memberId}){
			alert("작성자는 좋아요를 누를 수 없습니다.");
		}else{
			location.href="${pageContext.request.contextPath}/board/boardLike.do?boardNo="+${board.boardNo};
		}
	});
});

</script>

<div class="section">
    <!-- head -->
    <div class="head_inflow">
        <div id="title"><strong>${board.boardTitle}</strong></div>
        <div class="profileWriter">
            <span>${board.memberId}</span> &nbsp;
            <span>조회수 : ${board.readCount}</span> <br />
            <span>${board.writeDate}일 작성</span>
        </div>
		  
		  <!-- 작성자와 로그인한 아이디가 같을시에만 삭제,수정가능 -->
          <c:if test="${board.memberId == memberLoggedIn.memberId || memberLoggedIn.isAdmin eq 'Y'}">
          <!-- 게시물 삭제는 작성자와 관리자만 가능(관리자 추가 예정) -->
          <button type="button"  id="boardDelete" class="btn btn-outline-success btn-block" >삭제</button>
          </c:if>
          <c:if test="${board.memberId == memberLoggedIn.memberId || memberLoggedIn.isAdmin eq 'Y'}">
            <button type="button"  id="boardUpdate" class="btn btn-outline-success btn-block" >수정</button>
          </c:if>
    </div>

    <!-- content -->
    <div class="cont_inflow">

        <div class="contents">
       	<input type="hidden" id="boardNo" value="${board.boardNo}" >
        <%-- <span id="writedate">${board.writeDate}일 작성</span> --%>
            <!-- 내용 -->
            <div class="contentsBox">
                ${board.boardContents }
            </div>
    
            <!-- 이미지 -->
            <div class="img">
                <img src="" alt="">
                <span class="line"></span>
            </div>
        </div>

        <div class="btnBox">
            <button id="likeBtn">좋아요</button>
            <button >신고</button>
        </div>
       
        <!-- 댓글 -->
        <div class="commentBox"> 댓글
<%--==================현규시작================ --%>
<hr />



<%--==================현규끝================ --%>
            
        </div>

    </div>

    


    <!-- sideother -->
    <div class="sideOther"></div>
</div>

<script>
 $(()=>{
	 var $boardNo = $(".contents #boardNo");
		
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

<<<<<<< 

<%--==================현규시작================ --%>
<hr />



<%--==================현규끝================ --%>

<!--하진시작-->

<script>
$(function(){
	
	loadBoardReportCategory();
	
	function loadBoardReportCategory(){
		$.ajax({
			url:"${pageContext.request.contextPath}/board/loadBoardReportCategory",
			contentType: "application/json; charset=utf-8",
			type:"GET",
			dataType: "json",
			success: data=>{
				console.log("성공");
				
				let $boardReportCategory = $("#boardReportCategory");
				let html = "";
				
				data.list.forEach(category => {
					html += "<option value='"+category.CATEGORY_ID+"'>"+category.REPORT_TYPE+"</option>";
				});
				$boardReportCategory.html(html);
				
			},
			error:(x,s,e)=>{
				console.log("실패",x,s,e);
			}
		});
		
	}
	
	$("#report-btn").click(()=>{
		
		var reportComment = $("#boardReportContents").val();
		var categoryId = $("#boardReportCategory").val();
		var memberId = $("[name=memberLoggedIn]").val();
		var boardNo = $("[name=boardNo]").val();
		
		if(reportComment.length==0){
			alert("신고 내용을 입력하세요");
			$("#boardReportContents").focus();
			return;
		}
		
		$.ajax({
			url:"${pageContext.request.contextPath}/board/insertBoardReport",
			dataType: "json",
			type: "POST",
			data: {
				reportComment:reportComment,
				categoryId:categoryId,
				memberId:memberId,
				boardNo:boardNo
			},
			success: data=>{
				if(data == 1){
					alert("게시글 신고가 정상적으로 접수되었습니다.");
					location.href="${pageContext.request.contextPath}/board/boardView.do?boardNo="+boardNo;
				}
				else{
					alert("게시글 신고 실패");
				}
			},
			error:(x,s,e)=>{
				console.log("실패",x,s,e);
			}
		});
		
	});
	

});

</script>

<button type="button" class="btn btn-danger btn-sm" data-toggle="modal" data-target="#myModal">신고</button>
<input type="hidden" name="memberLoggedIn" value="<%=memberLoggedIn.getMemberId()%>" />

<!-- Modal -->
<div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
    
	      <!-- Modal content-->
	      <div class="modal-content">
	      
	      	<!--모달헤더 시작-->
	        <div class="modal-header">
	          <h5 class="modal-title">게시글 신고</h5>
	          <button type="button" class="close" data-dismiss="modal">×</button>
	        </div>
	      	<!--모달헤더 끝-->
	       
	       <!--모달바디시작-->
	       	<div class="modal-body">
         		<div class="container">
	         		<div  style="text-align: center;" class="form-group">
				    	<label style="display: inline-block;" class="input-group-text col-lg-3" for="inputGroupSelect01">신고 유형</label>
					 	<select class="custom-select col-lg-5" id="boardReportCategory" name="boardReportCategory">
					 	</select>
				 	</div>
					<div class=" col-lg-12"> 
	  					<textarea class="form-control" id="boardReportContents" name="boardReportContents" rows="10"></textarea>
	  				</div>
				</div>
	       		
	       		<!--모달푸터시작-->
	       		<div class="modal-footer">
	         			<button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">취소</button>
	         			<button type="submit" id="report-btn" class="btn btn-danger btn-sm" >신고</button>
	       		</div>
	       		<!--모달푸터끝-->
	       		
	       	</div>
	      	<!--모달바디끝-->
	      </div>
      
    </div>
</div>
<!--하진 끝-->


    


</body>



<jsp:include page="/WEB-INF/views/common/footer.jsp"/>