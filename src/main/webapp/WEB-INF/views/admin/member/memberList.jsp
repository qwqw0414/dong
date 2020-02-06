<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>


<h1>회원관리</h1>

<div class="table-responsive">
<br /><br />
	<table class="table text-center">
		<tr>
			<th>아이디</th>
			<th>이름</th>
			<th>성별</th>
			<th>생년월일</th>
			<th>연락처</th>
			<th>주소</th>
			<th>이메일</th>
			<th>가입일</th>
		</tr>
		<c:forEach items="${list}" var="list" varStatus="vs">
			<tr>
				<td>${list.MEMBER_ID}</td>
				<td>${list.MEMBER_NAME}</td>
				<td>${list.GENDER == 'F'?"여":"남"}</td>
				<td>${list.BIRTH}</td>
				<td>${list.PHONE}</td>
				<td>${list.SIDO} ${list.SIGUNGU} ${list.DONG}</td>
				<td>${list.EMAIL}</td>
				<td><fmt:formatDate value="${list.ENROLL_DATE}" type="date" pattern="yyyy/MM/dd"/></td>
			</tr>
		</c:forEach>
	</table>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>