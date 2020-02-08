<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<script>
$(function(){
	loadProductList();
	
});//온로드함수 끝
function loadProductList(searchType, searchKeyword, productCategory, cPage){
	var cPage = cPage;
	var productCategory = productCategory;
	var searchKeyword = searchKeyword;
	var searchType = searchType;
	$("#cPage").val(cPage);
	$.ajax({
		url: "${pageContext.request.contextPath}/admin/loadProductList",
		type: "GET",
		data:{cPage:cPage,
			productCategory:productCategory,
			searchType:searchType,
			searchKeyword:searchKeyword},
		success: data=>{
			console.log(data);
		},
		error : (x, s, e) => {
			console.log("ajax 요청 실패!",x,s,e);
    	}
	});//end of ajax
}
</script>
<h1>상품 상세보기</h1>
<input type="hidden" name="cPage" id="cPage"/>

 <div class="productList" id="A09">
      <span class="cate-title">A</span>
      <span class="cate-link">B</span>
      <div class="product"></div>
      <hr>
    </div>




<jsp:include page="/WEB-INF/views/common/footer.jsp"/>