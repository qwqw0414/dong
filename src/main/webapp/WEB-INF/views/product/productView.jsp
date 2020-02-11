<%@page import="com.pro.dong.product.model.vo.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<h1>상품 상세보기</h1>
<hr>
<div id="productView">
<div id="photo">
<c:forEach items="${map.attachment}" var="attch">
    <img src="${pageContext.request.contextPath}/resources/upload/product/${attch.photo}" alt="">
</c:forEach>
</div>
${map }

</div>
${map.product.title}
<div class="card mb-3 border-light" style="max-width: 100%;">
    
    
    <div class="row">
		<div class="col-4">
		<c:forEach items="${map.attachment}" var="attch">
  		  <img src="${pageContext.request.contextPath}/resources/upload/product/${attch.photo}" alt="">
		</c:forEach>
		</div>
		<div class="col-8">
			<div>
                <div class="goods-info">
                    <h3>${map.product.title }</h3><br>
                    <p class='goods-price-comment'>좋아요/조회수:${map.product.incount }/등록일:${map.product.regDate }</p>
                    <span class='price-info before-price'>가격</span>
                    <hr class="divide-sm">
                    <dl>
                    <dt>상세정보</dt>
                    <br>
                    <dd>${map.product.info }</dd>
				    <dd>상품 상태:${map.product.status }</dd>
				    <dd>교환 여부:${map.product.isTrade }</dd>
				    <dd>배송여부:${map.product.shipping }</dd>
				    <dd>거래지역:${map.product.sido } ${map.product.sigungu } ${map.product.dong }</dd>
                
                </dl>
                    <hr class="divide-sm">
                    <br />
                    <span>판매자 정보:${map.product.shopNo }</span> <hr class="divide-sm"><br>
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
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>