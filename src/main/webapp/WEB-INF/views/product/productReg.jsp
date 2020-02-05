<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<style>
#productReg{/* font-family: "MapoPeacefull" sans-serif; */ width: 1000px; margin: auto;}
#productReg .input-area{padding: 20px 0 20px 0;}
#productReg .product-tag{width: 170px; font-size: 1.1em; position: absolute;}
#productReg p{font-size: 0.9em; margin: 0;}
#productReg .product-insert{left: 0px; margin-left: 170px;}
#productReg .product-photo{width: 100px;}
#productReg select {font-size: 1.2em; width: 300px;}
#productReg #category-check{top: 275px; width: 200px;}
</style>
<div id="productReg" style="font-family: 'MapoPeacefull';">
<h1>기본정보</h1>
<hr>
<div class="input-area" style="height: 350px;">
    <div class="product-tag" style="height: 200px;">상품이미지</div>
    <div class="text-primary product-insert">
        <div style="margin-bottom: 20px;">
            <input type="file" class="product-photo">
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
        <input type="text" maxlength="40">
    </div>
</div>
<hr>
<div class="input-area" style="height: 320px;">
    <div class="product-tag">카테고리</div>
    <div class="product-insert">
        <select id="sel-cate-pre" size="10">
            <option value="">가나다라마바사</option>
        </select>
        <select id="sel-cate-pre" size="10" style="left: 299px;">
            <option value="">가나다라마바사</option>
        </select>
        <br>
        <div class="text-danger" id="category-check">선택한 카테고리:</div>
    </div>
</div>
<hr>
<div class="input-area" style="height: 140px;">
    <div class="product-tag">거래지역</div>
    <div class="product-insert">
        <button>내 위치</button> <button>주소 검색</button> <br>
        <input type="text">
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
    </div>
</div>
<hr>
<div class="input-area">
    <div class="product-tag">설명</div class="product-tag">
</div>
<hr>
<button>등록하기</button>

</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>