<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<style>
#main-page #productList-category .cate-title{font-family: MapoPeacefull; font-size: 1.5em;}
#main-page .card {width: 201px; border-radius: 0;}
#main-page .card img{width: 200px; height: 190px; border: none;}
#main-page .productList .product .card{float: left; margin: 10px 8px 10px 8px}
#main-page .product {width: 1200px; display: block; margin: auto; height: 680px;}
#main-page {width: 1300px;}
#main-page .productList{width: 100%;}
</style>


<div id="main-page">

  <div id="productList-category">

    <div class="productList" id="A01">
      <span class="cate-title">패션잡화</span>
      <span class="cate-link">바로가기</span>
      <div class="product"></div>
      <hr>
    </div>

    <div class="productList" id="A02">
      <span class="cate-title">여성의류</span>
      <span class="cate-link">바로가기</span>
      <div class="product"></div>
      <hr>
    </div>

    <div class="productList" id="A03">
      <span class="cate-title">남성의류</span>
      <span class="cate-link">바로가기</span>
      <div class="product"></div>
      <hr>
    </div>

    <div class="productList" id="A04">
      <span class="cate-title">디지털/가전</span>
      <span class="cate-link">바로가기</span>
      <div class="product"></div>
      <hr>
    </div>

    <div class="productList" id="A05">
      <span class="cate-title">도서/티켓/취미/애완</span>
      <span class="cate-link">바로가기</span>
      <div class="product"></div>
      <hr>
    </div>

    <div class="productList" id="A06">
      <span class="cate-title">유아동/출산</span>
      <span class="cate-link">바로가기</span>
      <div class="product"></div>
      <hr>
    </div>

    <div class="productList" id="A07">
      <span class="cate-title">스타굿즈</span>
      <span class="cate-link">바로가기</span>
      <div class="product"></div>
      <hr>
    </div>

    <div class="productList" id="A08">
      <span class="cate-title">생활/문구/가구/식품</span>
      <span class="cate-link">바로가기</span>
      <div class="product"></div>
      <hr>
    </div>

    <div class="productList" id="A09">
      <span class="cate-title">뷰티/미용</span>
      <span class="cate-link">바로가기</span>
      <div class="product"></div>
      <hr>
    </div>

    <div class="productList" id="A10">
      <span class="cate-title">스포츠/레저</span>
      <span class="cate-link">바로가기</span>
      <div class="product"></div>
      <hr>
    </div>

    <div class="productList" id="A11">
      <span class="cate-title">차량/오토바이</span>
      <span class="cate-link">바로가기</span>
      <div class="product"></div>
      <hr>
    </div>

    <div class="productList" id="A12">
      <span class="cate-title">기타</span>
      <span class="cate-link">바로가기</span>
      <div class="product"></div>
      <hr>
    </div>

  </div>

</div>

<script>
$(()=>{

  var $mainPage = $("#main-page");
  var categoryId;
  var cateArr = {};

  console.log($mainPage.find(".productList").length);

  for(var i = 0; i < $mainPage.find(".productList").length; i++){

    categoryId = $mainPage.find(".productList").eq(i).attr("id");
    console.log(categoryId);

    $.ajax({
      url: "${pageContext.request.contextPath}/product/selectProductListTop10",
      data: { categoryId: categoryId },
      dataType: "json",
      success: data => {

        let html = "";

        data.forEach(product => {
          html += "<div class='card'>";
          html += "<img src='${pageContext.request.contextPath}/resources/upload/product/" + product.photo + "' class='card-img-top'>";
          html += '<div class="card-body">';
          html += '<p class="card-title">' + product.TITLE + '</p>';
          html += '<p class="card-text">' + product.PRICE + '<small>원</small></p>';
          html += '</div></div>'
        });

        $mainPage.find("#" + categoryId + " .product").html(html);

      },
      error: (x, s, e) => {
        console.log("실패", x, s, e);
      }

    });
  }

});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>