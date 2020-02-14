<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name="pageTitle"></jsp:param>
</jsp:include>
<style>
#productReportDiv{
	width: 1100px;
}
#reportImageDiv{
	text-align: center;
}
#reportImage{
	width: 400px;
	height: 250px;
	margin-bottom: 10px;
}
#reportReply{
	resize: none;
}
#reportReplyBtn{
	width: 62px;
    height: 78px;
    position: absolute;
    margin-left: 10px;
    background-color: white;
	outline: none;
	border: 1px solid darkgray;
}
#reportContentDiv{
	height: 170px;
}
</style>

<h1 style='display: inline-block;'>상품 신고 상세보기</h1>
<div id="productReportDiv">
	<hr />
	<span>
		<strong>신고접수번호</strong> : ${map.REPORT_NO} 
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
		<strong>접수일자</strong> : ${map.REPORT_DATE}
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<strong>작성자</strong> : ${map.MEMBER_ID}
	</span>
	<hr />
	<div id="reportContentDiv">
		<strong>신고 내용 : </strong><br />
		<div style='width: 900px; margin-left: 30px;'>
			<p style='margin-left: 100px; margin-top: 30px;'>${map.REPORT_COMMENT}</p>
		</div>
	</div>
	<hr />
	<strong>첨부 파일 : </strong><br />
	<div id="reportImageDiv">
		<c:if test="${map.REPORT_IMAGE eq null}">
			<img id="reportImage" src="${pageContext.request.contextPath}/resources/images/noImage.png" />
		</c:if>
		<c:if test="${map.REPORT_IMAGE ne null }">
			<img id="reportImage" src="${pageContext.request.contextPath}/resources/upload/productReportImage/${map.REPORT_IMAGE}" />
		</c:if>
	</div>
	<hr />
	
	<textarea name="reportReply" id="reportReply" cols="140" rows="3"></textarea>
	<button id="reportReplyBtn">답변 등록</button>
	
	
	
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>