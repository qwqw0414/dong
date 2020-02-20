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
#productReg #images img{width: auto; height: auto; max-width: 190px; height: 190px;}
#productReg #images {float: right; width: 200px;}
</style>
<div id="productReg" style="font-family: 'MapoPeacefull';">
<h1>상품 등록</h1>
<hr>
<div class="input-area" style="height: 350px;">
    <div class="product-tag" style="height: 200px;">상품이미지</div>
    <div class="text-primary product-insert">
        <form enctype="multipart/form-data" id="formData" method="post">
            <div id="images">
                <input type="file" class="product-photo" id="file-4" name="upFile">
                <br>
                <img src="" id="img-4">
            </div>
            <div id="images">
                <input type="file" class="product-photo" id="file-3" name="upFile">
                <br>
                <img src="" id="img-2">
            </div>
            <div id="images">
                <input type="file" class="product-photo" id="file-2" name="upFile">
                <br>
                <img src="" id="img-3">
            </div>
            <div id="images">
                <input type="file" class="product-photo" id="file-1" name="upFile">
                <br>
                <img src="" id="img-1">
            </div>
        </form>
        <!-- <div style="position: relative; top: 100px;">
            <p style="font-weight: bolder;">* 상품 이미지는 640x640에 최적화 되어 있습니다.</p>
            <p>- 이미지는 상품등록 시 정사각형으로 짤려서 등록됩니다.</p>
            <p>- 이미지를 클릭 할 경우 원본이미지를 확인할 수 있습니다.</p>
            <p>- 큰 이미지일경우 이미지가 깨지는 경우가 발생할 수 있습니다.</p>
            <p>최대 지원 사이즈인 640 X 640 으로 리사이즈 해서 올려주세요.(개당 이미지 최대 10M)</p>
        </div> -->
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
        <button id="btn-myLoaction">내 위치</button> <button id="btn-zipcode">주소 검색</button> <br>
        <input type="text" id="address" readonly>
    </div>
</div>
<hr>
<div class="input-area">
    <div class="product-tag">상태</div>
    <div class="product-insert">
        <div class="custom-control custom-radio custom-control-inline">
            <input type="radio" id="status-o" name="status" class="custom-control-input" value="O">
            <label class="custom-control-label" for="status-o">중고상품</label>
        </div>
        <div class="custom-control custom-radio custom-control-inline">
            <input type="radio" id="status-n" name="status" class="custom-control-input" value="N">
            <label class="custom-control-label" for="status-n">새상품</label>
        </div>
    </div>
</div>
<hr>
<div class="input-area">
    <div class="product-tag">교환</div>
    <div class="product-insert">
        <div class="custom-control custom-radio custom-control-inline">
            <input type="radio" id="isTrade-y" name="isTrade" class="custom-control-input" value="Y">
            <label class="custom-control-label" for="isTrade-y">교환가능</label>
        </div>
        <div class="custom-control custom-radio custom-control-inline">
            <input type="radio" id="isTrade-n" name="isTrade" class="custom-control-input" value="N">
            <label class="custom-control-label" for="isTrade-n">교환불가</label>
        </div>
    </div>
</div>
<hr>
<div class="input-area">
    <div class="product-tag">가격</div class="product-tag">
    <div class="product-insert">
        <input type="text" id="price">
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
        <textarea name="" id="info" cols="30" rows="10" class="form-control"></textarea>
    </div>
</div>
<hr>
<button id="btn-reg">등록하기</button>

</div>

<script>
$(()=>{
var $selectPre = $("#productReg #sel-cate-pre");
var $selectEnd = $("#productReg #sel-cate-end");
var $selectedCategory = $("#productReg #selectedCategory");
var ref = "";
var $file1 = $("#productReg #file-1");
var $file2 = $("#productReg #file-2");
var $file3 = $("#productReg #file-3");
var $file4 = $("#productReg #file-4");
var $title = $("#productReg #title");
var $address = $("#productReg #address");
var $price = $("#productReg #price");
var $info = $("#productReg #info");

// 상품 등록
$("#productReg #btn-reg").click(()=>{

    if( $title.val() == null || $title.val().length == 0){
        alert("제목을 입력해주세요.");
        $title.focus();
        return;
    }

    if($selectPre.val() == null || $selectEnd.val() == null){
        alert("카테고리를 선택해주세요.");
        $selectPre.focus();
        return;
    }

    if($address.val() == null || $address.val().length == 0){
        alert("주소를 입력해주세요.");
        $address.focus();
        return;
    }


    if($("#productReg [name=status]:checked").val() == null){
        alert("상태를 선택해주세요.");
        $("#productReg #status-o").focus();
        return;
    }

    if($("#productReg [name=isTrade]:checked").val() == null){
        alert("교환 여부를 선택해주세요.");
        $("#productReg #isTrade-y").focus();
        return;
    }

    if($price.val() == null || $price.val().length == 0){
        alert("가격을 입력해주세요.");
        $price.focus();
        return;
    }

    var regex= /[^0-9]/g
    if(regex.test($price.val())){
        alert("숫자만 입력해주세요.");
        $price.focus();
        return;
    }

    var addrArr = ($address.val()).split(" ");

    var $form = $("#productReg #formData");

    var formData = new FormData();

    formData.append("title",$title.val());
    formData.append("categoryId",$selectEnd.val());
    formData.append("sido",addrArr[0]);
    formData.append("sigungu",addrArr[1]);
    formData.append("dong",addrArr[2]);
    formData.append("status",$("#productReg [name=status]:checked").val());
    formData.append("isTrade",$("#productReg [name=isTrade]:checked").val());
    formData.append("info",$info.val());
    formData.append("price",$price.val());
    formData.append("shipping",$("#productReg #shipping").prop("checked"));
    formData.append("haggle",$("#productReg #haggle").prop("checked"));
    formData.append("memberId",'<%=memberLoggedIn.getMemberId()%>');
    formData.append("files", $file1[0].files[0]);
    formData.append("files", $file2[0].files[0]);
    formData.append("files", $file3[0].files[0]);
    formData.append("files", $file4[0].files[0]);


    $.ajax({
        url: "${pageContext.request.contextPath}/product/productReg",
        data: formData,
        dataType: "json",
        type: "post",
        contentType: false,
        processData: false,
        success: data =>{
            if(data == 1){
                alert("등록 성공");
            }else{
                alert("실패");
            }
        },
        error: (x, s, e) => {
            console.log("실패", x, s, e);
        }
    });


});

//첨부파일 등록
function upload(){
    var result = 0;
    var $form = $("#productReg #formData");

    var formData = new FormData();
    formData.append("files", $file1[0].files[0]);
    formData.append("files", $file2[0].files[0]);
    formData.append("files", $file3[0].files[0]);
    formData.append("files", $file4[0].files[0]);

    $.ajax({
        url: "${pageContext.request.contextPath}/product/filesUpload",
        type: "post",
        data: formData,
        contentType: false,
        processData: false,
        success: data=>{
            console.log(data);
        },
        error: (x, s, e) => {
            console.log("실패", x, s, e);
        }
    })

    return result;
}


// 첨부파일 사진 미리보기
$("#productReg .product-photo").change((e)=>{
    imagePreview(e.target);
});

function imagePreview(input){

    if((input.files[0] != undefined)&&(input.files && input.files[0])){
        var filerdr = new FileReader();
        filerdr.onload = function(e){
            $(input).siblings("img").attr('src',e.target.result);
        }
        filerdr.readAsDataURL(input.files[0]);
    }else{
        $(input).siblings("img").attr('src','');
    }
}


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

$("#productReg #btn-zipcode").click(()=>{
	 
	new daum.Postcode({
	    oncomplete: function(data) {
	    	var sido = "";
			
	    	if(data.sido=='서울') {
	    		sido = data.sido+"특별시";
	    	}
	    	if(data.sido=='부산' || data.sido=='대구' || data.sido=='인천' || data.sido=='광주' || data.sido=='대전' || data.sido=='울산') {
	    		sido = data.sido+"광역시";
	    	}
	    	if(data.sido == '경기') {
	    		sido = data.sido+"도";
	    	}
	    	if(data.sido == '강원') {
	    		sido = data.sido+"도";
	    	}
	    	if(data.sido == '제주특별자치도') {
	    		sido = data.sido;
	    	}
	    	if(data.sido == '충북') {
	    		sido = "충청북도";
	    	}
	    	if(data.sido == '충남') {
	    		sido = "충청남도";
	    	}
	    	if(data.sido == '전북') {
	    		sido = "전라북도";
	    	}
	    	if(data.sido == '전남') {
	    		sido = "전라남도";
	    	}
	    	if(data.sido == '경북') {
	    		sido = "경상북도";
	    	}
	    	if(data.sido == '경남') {
	    		sido = "경상남도";
	    	}
	    	
	    	console.log(sido);
	    	document.getElementById('address').value = sido +" "+ data.sigungu +" "+ data.bname;
	    }
	}).open();
});

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>