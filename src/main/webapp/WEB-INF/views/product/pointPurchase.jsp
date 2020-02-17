<%@page import="java.util.ArrayList"%>
<%@page import="com.pro.dong.product.model.vo.ProductAttachment"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="modal fade" id="purchaseModal"  role="dialog" aria-labelledby="purchaseModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="purchaseModalLabel">포인트로 결제하기</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
				<form>
				${map }
				<span class="smallTitle">구매자 정보</span>
				<hr class="divide-m" />
					<div class="form-row">
						<div class="form-group col-md-6">
							<label for="purchase-memberId">아이디</label> 
							<input type="text" class="form-control" id="purchase-memberId" value="${map.memberLoggedIn.memberId }" readonly>
						</div>
						<div class="form-group col-md-6">
							<label for="purchase-memberName">이름</label>
							<input type="text" class="form-control" id="purchase-memberName" value="${map.memberLoggedIn.memberName }" readonly>
						</div>
					</div>
					<span class="smallTitle">배송지 정보</span>
					<hr class="divide-m" />
					<div class="form-group">
						<label for="purchase-Sido">시</label>
						<input type="text" class="form-control" id="purchase-Sido"
							 value="${map.memberLoggedIn.sido}">
					</div>
					<div class="form-group">
						<label for="purchase-Sigungu">시군구</label> <input type="text"
							class="form-control" id="purchase-Sigungu"
							value="${map.memberLoggedIn.sigungu}">
					</div>
					<div class="form-group">
						<label for="purchase-dong">동</label> <input type="text"
							class="form-control" id="purchase-dong"
							value="${map.memberLoggedIn.dong}">
					</div>
					<div class="form-group">
						<label for="purchase-addr">추가 주소</label> <input type="text"
							class="form-control" id="purchase-addr">
					</div>
					<hr class="divide-m" />
					<div class="form-row">
						<div class="form-group col-md-6">
							<label for="purchase-phone">연락처</label>
							<input type="text" class="form-control" id="purchase-phone"
							value="${map.memberLoggedIn.phone }">
						</div>
					</div>
					<span class="smallTitle">구매 물품 정보</span>
					<input type="hidden" name="purchase-productNo" id="purchase-productNo" value="${map.product.productNo }" />
					<hr class="divide-m" />
					<div id="purchase-img" class="media">
						<c:forEach items="${map.attachment}" var="attch">
				  		  <img src="${pageContext.request.contextPath}/resources/upload/product/${attch.photo}" alt="">
						</c:forEach>
						<div class="media-body text-right" >
							<h5 class="mt-0" class="smallTitle text-right">${map.product.title}</h5>
							&nbsp;${map.product.price }원
						</div>
					</div>
					<br>
					<span class="smallTitle">결제 정보</span>
					<hr class="divide-m" />
					<div class="form-row">
						<div class="form-group col-md-6">
							<label for="purchase-memberPoint">사용 가능한 포인트</label> 
							<input type="text" class="form-control" id="purchase-memberPoint" value="${map.memberLoggedIn.point}" readonly>
						</div>
						<div class="form-group col-md-6" id="purchase-btn-group">
							<br>
							<button type="button" class="btn btn-warning sub-btn" id="useAllPoints">전액사용</button>
       						<button type="button" class="btn btn-secondary main-btn" id="chargePoints">충전하기</button>
						</div>
					</div>
					<div class="form-row">
						<div class="form-group col-md-6">
						상품금액:<br>
						사용 포인트:<br>
						최종결제금액:<br>
						</div>
						<div class="form-group col-md-6 text-right">
							<small id="productPrice">${map.product.price}</small>원<br>
							<small id="pointUsed"></small>원<br>
							<small id="totalFee"></small>원<br>
						</div>
					</div>
				</form>
			</div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary sub-btn" data-dismiss="modal">취소</button>
        <button type="button" class="btn btn-secondary" id="submitPay" disabled="disabled">결제하기</button>
      </div>
    </div>
  </div>
</div>
<script>
$(()=>{
	//modal 꺼질때 버튼 색 바꾸기
	$('#purchaseModal').on('hidden.bs.modal', function () {
		$("#submitPay").attr('class','btn btn-secondary');
	});
	
	$("#useAllPoints").on('click',function(){
		useAllPoints();
	});//전액사용 함수 끝
	
	$("#chargePoints").on('click',function(){
		location.href = '${pageContext.request.contextPath}/member/memberView.do';
	});
	$("#submitPay").on('click',function(){
		submitPurchase();
	});
function useAllPoints(){
	//전액사용
		var price = Number('${map.product.price }');
		var memberPoint = Number($("#purchase-memberPoint").val());
		if(price>memberPoint){
			alert("포인트가 부족합니다");
			return;
		} else {
			$("#pointUsed").text(price);
			var pointUsed = Number($("#pointUsed").text());
			$("#purchase-memberPoint").val(memberPoint-price);
			$("#totalFee").text(price-pointUsed);
			$("#submitPay").prop('disabled','');
			$("#submitPay").attr('class','btn btn-secondary main-btn');
		}
	
}
function submitPurchase(){
	/* var orderInfo = {
			memberId: $("#purchase-memberId").val(),
			memberName: $("#purchase-memberName").val(),
			sido: $("#purchase-Sido").val(),
			sigungu: $("#purchase-Sigungu").val(),
			dong: $("#purchase-dong").val(),
			addr: $("#purchase-addr").val(),
			phone: $("#purchase-phone").val(),
			productNo: $("#purchase-productNo").val(),
			price: '${map.product.price}',
			attachment: '${map.attachment}'
	}
	JSON.stringify(orderInfo);
	console.log(orderInfo); */
	$.ajax({
		url: "${pageContext.request.contextPath}/product/submitPurchase",
		data: {			
			memberId: $("#purchase-memberId").val(),
			memberName: $("#purchase-memberName").val(),
			sido: $("#purchase-Sido").val(),
			sigungu: $("#purchase-Sigungu").val(),
			dong: $("#purchase-dong").val(),
			address: $("#purchase-addr").val(),
			phone: $("#purchase-phone").val(),
			productNo: $("#purchase-productNo").val(),
			price: '${map.product.price}',
			attachment: '${map.attachment}'},
			
		success : data =>{
			if(data==1){
				alert("결제 성공");
			}else {
				alert("결제 실패");
			}
			
		},
		error : (x,s,e) =>{
            console.log("실패",x,s,e);
        },
        complete: ()=>{
        	location.href = '${pageContext.request.contextPath}/member/orderListView.do';
        }
		
	});//end of ajax
}//end of submitPurchase

});//온로드 함수 끝
</script>