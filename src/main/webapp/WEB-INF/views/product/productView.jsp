<%@page import="com.pro.dong.product.model.vo.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<h1>상품 상세보기</h1>
<hr>

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
                    <h3>${map.product.title } <button id="btn-like">♥+<span id="like-num"></span></button> </h3>
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
                        <button class="btn btn-outline-warning">찜하기</button>
                        <button class="btn btn-outline-danger">연락하기</button>
                        <button class="btn btn-info">구매하기</button>
                    </div>
			</div>
        </div>
    </div>
</div>


<script>
$(()=>{
// 예찬 시작 =======================================

// ======================================= 예찬 끝
// 민호 시작 =======================================

// ======================================= 민호 끝


})

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>