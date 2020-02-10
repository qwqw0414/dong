<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<style>
#productList-category .cate-title{font-family: MapoPeacefull; font-size: 1.5em;}
.productList .card {width: 201px; border-radius: 0; height: 280px;}
.productList .card img{width: 200px; height: 200px; border: none;}
.productList .product .card{float: left; margin: 10px 8px 10px 8px}
.product {width: 1200px; display: block; margin: auto; height: 620px;}
.productList{width: 100%;}
.productList .card-body{padding: 10px 0 0px 8px;}
.productList .regDate{font-size: 0.9em; position: absolute; right: 10px; bottom: 10px;}
</style>
<script>
$(function(){
	loadProductList();
	
	//키워드 검색
	$("#search").on("click", function(){
		var searchType = $("#searchType").val();
		var searchKeyword = $("#searchKeyword").val();
		var productCategory = '';
		var cPage = $("#cPage").val();
		if(searchKeyword.trim().length==0){
			alert("검색어를 입력해 주세요.");
			$("#searchKeyword").focus();
			return;
		}
		console.log(searchType);
		console.log(searchKeyword);
		console.log(productCategory);
		console.log(cPage);
		loadProductList(searchType, searchKeyword, productCategory, cPage);
	});//키워드 검색 끝
	
});//온로드함수 끝
function numberComma(num) {
    return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
  }
  
function lastDate(date){
    var regDate = new Date(date);
    var now = new Date();

    var diffHour = Math.ceil((now.getTime() - regDate.getTime())/60000/60) - 9;

    if(diffHour > 23){
      return Math.floor(diffHour/24)+"일 전";
    }

    return diffHour+"시간 전";
}

function loadProductList(searchType, searchKeyword, productCategory, cPage){
	var cPage = cPage;
	var productCategory = productCategory;
	var searchKeyword = searchKeyword;
	var searchType = searchType;
	$("#cPage").val(cPage);
	console.log(searchType);
	console.log(searchKeyword);
	console.log(productCategory);
	console.log(cPage);
	$.ajax({
		url: "${pageContext.request.contextPath}/admin/loadProductList",
		type: "GET",
		data:{cPage:cPage,
			productCategory:productCategory,
			searchType:searchType,
			searchKeyword:searchKeyword},
		success: data=>{
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
    	}
	});//end of ajax
}
</script>
<h1>상품 상세보기</h1>
<input type="hidden" name="cPage" id="cPage"/>
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