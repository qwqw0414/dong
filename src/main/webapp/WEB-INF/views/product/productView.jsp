<%@page import="com.pro.dong.product.model.vo.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<h1>상품 상세보기</h1>
<hr>
<style>
#productView #photo img{position: absolute;}
</style>
<div class="card mb-3 border-light" id="productView">
    <div class="row">
		<div class="col-4" id="photo">
		<c:forEach items="${map.attachment}" var="attch">
  		  <img src="${pageContext.request.contextPath}/resources/upload/product/${attch.photo}" alt="">
		</c:forEach>
		</div>
		<div class="col-8">
			<div>
                <div class="product-info">
                    <h3>${map.product.title }</h3>
                    <br>
                    <p>좋아요/조회수:${map.product.incount }/등록일:${map.product.regDate }</p>
                    <span>가격:${map.product.price }원</span>
                    <hr>
                    <dl>
                    <dt>상세정보</dt>
                    <br>
                    <dd>${map.product.info }</dd>
				    <dd>상품 상태:${map.product.status }</dd>
				    <dd>교환 여부:${map.product.isTrade }</dd>
				    <dd>배송여부:${map.product.shipping }</dd>
				    <dd>거래지역:${map.product.sido } ${map.product.sigungu } ${map.product.dong }</dd>
                
                </dl>
                    <hr>
                    <br />
                    <span>판매자 정보:${map.product.shopNo }</span> <hr><br>
                </div>
                    
                <div class="something-btn">
                    <c:if test="${map.likeCnt eq '0'}">
                        <button class="btn btn-outline-warning" id="btn-like">찜하기</button>
                    </c:if>                        
                    <c:if test="${map.likeCnt ne '0'}">
                        <button class="btn btn-warning" id="btn-like">찜취소</button>
                    </c:if>                        
                    <button class="btn btn-danger">연락하기</button>
                    <button class="btn btn-info" id="purchaseByPoint" data-toggle="modal" data-target="#purchaseModal">구매하기</button>
                </div>
			</div>
        </div>
    </div>
</div>
<div id="purchaseModal-wrapper">
	<div class="modal-body" id="purchasePage">
		<jsp:include page="/WEB-INF/views/product/pointPurchase.jsp"/>
	</div>
</div>

<script>
$(()=>{
// 예찬 시작 =======================================
    var $btnLike = $("#productView #btn-like");

    $btnLike.click(()=>{

        $.ajax({
            url: "${pageContext.request.contextPath}/product/productLike",
            data: {
                memberId: '${memberLoggedIn.memberId}',
                productNo: '${map.product.productNo}'
            },
            type: "POST",
            dataType: "json",
            success: data =>{
                if(data.result != 0){
                    if(data.type == 'I'){
                        $btnLike.removeClass("btn-outline-warning");
                        $btnLike.addClass("btn-warning");
                        $btnLike.text("찜취소");
                    }
                    else{
                        $btnLike.removeClass("btn-warning");
                        $btnLike.addClass("btn-outline-warning");
                        $btnLike.text("찜하기");
                    }


                }else{
                    alert("실패");
                }
            },
            error: (a,b,c) =>{
                console.log(a,b,c);
            }
        });
    });

// ======================================= 예찬 끝
// 민호 시작 =======================================

// ======================================= 민호 끝


})

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>