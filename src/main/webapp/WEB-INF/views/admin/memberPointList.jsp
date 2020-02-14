<%@page import="com.pro.dong.common.util.Utils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<script>
function loadMemberPointList(){
	
	$.ajax({
		url: "${pageContext.request.contextPath}/admin/memberPointListEnd",
		type: "GET",
		data: {},
		success: data => {
			let header = "<tr><th>아이디</th><th>충전금액</th><th>충전날짜</th><th>잔여포인트</th><th>상태(입/출)</th></tr>";
			let $table = $("#member-pointList-tbl");
			$table.html("");
			let html = "";
			for(var i=o; i<data.list.length; i++){
				html += "<tr>";
				html += "<td></td>";
				html += "</tr>";
			}
			
		},error(x,s,e) => {
			console.log("memberPointList@ajax",x,s,e);
		}
	});
}
</script>

<h1>회원포인트 관리</h1>

	<div class="col-md-6 ">
	    <div class="input-group">
		  <label for="searchKeyword" class="sr-only">검색</label>
		  <select class="custom-select" id="searchType" required>
	     	<option value="member_id">아이디</option>
	     	<option value="member_name">충전날짜</option>
	      </select>
		  <input style="margin-left: 20px;" type="text" size="30" id="searchKeyword" placeholder="검색어를 입력하세요">
		  <div class="input-group-append">
	      <button style="margin-left: 20px;" class="btn btn-primary btn-sm" id="searchMember">검색하기</button> 
	      <button style="margin-left: 30px;" class="btn btn-primary btn-sm" id="memberAll">전체보기</button>
          </div>
	    </div>
    </div>

<div class="table-responsive">
<br /><br />
	<table class="table text-center" id="member-pointList-tbl">
		
	</table>
</div>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>