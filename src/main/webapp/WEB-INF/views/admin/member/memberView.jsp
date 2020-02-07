<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<h1>회원상세보기</h1>

	<div class="table-responsive">
		<table class="table col-md-3">
			<tr>
				<th>아이디</th>
				<td>${m.memberId}</td>
			</tr>
            <tr>
            	<th>이름</th>
            	<td>${m.memberName}</td>
            </tr>  
            <tr>
            	<th>주소</th>
            	<td>${m.sido} ${m.sigungu} ${m.dong}</td>
            </tr>
            <tr>
            	<th>연락처</th>
            	<td>${m.phone}</td>
            </tr>
            
		</table>
		<br /><br />
	</div>

<h1>게시판 신고내역</h1>
	<div class="table-responsive">
	<br />
		<table class="table">
		<tr>
			<th>신고 카테고리</th>
			<th>신고된 게시판 번호</th>
			<th>신고자</th>
			<th>신고내용</th>
			<th>신고 접수 여부</th>
		</tr>
		<c:if test="${not empty list}">
			<c:forEach items="${list}" var="list">
				<tr>
					<td>${list.CATEGORY_ID}</td>
					<td>${list.BOARD_NO}</td>
					<td>${list.MEMBER_ID}</td>
					<td>${list.REPORT_COMMENT}</td>
					<td>${list.STATUS}</td>
				</tr>
			</c:forEach>
		</c:if>
		<c:if test="${empty list}">
			<td colspan="5" class="text-center">신고된 내역이 없습니다</td>
		</c:if>
		</table>
	</div>

















<jsp:include page="/WEB-INF/views/common/footer.jsp"/>