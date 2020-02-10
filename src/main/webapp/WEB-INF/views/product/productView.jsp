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


</div>
${map.product.title}

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>