<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name="pageTitle"></jsp:param>
</jsp:include>

<div id="productReportTotalDiv">
<h1 style='display: inline-block;'>상품 신고 상세보기</h1><button id="goProductView">상품보기</button>
<div id="productReportDiv">
	<hr />
	<span>
		<strong>신고접수번호</strong> : ${map.REPORT_NO} 
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
		<strong>접수일자</strong> : <fmt:formatDate value="${map.REPORT_DATE}" pattern="yyyy-MM-dd"/>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<strong>작성자</strong> : ${map.MEMBER_ID}
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<c:if test="${map.STATUS eq 'N' }">
			<button id='statusBtn'>처리대기</button>
		</c:if>
		<c:if test="${map.STATUS eq 'Y' }">
			<button id='statusBtn' disabled>처리완료</button>
		</c:if>
	</span>
	<hr />
	<div id="reportContentDiv">
		<strong>신고 내용 : </strong><br />
		<div style='width: 900px; margin-left: 30px;'>
			<p style='margin-left: 100px; margin-top: 30px;'>${map.REPORT_CONTENTS}</p>
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
</div>
</div>
<script>
$("#goProductView").on("click", function(){
	
	var productNo = ${map.PRODUCT_NO};
	location.href = "${pageContext.request.contextPath}/product/productView.do?productNo="+productNo;
});

$("#statusBtn").click(updateReportStatus);
function updateReportStatus() {
	var reportNo = ${map.REPORT_NO};
	$.ajax({
		url: "${pageContext.request.contextPath}/admin/updateReportStatus",
		method: "POST",
		data : {reportNo : reportNo},
		success: data => {
			console.log(data);
			if(data == 1){
				$("#statusBtn").text("처리완료");
				$("#statusBtn").attr("disabled", true);
			}
		},
		error: (x, s, e) => {
			console.log("ajax 요청 실패!");
		}
	});
}

function life(date){
	var preDate = new Date(date);

	var year = preDate.getFullYear();
	var month = preDate.getMonth()+1;
	var date = preDate.getDate();

	if(month < 10) month = "0"+month;
	if(date < 10) date = "0"+date;

	return year+"/"+month+"/"+date;
}
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>