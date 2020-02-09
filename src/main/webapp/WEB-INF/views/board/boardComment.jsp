<%@page import="java.util.Map"%>
<%@page import="com.pro.dong.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />



<div id="commentInsertView">
<div class="input-group mb-3">
  <input type="text" class="form-control" id="comments_board" placeholder="댓글을 입력해 주세요">
  <div class="input-group-append">
    <button class="btn btn-outline-secondary" type="button" id="comments_insert">등록</button>
  </div>
</div>
<div id="commentListView"></div>
</div>



<script>

$(()=>{
	showCommentList();
	
	function showCommentList(){
	//댓글 조회
	var boardNo=285;
	
	$.ajax({
		url: "${pageContext.request.contextPath}/board/selectBoardComment",
		data:{boardNo:boardNo},
		type:"GET",
		dataType:"json",
		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		success:data=>{
			console.log(data);
			let html="";
// 				html+="<div id="+"commentListlevel2"+">";
			data.forEach(comment => {
				console.log(comment);
				html+="<ul class='testas'>";
				html+="<input type='hidden' value="+comment.COMMENT_NO+" id='commentNo_'/>";
				html+="<li><span>"+comment.MEMBER_ID+ " : " + comment.CONTENTS + " [ " +comment.WRITE_DATE + "]</span>";
				html+="<button id="+"showLevel2form"+" onclick='showLevel2form()'>답글</button>";
				html+="<button id="+"deleteComment"+">삭제</button></li></ul>";
				html+="<input type='text' class="+"level2CommentContent"+"></input>";
			});//end of forEach
// 				html+="</div>";
			$("#commentListView").html(html)
			
		},//end of success
		 error : (x,s,e) =>{
		        console.log("실패",x,s,e);
		      }
		});//end of ajax
	}
	
	//댓글리스트 불러오기
	
	
	
	//댓글등록
	$("#commentInsertView #comments_insert").on('click',function(){
		var boardNo= 285;    //보드넘버 바꾸면서 테스트 하면댐
		var contents = $("#comments_board").val();
		console.log(contents);
		
		$.ajax({
			url: "${pageContext.request.contextPath}/board/insertComments",
			data:{contents:contents, 
				  boardNo:boardNo},
			
			type:"POST",
			success:data=>{
				console.log(data);
					showCommentList();
			},
			 error : (x,s,e) =>{
			        console.log("실패",x,s,e);
			      }
		
		});//end of ajax
		
	});//end of function
	
});//end of script

	//대댓글등록
	function showLevel2form(){
		$(".testas").next().css("display","block");
	}
	
	

</script>


<style>
#commentListView .level2CommentContent{
display:none;
}
</style>




<jsp:include page="/WEB-INF/views/common/footer.jsp" />