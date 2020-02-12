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
	color: #fff;
    background-color: cornflowerblue;
    padding: .25rem .5rem;
    font-size: .875rem;
    line-height: 1.4;
    border-radius: .3rem;
}

#iconbox{
    width: 15px;
    height: 15px;
}
</style>

<script>
$(function(){
	$("#boardUpdate").click(function(){
		location.href = "${pageContext.request.contextPath}/board/boardUpdate.do?boardNo="+${board.boardNo};
	});
});

/* $(function(){
	$("#likeBtn").click(function(){
		if(${memberLoggedIn.memberId == board.memberId}){
			alert("작성자는 좋아요를 누를 수 없습니다.");
		}else{
			location.href="${pageContext.request.contextPath}/board/boardLike.do?boardNo="+${board.boardNo};
		}
	});
});  */

</script>

<div class="boardView">
    <!-- head -->
    <div class="head_inflow">
        <div id="title"><strong>${board.boardTitle}</strong></div>
        <div class="profileWriter">
            <span><img id="iconbox" src="${pageContext.request.contextPath}/resources/images/writer.png"/>&nbsp;${board.memberId}</span> &nbsp;
            <span><img id="iconbox" src="${pageContext.request.contextPath}/resources/images/text.png"/>&nbsp;${board.readCount}</span> <br />
            <span><img id="iconbox" src="${pageContext.request.contextPath}/resources/images/clock.png"/>&nbsp;${board.writeDate}</span>
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
       	<input type="hidden" id="boardNo" name="boardNo" value="${board.boardNo}" >
        <%-- <span id="writedate">${board.writeDate}일 작성</span> --%>
            <!-- 내용 -->
            <div class="contentsBox">
                ${board.boardContents }
            </div>
    
            <!-- 이미지 -->
            <div class="img">
                <span class="line"><%-- <img src="${pageContext.request.contextPath}/resources/images/clock.png" /> --%></span>
            </div>
        </div>

        <div class="btnBox">
            <button type="button" id="likeBtn">추천</button>
            <button type="button" class="btn btn-danger btn-sm" data-toggle="modal" data-target="#myModal">신고</button>
        </div>
        </div>
        <!-- 댓글 -->
<!--         <div class="commentBox"> 댓글</div> -->
<%--==================현규시작================ --%>
<hr />
<input type="hidden" name="memberLoggedIn" value="<%= memberLoggedIn.getMemberId()%>"/>
<div id="commentInsertView">
<div class="input-group mb-3">
  <input type="text" class="form-control" id="comments_board" placeholder="댓글을 입력해 주세요">
  <div class="input-group-append">
    <button class="btn btn-outline-secondary" type="button" id="comments_insert">등록</button>
  </div>
</div>
		<br />
    	<h5>comments</h5>
    	<hr /><br />
<div id="commentListView"></div>
</div>
<div id="pageBar"></div>




<%--==================현규끝================ --%>
            


    


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
		
	
	/* 좋아요 버튼 */
		 $("#likeBtn").click(function(){
			if(${memberLoggedIn.memberId == board.memberId}){
				alert("작성자는 좋아요를 누를 수 없습니다.");
			}else{
				
				$.ajax({
					url: "${pageContext.request.contextPath}/board/boardLike.do",
					data: {
						boardNo: $boardNo.val()
					},
					dataType:"json",
					type:"GET",
					contentType: "application/json; charset=utf-8",
					success: data => {
						if(data>0){
						alert("좋아요 버튼을 눌렀습니다.");
						console.log(data+"좋아요 ajax성공");
						//location.href="${pageContext.request.contextPath}/board/boardLike.do?boardNo="+${board.boardNo};
							
						}else{
						alert("좋아요 버튼을 누를수 없습니다..");
							
						}
					},error:(x,s,e) => {
						console.log("좋아요 ajax실패");
						//location.href="${pageContext.request.contextPath}/board/boardList.do";
					}
				});
			}
			
		}); 

}); 
 
 
</script>



<%--==================현규시작================ --%>
<hr />
<script>
	$(()=>{
		showCommentList(1);
		//댓글등록
		$("#commentInsertView #comments_insert").on('click',function(){
			var boardNo = $(".contents #boardNo").val();    //보드넘버 바꾸면서 테스트 하면댐
			var contents = $("#comments_board").val();
			var memberId = $("[name=memberLoggedIn]").val();
			var commentLevel=1;
			$.ajax({
				url: "${pageContext.request.contextPath}/board/insertComments",
				data:{contents:contents,
					  boardNo:boardNo,
					  memberId:memberId,
					  commentLevel:commentLevel},
				type:"POST",
				success:data=>{
					console.log(data);
						if(data=="1"){
							alert("성공 니 댓글 맨뒤에~");
						}
						else{
							alert("실패")
						}
						showCommentList(1);
				},
				 error : (x,s,e) =>{
				        console.log("실패",x,s,e);
				      }
			});//end of ajax
		});//end of function
	});//end of onload
	
	
	
	
	
	
	function showCommentList(cPage){
	//댓글 조회
	var boardNo = $(".contents #boardNo").val();
	$.ajax({
		url: "${pageContext.request.contextPath}/board/selectBoardComment",
		data:{boardNo:boardNo,
		      cPage:cPage},
		type:"GET",
		dataType:"json",
		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		success:data=>{
			console.log(data);
			let html="";
			html+="<div id='listdiv'>";
		for(var i=0; i<data.list.length;i++){
				html+="<div class='testas'>";
				if(data.list[i].COMMENT_LEVEL=="1"){
				html+="<input type='hidden' value="+data.list[i].COMMENT_NO+" id='commentNo_'/>";
				html+="<span style='margin-bottom:0px'><strong>"+data.list[i].MEMBER_ID+ ":</strong> "+data.list[i].CONTENTS+" <small>[" + data.list[i].WRITE_DAY+"]</small></span>";
				html+="<button id='showLevel2form' class='alcls btn btn-outline-success btn-sm' onclick='showLevel2form(this)'><img  src='https://assets.bunjang.co.kr/bunny_desktop/images/reply@2x.png' width='17' height='17'>답글</button>";
					//내가쓴 level1댓글에만 삭제버튼 생성	
					if($("[name=memberLoggedIn]").val()==data.list[i].MEMBER_ID){
					html+="<button class='btn btn-outline-success btn-sm' id='deleteLevel1' onclick='deleteLevel1(this)'><img src='https://assets.bunjang.co.kr/bunny_desktop/images/trash-sm@2x.png' width='15' height='17'></button>";
					}
					//ㅋㅋㅋㅋㅋㅋㅋㅋㅋ
					else{
						html+="<button id='fakebutton'>채우기용</button>";	
					}
					

				}
				
				else{
					
					if($("[name=memberLoggedIn]").val()==data.list[i].MEMBER_ID){
						html+="<div>"
						html+="<input type='hidden' value="+data.list[i].COMMENT_NO+" id='commentNo_'/>"
						html+="<img class='replyIcon' style='width:50px; height:50px;' src='${pageContext.request.contextPath}/resources/images/reply.PNG'/>"
						html+="<span style='margin-bottom:0px; padding-left:30px'><strong>"+data.list[i].MEMBER_ID+ "</strong> : " + data.list[i].CONTENTS + " <small>[ " +data.list[i].WRITE_DAY + "]</small>";
						html+="<button class='alcls btn btn-outline-success btn-sm' onclick='deleteLevel2(this);'><img src='https://assets.bunjang.co.kr/bunny_desktop/images/trash-sm@2x.png' width='10' height='10'></button></span></div>";
					}else{
						html+="<div><img class='replyIcon' style='width:50px; height:50px;' src='${pageContext.request.contextPath}/resources/images/reply.PNG'/>"
						html+="<span style='margin-bottom:0px; padding-left:30px'><strong>"+data.list[i].MEMBER_ID+ "</strong> : " + data.list[i].CONTENTS + " <small>[ " +data.list[i].WRITE_DAY + "]</small></span></div>";
					}
				}
				html+="<div id='level2Form'>";
				html+="<input type='text' id='level2CommentContent' placeholder='대댓글을 입력하세요.'>";
				html+="<button onclick='insertLevel2(this)'>등록</button><button onclick='hideLevel2form(this)'>취소</button><br>";
				html+="</div>";
				html+="</div>";
				
			};//end of forEach
			html+="</div>";
			$("#commentListView").html(html);
            $("#pageBar").html(data.pageBar);
		},//end of success
		 error : (x,s,e) =>{
		        console.log("실패",x,s,e);
		      },
		      complete: ()=>{
	                $("#pageBar a").click((e)=>{
	                	showCommentList($(e.target).siblings("input").val());
	                });
	            }
		});//end of ajax
	}
	//댓글 삭제
	function deleteLevel1(e){
	var commentNo= $(e).prev().prev().prev().val();
	var boardNo = $(".contents #boardNo").val();
	console.log(commentNo);
	$.ajax({
		url:"${pageContext.request.contextPath}/board/deleteLevel1",
		data:{commentNo:commentNo,
			boardNo:boardNo},
		type:"POST",
		success:data=>{
			console.log(data);
			showCommentList(1);
		},
		 error : (x,s,e) =>{
		        console.log("실패",x,s,e);
		}
	});//end of ajax
	};//end of function
	
	
	//대댓글 등록
	function insertLevel2(e){
		var boardNo = $(".contents #boardNo").val();
		var level2Content = $(e).prev().val();
		var memberId = $("[name=memberLoggedIn]").val();
		var commentLevel=2;
		var commentRef=$(e).parent().parent().children("input").val();
		$.ajax({
			url:"${pageContext.request.contextPath}/board/insertLevel2",
			data:{commentLevel:commentLevel,
				boardNo:boardNo,
				contents:level2Content,
				memberId:memberId,
				commentRef:commentRef,
				},
				type:"POST",
				success:data=>{
						console.log(data);
						if(data=="1"){
								alert("성공");
						}
						else{
							alert("실패");
						}
						showCommentList(1);
				},//end of success,
				 error : (x,s,e) =>{
				        console.log("실패",x,s,e);
				}//end of error
		})//end of ajax
	}//end of function
	
	
	
	//대댓삭제
	function deleteLevel2(e){
		var commentNo=$(e).parent().parent().children("input").val();
		$.ajax({
			url:"${pageContext.request.contextPath}/board/deleteLevel2",
			data:{commentNo:commentNo},
			type:"POST",
			success:data=>{
				console.log(data);
				if(data=="1"){
					alert("성공");
			}
			else{
				alert("실패");
			}
				showCommentList(1);
		},//end of success,
		 error : (x,s,e) =>{
		        console.log("실패",x,s,e);
		}//end of error
			
		})//end of ajax
		
	
	}
	
	
	
	
	
	
	
	//대댓글 등록창 보이기
	function showLevel2form(e){
// 		$("#level2Form").css("display","block");
		$(e).next().next().css("display","block");
	}
	//대댓글 등록창 숨기기
	function hideLevel2form(e){
		$(e).parent().css("display","none");
	}
</script>
	<style>
.alcls{ 
 		margin-left:30px;
	} 
	
	#fakebutton{
		visibility:hidden;
	}
#commentListView #level2Form {
	display: none;
}
#level2Form #level2CommentContent {
	width:1000px;
}
#listdiv .testas{
margin-bottom:20px;
}
</style>


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
<!-- 
<button type="button" class="btn btn-danger btn-sm" data-toggle="modal" data-target="#myModal">신고</button> -->
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