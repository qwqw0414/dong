<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div class="modal fade" id="productReviewModal" tabindex="-1" role="dialog" aria-labelledby="productReviewModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="productReviewModalLabel">리뷰 작성</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
				<div class="col-md-6 mb-6">
					<label for="reviewGradeList">나의 평가는?</label>
					<select class="custom-select" id="reviewGradeList" required>
						
					</select>
				</div>
				<div class="col-md-9 mb-9">
					<label for="reviewContent">상세내용 작성하기</label>
					<textarea cols="40" rows="5" class="form-control" id="reviewContent" maxlength="2000" required></textarea>
				</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary sub-btn" data-dismiss="modal">닫기</button>
        <button type="button" class="btn btn-primary main-btn" id="submitReview">평가하기</button>
      </div>
    </div>
  </div>
</div>
<input type="hidden" id="shopName" />
<input type="hidden" id="productNo" />
<script>
$(()=>{
	loadReviewGrade();
	
	function loadReviewGrade(){
		$.ajax({
			url: "${pageContext.request.contextPath}/shop/loadReviewGrade",
			type: "GET",
			success: data=>{
				console.log(data);
				let html = "";
				for(var i=0; i<data.reviewGradeList.length;i++){
					html += "<option value='"+data.reviewGradeList[i].GRADE_ID+"'>"+data.reviewGradeList[i].REVIEW_TYPE+"</option>";
				}
				$("#reviewGradeList").html(html);
			},
			error : (x, s, e) => {
				console.log("ajax 요청 실패!",x,s,e);
	    	}
		});//end of ajax
	}//end of loadReviewGrade
	
	//상점명 가져오기
	$(document).on("click", "#reviewBtn", function(e){
		console.log(e.target);
		var btnReview = $(e.target);
		var shopName = btnReview.parent().parent("td").siblings("[name=shopName]").text();
		var productNo = btnReview.parent().parent("td").siblings("input").val();
		
		console.log(shopName);
		console.log(productNo);
		
		$("#shopName").val(shopName);
		$("#productNo").val(productNo);
		console.log($("#shopName").val());
		console.log($("#productNo").val());
		$("#reviewContent").val('');
	});
	
	//평가하기 버튼 눌렀을 시
	$("#submitReview").on('click',function(){
		var shopName = $("#shopName").val();
		console.log(shopName);
		var reviewGrade = $("#reviewGradeList").val();
		var reviewContent = $("#reviewContent").val();
		var productNo = $("#productNo").val();
		console.log(reviewGrade);
		console.log(reviewContent);
		console.log(productNo);
		if(confirm("정말 리뷰를 작성하시겠습니까?")){
			$.ajax({
				url: "${pageContext.request.contextPath}/shop/insertReview",
				data:{shopName:shopName,
					reviewGrade:reviewGrade,
					reviewContent:reviewContent,
					productNo:productNo},
				type:"POST",
				success: data=>{
					console.log(data);
					if(data.result==1){
						alert("리뷰 작성 성공");
						location = "${pageContext.request.contextPath}/member/orderListView.do";
					} else {
						alert("리뷰 작성 실패");
					}
				},
				error : (x, s, e) => {
					console.log("ajax 요청 실패!",x,s,e);
		    	}
			});//end of ajax 
			
		}
	});//end of 평가하기
	
	
});//end of onload

</script>
