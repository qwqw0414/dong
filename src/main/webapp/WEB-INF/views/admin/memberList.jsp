<%@page import="com.pro.dong.common.util.Utils"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<%
//페이지바 작업
int totalContents = (int)(request.getAttribute("totalContents"));
int cPage = (int)(request.getAttribute("cPage"));
int numPerPage = (int)(request.getAttribute("numPerPage"));
String url = "memberList.do";

String pageBar = Utils.getPageBar(totalContents, cPage, numPerPage, url);
pageContext.setAttribute("pageBar", pageBar);
%>
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
				<td><a href="${pageContext.request.contextPath}/admin/memberView.do?memberId=${list.MEMBER_ID}">${list.MEMBER_ID}</a></td>
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
${pageBar}
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>