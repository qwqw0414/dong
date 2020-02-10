<%@page import="com.pro.dong.member.model.vo.Member"%>
<%@page import="com.pro.dong.board.model.vo.BoardReport"%>
<%@page import="java.util.List"%>
<%@page import="com.pro.dong.common.util.Utils"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<%
//페이지바 작업
int totalContents = (int)(request.getAttribute("totalContents"));
int cPage = (int)(request.getAttribute("cPage"));
int numPerPage = (int)(request.getAttribute("numPerPage"));
Member m = (Member)request.getAttribute("m");
String memberId = m.getMemberId();
String url = "memberView.do?memberId="+memberId+"&";

String pageBar = Utils.getMemberIdPageBar(totalContents, cPage, numPerPage, url);
pageContext.setAttribute("pageBar", pageBar);
%>

<script>
$(function(){
	$("#memberDelete-btn").click(function(){
		 var memberId = $("[name=memberDelId]").val();
		 console.log(memberId);
		 var confirmflag = confirm("회원을 정말로 삭제하시겠습니까?");
		
		 if(confirmflag){
			location.href="${pageContext.request.contextPath}/admin/memberDelete.do?memberId="+memberId;
		}
	});
});
</script>


<h1>회원상세보기</h1>
		
	<div class="table-responsive">
	
		<input type="hidden" value="${m.memberId}" name="memberDelId" />
		<table class="table col-md-5 text-center">
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
		<div>
			<button type="button" class="btn btn-danger" id="memberDelete-btn">회원삭제</button>
		</div>
		<br /><br /><br /><br />
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
					<td>${list.REPORT_TYPE}</td>
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

	<div>
	${pageBar}
	</div>














<jsp:include page="/WEB-INF/views/common/footer.jsp"/>