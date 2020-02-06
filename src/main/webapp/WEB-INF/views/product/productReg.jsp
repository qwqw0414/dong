<%@page import="com.pro.dong.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<%
	Member memberLoggedIn = (Member)request.getSession().getAttribute("memberLoggedIn");
%>
<style>
#productReg{/* font-family: "MapoPeacefull" sans-serif; */ width: 1000px; margin: auto;}
#productReg .input-area{padding: 20px 0 20px 0;}
#productReg .product-tag{width: 170px; font-size: 1.1em; position: absolute;}
#productReg p{font-size: 0.9em; margin: 0;}
#productReg .product-insert{left: 0px; margin-left: 170px;}
#productReg .product-photo{width: 100px;}
#productReg select {font-size: 1.2em; width: 300px;}
#productReg #category-check{top: 275px; width: 800px;}
#productReg #images img{width: 640px; height: 640px;}
</style>
<div id="productReg" style="font-family: 'MapoPeacefull';">
<h1>기본정보</h1>
<hr>
<div class="input-area" style="height: 350px;">
    <div class="product-tag" style="height: 200px;">상품이미지</div>
    <div class="text-primary product-insert">
        <div style="margin-bottom: 20px;">
            <input type="file" class="product-photo">
            <div id="images">
                <img src="" id="image1">
            </div>
        </div>
        <p style="font-weight: bolder;">* 상품 이미지는 640x640에 최적화 되어 있습니다.</p>
        <p>- 이미지는 상품등록 시 정사각형으로 짤려서 등록됩니다.</p>
        <p>- 이미지를 클릭 할 경우 원본이미지를 확인할 수 있습니다.</p>
        <p>- 큰 이미지일경우 이미지가 깨지는 경우가 발생할 수 있습니다.</p>
        <p>최대 지원 사이즈인 640 X 640 으로 리사이즈 해서 올려주세요.(개당 이미지 최대 10M)</p>
    </div>
</div>
<hr>
<div class="input-area" style="height: 80px;">
    <div class="product-tag">제목</div>
    <div class="product-insert">
        <input type="text" id="title" maxlength="40">
    </div>
</div>
<hr>
<div class="input-area" style="height: 320px;">
    <div class="product-tag">카테고리</div>
    <div class="product-insert">
        <select id="sel-cate-pre" size="10">
        </select>
        <select id="sel-cate-end" size="10" style="left: 299px;">
        </select>
        <br>
        <div class="text-danger" id="category-check">
            선택한 카테고리 :
            <span id="selectedCategory"></span>
        </div>
    </div>
</div>
<hr>
<div class="input-area" style="height: 140px;">
    <div class="product-tag">거래지역</div>
    <div class="product-insert">
        <button id="btn-myLoaction">내 위치</button> <button>주소 검색</button> <br>
        <input type="text" id="address" readonly>
    </div>
</div>
<hr>
<div class="input-area">
    <div class="product-tag">상태</div>
    <div class="product-insert">
        <div class="custom-control custom-radio custom-control-inline">
            <input type="radio" id="status-o" name="status" class="custom-control-input">
            <label class="custom-control-label" for="status-o">중고상품</label>
        </div>
        <div class="custom-control custom-radio custom-control-inline">
            <input type="radio" id="status-n" name="status" class="custom-control-input">
            <label class="custom-control-label" for="status-n">새상품</label>
        </div>
    </div>
</div>
<hr>
<div class="input-area">
    <div class="product-tag">교환</div>
    <div class="product-insert">
        <div class="custom-control custom-radio custom-control-inline">
            <input type="radio" id="isTrade-y" name="isTrade" class="custom-control-input">
            <label class="custom-control-label" for="isTrade-y">교환가능</label>
        </div>
        <div class="custom-control custom-radio custom-control-inline">
            <input type="radio" id="isTrade-n" name="isTrade" class="custom-control-input">
            <label class="custom-control-label" for="isTrade-n">교환불가</label>
        </div>
    </div>
</div>
<hr>
<div class="input-area">
    <div class="product-tag">가격</div class="product-tag">
    <div class="product-insert">
        <input type="text">
        <div class="custom-control custom-checkbox">
            <input type="checkbox" class="custom-control-input" id="shipping">
            <label class="custom-control-label" for="shipping">무료 배송</label>
        </div>
        <div class="custom-control custom-checkbox">
            <input type="checkbox" class="custom-control-input" id="haggle">
            <label class="custom-control-label" for="haggle">가격협의 가능</label>
        </div>
    </div>
</div>
<hr>
<div class="input-area">
    <div class="product-tag">설명</div class="product-tag">
    <div class="product-insert">
        <textarea name="" id="" cols="30" rows="10" class="form-control"></textarea>
    </div>
</div>
<hr>
<button>등록하기</button>

</div>

<script>
$(()=>{
var $selectPre = $("#productReg #sel-cate-pre");
var $selectEnd = $("#productReg #sel-cate-end");
var $selectedCategory = $("#productReg #selectedCategory");
var ref = "";

//대분류 카테고리 가져오기
$.ajax({
    url: "${pageContext.request.contextPath}/product/categoryList",
    dataType: "json",
    success: data=>{
        let option = "";
        data.forEach(category => {
            option += "<option value='"+category.categoryId+"'>" + category.categoryName + "</option>";
        });

        $selectPre.html(option);
    },
    error : (x,s,e) =>{
        console.log("실패",x,s,e);
    }
});
$selectEnd.click(()=>{selectedCategory();});

//소분류 카테고리 가져오기
$selectPre.click(()=>{
    $.ajax({
        url: "${pageContext.request.contextPath}/product/categoryList",
        data: {categoryRef: $selectPre.val()},
        dataType: "json",
        success: data => {
            let option = "";
            data.forEach(category => {
                option += "<option value='" + category.categoryId + "'>" + category.categoryName + "</option>";
            });

            $selectEnd.html(option);
            selectedCategory();
        },
        error: (x, s, e) => {
            console.log("실패", x, s, e);
        }
    });
});

// 선택한 카테고리 동기화
function selectedCategory(){
    let html = "";
    html += $selectPre.children("[value="+$selectPre.val()+"]").html();
    html += ' > ';
    if($selectEnd.val() != undefined)
        html += $selectEnd.children("[value="+$selectEnd.val()+"]").html();

    $selectedCategory.html(html);
}

});

$("#productReg #btn-myLoaction").click(()=>{
    $.ajax({
        url: "${pageContext.request.contextPath}/member/selectAddress",
        data: {memberId: '<%=memberLoggedIn.getMemberId()%>'},
        dataType: "json",
        success: data => {
            let html = "";
            html += data.sido + " ";
            html += data.sigungu + " ";
            html += data.dong;

            $("#productReg #address").val(html);
        },
        error: (x, s, e) => {
            console.log("실패", x, s, e);
        }
    });
});

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>