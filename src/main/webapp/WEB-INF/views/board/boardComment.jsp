<%@page import="java.util.Map"%>
<%@page import="com.pro.dong.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />



<div id="commentView">
<div class="input-group mb-3">
  <input type="text" class="form-control" id="comments_board" placeholder="댓글을 입력해 주세요">
  <div class="input-group-append">
    <button class="btn btn-outline-secondary" type="button" id="comments_insert">등록</button>
  </div>
</div>
<div id="commentView"></div>
</div>




<script>
$(()=>{
	$("#commentView #comments_insert").on('click',function(){
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
			},
			 error : (x,s,e) =>{
			        console.log("실패",x,s,e);
			      }
		
		});//end of ajax
	});

	
	
	
	
});//end of script

</script>




<jsp:include page="/WEB-INF/views/common/footer.jsp" />