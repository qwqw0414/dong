<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<script>
$(()=>{
	loadProductList(1);
	
	$("#search").on("click", function(){
		loadProductList(1);
	});

	function loadProductList(cPage){
		var sido = $("#sido").val();
		var sigungu = $("#sigungu").val();
		var dong = $("#dong").val();
		var searchType = $("#searchType").val();
		var searchKeyword = $("#searchKeyword").val();
		console.log(searchType);
		console.log(searchKeyword);
		console.log(cPage);
		console.log(sido);
		console.log(sigungu);
		console.log(dong);
		$.ajax({
			url: "${pageContext.request.contextPath}/admin/loadProductList",
			type: "GET",
			data:{cPage:cPage,
				searchType:searchType,
				searchKeyword:searchKeyword,
				sido:sido,
				sigungu:sigungu,
				dong:dong
				},
			success: data=>{
				console.log(data);
				let html  = "";
			for(var i=0; i<data.list.length;i++){
				html  += "<div class='card'>";
				html += "<img src='${pageContext.request.contextPath}/resources/upload/product/" + data.list[i].PHOTO + "' class='card-img-top'>";
				html += '<div class="card-body">';
		        html += '<p class="card-title">' + data.list[i].TITLE + '</p>';
		        html += '<p class="card-text"><span>' + numberComma(data.list[i].PRICE) + '<small>원</small></span></p>';
		        html += '<div class="regDate">'+lastDate(data.list[i].REG_DATE)+'</div>';
		        html += '</div></div>'
		        
			}
				$(".product").html(html);
				
				$("#pageBar").html(data.pageBar)
			},
			error : (x, s, e) => {
				console.log("ajax 요청 실패!",x,s,e);
	    	},
	    	complete: ()=>{
	    		 $("#pageBar a").click((e)=>{
	                    loadProductList($(e.target).siblings("input").val());
	    	});
		}
		});//end of ajax
	}//end of loadProductList();
	
	$.ajax({
		url: "${pageContext.request.contextPath}/admin/loadSidoList",
		dataType: "json",
		type: "GET",
		success: data=>{
			console.log(data);
			let html = "";
			$.each(data, function(index, data){
				html += "<option value='"+data+"'>"+data+"</option>";				
			});//end of forEach
			$("#sido").append(html);
		},
		error: (x,s,e)=>{
			console.log("실패",x,s,e);
		}
		
	});//end of ajax
	
	$("#sido").on("change", function(){
		var sido = $("#sido").val();
		console.log(sido);
		loadSigunguList(sido);
		loadDongList('');
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
			let html = "";
			$.each(data, function(index, data){
				html += "<option value='"+data+"'>"+data+"</option>";				
			});//end of forEach
			$("#sigungu").append(html);
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
			let html = "";
			$.each(data, function(index, data){
				html += "<option value='"+data+"'>"+data+"</option>";				
			});//end of forEach
			$("#dong").append(html);
		},
		error: (x,s,e)=>{
			console.log("실패",x,s,e);
		}
	});//end of ajax
}//end of loadDongList

});//end of (()=>)

function numberComma(num) {
    return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
  }
  
function lastDate(date){
    var regDate = new Date(date);
    var now = new Date();

    var diffHour = Math.ceil((now.getTime() - regDate.getTime())/60000/60);

    if(diffHour > 23){
      return Math.floor(diffHour/24)+"일 전";
    }

    return diffHour+"시간 전";
}




</script>
<h1>상품 상세보기</h1>

<div class="wrapper">
  <div class="input-group">	
  <select  aria-label="First name" class="form-control" id="sido" >
  	<option value=''>전체</option>
  </select>
  <select  aria-label="First name" class="form-control" id="sigungu" >
  	<option value=''>전체</option>
  </select>
  <select  aria-label="First name" class="form-control" id="dong" >
  	<option value=''>전체</option>
  </select>
  </div>
</div>

<div class="input-group mb-3">
  <div class="input-group-prepend">
    <select class="btn btn-outline-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" id="searchType">
      <option class="dropdown-item" value="title" >상품명</option>
      <option class="dropdown-item" value="product_no" >상점번호</option>
    </select>
  </div>
  <input type="text" class="form-control" aria-label="Text input with dropdown button" placeholder="검색어를 입력해 주세요" id="searchKeyword">
  <button class="btn btn-outline-secondary" id="search">검색</button>
</div>
 <div class="productList" id="A09">
      <div class="product"></div>
      <hr>
    </div>

<div id="pageBar">

</div>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>