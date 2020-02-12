<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name="pageTitle"></jsp:param>
</jsp:include>

<script>
$(()=>{

	/* $("#search").on("click", function(){
		loadBoardList(1);
	}); */
	
	function loadBoardList(cPage, type){
		var sido = $("#sido").val();
		var sigungu = $("#sigungu").val();
		var dong = $("#dong").val();
		var searchType = $("#searchType").val();
		var searchKeyword = $("#searchKeyword").val();
		var type = type;
		console.log(searchType);
		console.log(searchKeyword);
		console.log(cPage);
		console.log(sido);
		console.log(sigungu);
		console.log(dong);
		console.log(type);
		$.ajax({
			url: "${pageContext.request.contextPath}/admin/loadBoardList",
			type: "GET",
			data:{cPage:cPage,
				searchType:searchType,
				searchKeyword:searchKeyword,
				sido:sido,
				sigungu:sigungu,
				dong:dong,
				type:type
				},
			success: data=>{
				console.log(data);
			},
			error : (x, s, e) => {
				console.log("ajax 요청 실패!",x,s,e);
	    	}
		});//end of ajax
	}//end of loadBoardList();
	
	function loadReportList(cPage, type){
		var sido = $("#sido").val();
		var sigungu = $("#sigungu").val();
		var dong = $("#dong").val();
		var searchType = $("#searchType").val();
		var searchKeyword = $("#searchKeyword").val();
		var type = type;
		console.log(searchType);
		console.log(searchKeyword);
		console.log(cPage);
		console.log(sido);
		console.log(sigungu);
		console.log(dong);
		console.log(type);
		$.ajax({
			url: "${pageContext.request.contextPath}/admin/loadReportList",
			type: "GET",
			data:{cPage:cPage,
				searchType:searchType,
				searchKeyword:searchKeyword,
				sido:sido,
				sigungu:sigungu,
				dong:dong,
				type:type
				},
			success: data=>{
				console.log(data);
			},
			error : (x, s, e) => {
				console.log("ajax 요청 실패!",x,s,e);
	    	}
		});//end of ajax
	}//end of loadReportList();
	
	$.ajax({
		url: "${pageContext.request.contextPath}/admin/loadSidoList",
		dataType: "json",
		type: "GET",
		success: data=>{
			console.log(data);
			let html = "<option value=''>전체</option>";
			$.each(data, function(index, data){
				html += "<option value='"+data+"'>"+data+"</option>";				
			});//end of forEach
			$("#sido").html(html);
		},
		error: (x,s,e)=>{
			console.log("실패",x,s,e);
		}
		
	});//end of ajax

	$("#sido").on("change", function(){
		var sido = $("#sido").val();
		console.log(sido);
		loadSigunguList(sido);
	});

	function loadSigunguList(sido){
		var sido = sido;
	$.ajax({
		url: "${pageContext.request.contextPath}/admin/loadSigunguList",
		data:{sido:sido},
		dataType: "json",
		type: "GET",
		success: data=>{
			console.log(data);
			let html = "<option value=''>전체</option>";
			$.each(data, function(index, data){
				html += "<option value='"+data+"'>"+data+"</option>";				
			});//end of forEach
			$("#sigungu").html(html);
		},
		error: (x,s,e)=>{
			console.log("실패",x,s,e);
		}
	});//end of ajax
	}//end of loadSigunguList

	$("#sigungu").on("change", function(){
		var sigungu = $("#sigungu").val();
		console.log(sigungu);
		loadDongList(sigungu);
	});

	function loadDongList(sigungu){
	var sigungu = sigungu;
	$.ajax({
		url: "${pageContext.request.contextPath}/admin/loadDongList",
		data:{sigungu:sigungu},
		dataType: "json",
		type: "GET",
		success: data=>{
			console.log(data);
			let html = "<option value=''>전체</option>";
			$.each(data, function(index, data){
				html += "<option value='"+data+"'>"+data+"</option>";				
			});//end of forEach
			$("#dong").html(html);
		},
		error: (x,s,e)=>{
			console.log("실패",x,s,e);
		}
	});//end of ajax
}//end of loadDongList

/* 스위치 버튼 함수 */
$("#customSwitch1").change(function(){
	console.log($(this));
	var checked = $(this).prop("checked");
	if(checked == false){
		$(this).next().html("일반글보기");
		loadBoardList(1, '일반');
	}	
	else{
		$(this).next().html("신고글보기");
		loadReportList(1, '신고');
	}
});

}); //end of onload
</script>

<h1 style='display: inline-block;'>게시글 관리</h1>
<div style='display: inline;' class="custom-control custom-switch">
  <input type="checkbox" class="custom-control-input" id="customSwitch1">
  <label class="custom-control-label" for="customSwitch1">신고글보기</label>
</div>
<div class="wrapper">
  <div class="input-group">	
  <select  aria-label="First name" class="form-control" id="sido" >
  </select>
  <select  aria-label="First name" class="form-control" id="sigungu" >
  </select>
  <select  aria-label="First name" class="form-control" id="dong" >
  </select>
  </div>
</div>

<div class="input-group mb-3">
  <div class="input-group-prepend">
    <select class="btn btn-outline-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" id="searchType">
      <option class="dropdown-item" value="title" >제목</option>
      <option class="dropdown-item" value="boardWiter" >작성자</option>
    </select>
  </div>
  <input type="text" class="form-control" aria-label="Text input with dropdown button" placeholder="검색어를 입력해 주세요" id="searchKeyword">
  <button class="btn btn-outline-secondary" id="search">검색</button>
</div>


<!-- 페이징바 Div -->
<div id="pageBar"></div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>