<%@page import="java.util.Map"%>
<%@page import="com.pro.dong.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<%
	Member memberLoggedIn = (Member)request.getSession().getAttribute("memberLoggedIn");
%>
<input type="hidden" name="memberLoggedIn" value="<%= memberLoggedIn.getMemberId()%>"/>
<div id="commentInsertView">
<div class="input-group mb-3">
  <input type="text" class="form-control" id="comments_board" placeholder="댓글을 입력해 주세요">
  <div class="input-group-append">
    <button class="btn btn-outline-secondary" type="button" id="comments_insert">등록</button>
  </div>
</div>
<div id="commentListView"></div>
</div>
<div id="pageBar"></div>
	<script>
	$(()=>{
		showCommentList(1);
		//댓글등록
		$("#commentInsertView #comments_insert").on('click',function(){
			var boardNo= 285;    //보드넘버 바꾸면서 테스트 하면댐
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
	var boardNo=285;
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
				html+="<p style='margin-bottom:0px'><strong>"+data.list[i].MEMBER_ID+ "</strong>  <small>["+data.list[i].WRITE_DAY+"]</small><br> " + data.list[i].CONTENTS+"</p>";
				html+="<button id='showLevel2form' onclick='showLevel2form(this)'><img  src='https://assets.bunjang.co.kr/bunny_desktop/images/reply@2x.png' width='17' height='17'>답글</button>";
					//내가쓴 level1댓글에만 삭제버튼 생성	
					if($("[name=memberLoggedIn]").val()==data.list[i].MEMBER_ID){
					html+="<button id='deleteLevel1' onclick='deleteLevel1(this)'><img src='https://assets.bunjang.co.kr/bunny_desktop/images/trash-sm@2x.png' width='15' height='17'>삭제</button>";
					}

				}
				
				else{
					html+="<input type='hidden' value="+data.list[i].COMMENT_NO+" id='commentNo_'/>";
					html+="<div><img class='replyIcon' style='width:50px; height:50px;' src='${pageContext.request.contextPath}/resources/images/reply.PNG'/><span style='margin-bottom:0px; padding-left:30px'><strong>"+data.list[i].MEMBER_ID+ "</strong> : " + data.list[i].CONTENTS + " <small>[ " +data.list[i].WRITE_DAY + "]</small></span></div>";	
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
	var boardNo= 285;
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
		var boardNo= 285;
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
						showCommentList(1);
				},//end of success,
				 error : (x,s,e) =>{
				        console.log("실패",x,s,e);
				}
		})//end of ajax
	}//end of function
	//대댓글 등록창 보이기
	function showLevel2form(e){	
		$(e).next().next().css("display","block");
	}
	//대댓글 등록창 숨기기
	function hideLevel2form(e){
		$(e).parent().css("display","none");
	}
</script>
	<style>
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
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />