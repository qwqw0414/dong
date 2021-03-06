<%@page import="com.pro.dong.common.util.Utils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<script>

function life(date){
	var preDate = new Date(date);

	var year = preDate.getFullYear();
	var month = preDate.getMonth()+1;
	var date = preDate.getDate();

	if(month < 10) month = "0"+month;
	if(date < 10) date = "0"+date;

	return year+"/"+month+"/"+date;
}

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
			loadMemberList(searchType, searchKeyword,cPage);
		}
		
	});
	
 	$('#memberAll').click(function() {
 		location.reload();
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
			let header = "<tr><th>아이디</th><th>이름</th><th>성별</th><th>생년월일</th><th>연락처</th><th>주소</th><th>이메일</th><th>가입일</th></tr>";
	    	let $table = $("#member-list-tbl");
	    	$table.html("");
	    	let	html = "";
	    	for(var i=0; i<data.list.length;i++){
	    		html += "<tr>";
	    		html += "<td><a href='${pageContext.request.contextPath}/admin/memberView.do?memberId="+data.list[i].MEMBER_ID+"'>"+data.list[i].MEMBER_ID+"</a></td>";
	    		html += "<td>"+data.list[i].MEMBER_NAME+"</td>";
	    		html += "<td>"+data.list[i].GENDER+"</td>";
	    		html += "<td>"+data.list[i].BIRTH+"</td>";
	    		html += "<td>"+data.list[i].PHONE+"</td>";
	    		html += "<td>"+data.list[i].SIDO+' &nbsp; '+data.list[i].SIGUNGU+' &nbsp; '+data.list[i].DONG+"</td>";
	    		html += "<td>"+data.list[i].EMAIL+"</td>";
	    		html += "<td>"+life(data.list[i].ENROLL_DATE)+"</td>";
	    		html += "</tr>";
	    	}
	    	$table.append(header+html);
			$("#pageBar").html(data.pageBar);
		},
		error : (x, s, e) => {
			console.log("ajax 요청 실패!",x,s,e);
    	}
		
		
	});
	
}
</script>

<h1>회원관리</h1>

	<div class="col-md-6">
	    <div class="input-group">
		  <select class="custom-select" id="searchType" required>
	     	<option value="member_id">아이디</option>
	     	<option value="member_name">이름</option>
	      </select>
		  <input style="margin-left: 20px;" type="text" size="30" id="searchKeyword" placeholder="검색어를 입력하세요">
		  <div class="input-group-append">
	      	<button style="margin-left: 20px;" class="btn btn-primary btn-sm" id="searchMember">검색하기</button> 
	      	<button style="margin-left: 30px;" class="btn btn-primary btn-sm" id="memberAll">전체보기</button>
          </div>
	    </div>
	    <br /><br />
    </div>

<div class="table-responsive">
<br /><br />
	<table class="table text-center" id="member-list-tbl">
	</table>
</div>
<div id="pageBar">
	
</div>
<input type="hidden" name="cPage" id="cPage"/>



<jsp:include page="/WEB-INF/views/common/footer.jsp"/>