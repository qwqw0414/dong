<%@page import="com.pro.dong.common.util.Utils"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<%-- <%
	//페이지바 작업
	int totalContents = (int)(request.getAttribute("totalContents"));
	int cPage = (int)(request.getAttribute("cPage"));
	int numPerPage = (int)(request.getAttribute("numPerPage"));
	String url = "memberList.do";

	String pageBar = Utils.getPageBar(totalContents, cPage, numPerPage, url);
	pageContext.setAttribute("pageBar", pageBar);
%> --%>

<script>
$(function(){
	loadMemberList();
	
	//검색어 입력
	$("#searchMember").click(function(){
		var cPage = $("#cPage").val();
		var searchType = $("#searchType").val();
		var searchKeyword = $("#searchKeyword").val();
		
		if(searchKeyword.length==0){
			alert("검색어를 입력하세요");
			$("#searchKeyword").focus();
			return;
		} else {
			loadBoardList(searchType, searchKeyword,cPage);
		}
		
	});
});

function loadMemberList(searchType, searchKeyword, cPage){
	
	var cPage = cPage;
	var searchType = searchType;
	var searchKeyword = searchKeyword;
	
	$("#cPage").val(cPage);
	
	$.ajax({
		url: "${pageContext.request.contextPath}/admin/memberList",
		type: "GET",
		data: {cPage:cPage,
			searchType:searchType,
			searchKeyword:searchKeyword},
		success: data=>{
			console.log("ddd");
			let header = "<tr><th>아이디</th><th>이름</th><th>성별</th><th>생년월일</th><th>연락처</th><th>주소</th><th>이메일</th><th>가입일</th></tr>";
	    	let $table = $("#member-list-tbl");
	    	$table.html("");
	    	for(var i=0; i<data.list.length;i++){
	    		html += "<tr>";
	    		html += "<td>"+data.list[i].MEMBER_ID+"</td>";
	    		html += "<td>"+data.list[i].MEMBER_NAME+"</td>";
	    		html += "<td>"+data.list[i].GENDER+"</td>";
	    		html += "<td>"+data.list[i].BIRTH+"</td>";
	    		html += "<td>"+data.list[i].PHONE+"</td>";
	    		html += "<td>"+data.list[i].SIDO+data.list[i].SIGUNGU+data.list[i].DONG"</td>";
	    		html += "<td>"+data.list[i].EMAIL+"</td>";
	    		html += "<td>"+data.list[i].ENROLL_DATE+"</td>";
	    		html += "</tr>";
	    	}
	    	$table.append(header+html);
	    	$("#totalContents").text("총 "+data.totalContents+"명의 회원");
			/* $("#pageBar").html(data.pageBar); */
	    	
	    	
		},
		error : (x, s, e) => {
			console.log("ajax 요청 실패!",x,s,e);
    	}
		
		
	});
	
}
</script>

<h1>회원관리</h1>

	<div class="col-md-3 mb-3">
	    <div class="input-group mb-3">
		  <label for="searchKeyword" class="sr-only">검색</label>
		  <select class="custom-select" id="searchType" required>
	     	<option value="member_id" selected>아이디</option>
	     	<option value="member_name">이름</option>
	      </select>
		  <input type="text" size="30" id="searchKeyword" placeholder="검색어를 입력하세요">
		  <div class="input-group-append">
	      <button class="btn btn-primary mb-2" id="searchMember">검색하기</button>
          </div>
	    </div>
    </div>

<div class="table-responsive">
<br /><br />
	<table class="table text-center" id="member-list-tbl">
		
	</table>
</div>
<%-- ${pageBar} --%>
<input type="hidden" name="cPage" id="cPage"/>



<jsp:include page="/WEB-INF/views/common/footer.jsp"/>