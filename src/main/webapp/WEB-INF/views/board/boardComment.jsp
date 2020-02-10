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
			console.log(data.length);
			let html="";
			html+="<div id='listdiv'>";
		for(var i=0; i<data.length;i++){
				html+="<div class='testas'>";
				html+="<input type='hidden' value="+data[i].COMMENT_NO+" id='commentNo_'/>";
				html+="<p style='margin-bottom:0px'>"+data[i].MEMBER_ID+ " : " + data[i].CONTENTS + " [ " +data[i].WRITE_DATE + "]</p>";
				html+="<button id='showLevel2form' onclick='showLevel2form(this)'>답글</button>";
				html+="<button id='deleteLevel1' onclick='deleteLevel1(this)'>삭제</button>";
				html+="<div id='level2Form'>";
				html+="<input type='text' id='level2CommentContent' placeholder='대댓글을 입력하세요.'></input>";
				html+="<button>등록</button><button onclick='hideLevel2form(this)'>취소</button><br>";
				html+="</div>";
				html+="</div>";
				
			};//end of forEach
			html+="</div>";
			$("#commentListView").html(html)
			
		},//end of success
		 error : (x,s,e) =>{
		        console.log("실패",x,s,e);
		      }
		});//end of ajax
	}
	
	//댓글리스트 불러오기
$(()=>{
	showCommentList();
	
	
	
	
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
			showCommentList();
		},
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