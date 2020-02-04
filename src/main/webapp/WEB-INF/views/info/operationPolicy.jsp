<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<style>
.head{
	width: 100%;
    display: flex;
    flex-direction: column;
    -webkit-box-align: center;
    align-items: center;
    padding: 36px 0px 30px;
}
.head > h1 {
	font-size: 30px;
    line-height: 1.2;
    letter-spacing: -2px;
    text-align: center;
    font-weight: 600;
}
b{
    color: green;
}
.head > h2{
	margin-top: 30px;
    font-size: 16px;
    color: rgb(102, 102, 102);
}
.headMain{
    background-size: contain;

    background-position: center center;
    background-repeat: no-repeat;
}
.content{
	padding: 0px 30px;
}
.cbox1{
	display: flex;
    -webkit-box-align: center;
    align-items: center;
    padding: 30px 0px;
    border-top: 1px solid rgb(245, 245, 245);
}
.cbox1_img{
    background-size: contain;
    margin-right: 10px;
    background-position: center center;
    background-repeat: no-repeat;
}
p {
    display: block;
    margin-block-start: 1em;
    margin-block-end: 1em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
}
</style>

<body>
<div class="head">
<div class="headMain"><img src="image/hand.PNG"></div>
<h1><b>동네한바퀴</b>는 모두가 <br />이용하는 열린공간입니다.</h1>
<h2>공정한 거래문화를 위해 동네한바퀴는 다음과 같은 약속들을 준수합니다.</h2>
</div>
<div class="line"></div>

	<div class="content">
		<div class="cbox1">
			<div class="cbox1_img"><img src="image/cbox1.PNG"></div>
			<div class="cbox1_text">
				<h2>거래 금지 품목 거래시 제재 받을 수 있습니다</h2>
				<p>전자 통신판매법 등에 의해 저촉되어 인터넷 거래기준에 적용되는 상품으로 1회 적발시 즉시 이용제한이 될 수 있습니다.</p>
			</div>
        </div>

        <div class="line"></div>

        <div class="cbox1">
			<div class="cbox1_img"><img src="image/cbox2.PNG"></div>
			<div class="cbox1_text">
				<h2>랜덤박스(비공개/반공개)는 분쟁의 원인이 되고 있습니다</h2>
				<p>랜덤박스는 상품의 상태 및 내용물을 확인할 수 없거나 모호하여 분쟁과 신고 접수의 원인이 되고 있어 운영자에 의해 제재 받을 수 있습니다.</p>
			</div>
        </div>
        
        <div class="line"></div>
        
        <div class="cbox1">
			<div class="cbox1_img"><img src="image/cbox3.PNG"></div>
			<div class="cbox1_text">
				<h2>상품, 댓글의 10회 이상 도배, 번개톡 도배 등록을 피해주세요</h2>
			</div>
        </div>
        
        <div class="line"></div>
        
        <div class="cbox1">
			<div class="cbox1_img"><img src="image/cbox4.PNG"></div>
			<div class="cbox1_text">
				<h2>욕설, 성희롱 등 비매너 행위는 타인을 불쾌하게 합니다</h2>
				<p>비매너 행위에 관한 게시물과 댓글은 운영진에 의해 제재 받을 수 있습니다.</p>
			</div>
        </div>
        
        <div class="line"></div>
        
        <div class="cbox1">
			<div class="cbox1_img"><img src="image/cbox5.PNG"></div>
			<div class="cbox1_text">
				<h2>선정적이거나 판매 상품에 적절치 않은 이미지는 사용자 혼란을 일으킵니다</h2>
				<p>판매하려는 상품을 명확히 표현하는 사진을 사용해주세요.</p>
			</div>
        </div>
        
        <div class="line"></div>
        
        <div class="cbox1">
			<div class="cbox1_img"><img src="image/cbox6.PNG"></div>
			<div class="cbox1_text">
				<h2>상품명, 키워드에 판매 상품과 관계없는 단어 삽입은 제재 받을 수 있습니다</h2>
				<p>상품 노출을 높여보고자 인기 검색어를 마구 집어 넣는 행위는 여러 유저들에게 불편을 일으키는 원인이 됩니다.</p>
			</div>
        </div>
        
        <div class="line"></div>
        
        <div class="cbox1">
			<div class="cbox1_img"><img src="image/cbox7.PNG"></div>
			<div class="cbox1_text">
				<h2>정확한 상품 가격 정보를 입력해 주세요</h2>
				<p>실제 판매하려는 가격과 다른 상품 가격정보를 써 놓아 구매자에게 혼돈을 주지 마세요.</p>
			</div>
        </div>
        
        <div class="line"></div>

        <div class="head">
            <h3><b>4진 아웃제</b>를 통해 <br />제재해 나가겠습니다.</h3>
            <h2>4진 아웃제는 다음과 같은 절차로 운영됩니다.</h2>
            <div class="headMain"><img src="image/cbox8.PNG"></div>
        </div>

	</div>

</body>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>