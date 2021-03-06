<%@page import="com.pro.dong.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
#productReg .images img{width: auto; height: auto; max-width: 190px; height: 190px;}
#productReg .images {float: right; width: 200px;}
#hoto-update button.close{left: 100px; position: absolute;}
.kjSbMl {
    background-image : url("${pageContext.request.contextPath}/resources/images/imgX.png");
    width: 20px;
    height: 20px;
}
</style>
<div id="productReg" style="font-family: 'MapoPeacefull';">
<h1>상품 수정</h1>
<hr>
<div class="input-area" style="height: 350px;">
    <div class="product-tag" style="height: 200px;">상품이미지</div>
    <div class="text-primary product-insert" id="photo-update">
		<!-- <form enctype="multipart/form-data" id="formData4" method="post">
			<div class="images" id="images4">
				<input type="file" class="product-photo" id="file-4" name="upFile">
				<br>
				<c:if test="${list[3] ne null}">
					<div>
						<input type="hidden" value="${list[3].PHOTO}">
					</div>
				</c:if>
				<c:if test="${list[3] eq null}">
					<input type="hidden" value="">
				</c:if>
				<img src="" class="realProImg" id="img_4">
				<c:if test="${list[3] ne null}">
					<img src="${pageContext.request.contextPath}/resources/upload/product/${list[3].PHOTO}" class="proImg"
						id="img-4">
				</c:if>
			</div>
		</form> -->
		<div class="images">
			<input type="file" class="product-photo">
			<c:if test='${list[3] ne null}'><button class="close">x</button></c:if>
			<br>
			<c:if test='${list[3] ne null}'>
				<img src="${pageContext.request.contextPath}/resources/upload/product/${list[3].PHOTO}" class="proImg">
				<input type="hidden" name="oldPhotoName" value="${list[3].PHOTO}">
			</c:if>
			<c:if test='${list[3] eq null}'>
				<img src="" class="proImg">
				<input type="hidden" name="oldPhotoName" value="">
			</c:if>
		</div>

		<div class="images">
			<input type="file" class="product-photo">
			<c:if test='${list[2] ne null}'><button class="close">x</button></c:if>
			<br>
			<c:if test='${list[2] ne null}'>
				<img src="${pageContext.request.contextPath}/resources/upload/product/${list[2].PHOTO}" class="proImg">
				<input type="hidden" name="oldPhotoName" value="${list[2].PHOTO}">
			</c:if>
			<c:if test='${list[2] eq null}'>
				<img src="" class="proImg">
				<input type="hidden" name="oldPhotoName" value="">
			</c:if>
		</div>

		<div class="images">
			<input type="file" class="product-photo">
			<c:if test='${list[1] ne null}'><button class="close">x</button></c:if>
			<br>
			<c:if test='${list[1] ne null}'>
				<img src="${pageContext.request.contextPath}/resources/upload/product/${list[1].PHOTO}" class="proImg">
				<input type="hidden" name="oldPhotoName" value="${list[1].PHOTO}">
			</c:if>
			<c:if test='${list[1] eq null}'>
				<img src="" class="proImg">
				<input type="hidden" name="oldPhotoName" value="">
			</c:if>
		</div>

		<div class="images">
			<input type="file" class="product-photo" id="thum">
			<c:if test='${list[0] ne null}'><button class="close">x</button></c:if>
			<br>
			<c:if test='${list[0] ne null}'>
				<img src="${pageContext.request.contextPath}/resources/upload/product/${list[0].PHOTO}" class="proImg">
				<input type="hidden" name="oldPhotoName" value="${list[0].PHOTO}">
			</c:if>
			<c:if test='${list[0] eq null}'>
				<img src="" class="proImg">
				<input type="hidden" name="oldPhotoName" value="">
			</c:if>
		</div>
    </div>
</div>
<script>
$(()=>{
	$("#photo-update .close").click((e)=>{
		deletePhoto(e.target);
		$(e.target).siblings("img").attr("src","");
		$(e.target).hide();
	});
	$("#photo-update [type=file]").change((e)=>{
		var $this = $(e.target);
		imagePreview(e.target);

		if(e.target.files[0] === undefined){
			deletePhoto(e.target);
			$(e.target).siblings(".close").hide();
			return;
		}	
		if($this.siblings("[type=hidden]").val() == ''){
			updatePhoto(e.target, "insert");
		}
		else if($this.siblings("[type=hidden]").val() != ''){
			updatePhoto(e.target, "update");
		}
	});

	function deletePhoto(input){
		var $fileName = $(input).siblings("[type=hidden]");
		$.ajax({
			url: "${pageContext.request.contextPath}/product/deleteFile",
			type: "post",
			data: {fileName:$fileName.val()},
			dataType: "json",
			success: data =>{
				$fileName.val('');
			},
			error: (a,b,c)=>{
				console.log(a,b,c);
			}
		})
	}

	function updatePhoto(input, type) {
		var thum = $(input).attr("id") == 'thum' ? 'Y':'N'
		var formData = new FormData();

		formData.append("files", input.files[0]);
		formData.append("thumnail", thum);
		formData.append("oldFileName", $(input).siblings("[type=hidden]").val());
		formData.append("type", type);
		formData.append("productNo", '${productNo}');

		$.ajax({
			url: "${pageContext.request.contextPath}/product/filesUpdate",
			type: "post",
			data: formData,
			contentType: false,
			processData: false,
			success: data => {
				$(input).siblings("[type=hidden]").val(data.newName);
			},
			error: (x, s, e) => {
				console.log("실패", x, s, e);
			}
		});
	}

	function imagePreview(input) {

		if ((input.files[0] != undefined) && (input.files && input.files[0])) {
			var filerdr = new FileReader();
			filerdr.onload = function (e) {
				$(input).siblings("img").attr('src', e.target.result);
			}
			filerdr.readAsDataURL(input.files[0]);
		} else {
			$(input).siblings("img").attr('src', '');
		}
	}
});
</script>
<hr>
	<div class="input-area" style="height: 80px;">
	    <div class="product-tag">제목</div>
	    <div class="product-insert">
	        <input type="text" name="title" id="title" maxlength="40" value="${list[0].TITLE}">
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
	        <input type="text" id="address" value="${list[0].SIDO} ${list[0].SIGUNGU} ${list[0].DONG}" readonly>
	    </div>
	</div>
	<hr>
	<div class="input-area">
	    <div class="product-tag">상태</div>
	    <div class="product-insert">
	        <div class="custom-control custom-radio custom-control-inline">
	            <input type="radio" id="status-o" name="status" ${list[0].STATUS eq 'O' ? "checked" : ""} class="custom-control-input" value="O">
	            <label class="custom-control-label" for="status-o">중고상품</label>
	        </div>
	        <div class="custom-control custom-radio custom-control-inline">
	            <input type="radio" id="status-n" name="status" ${list[0].STATUS eq 'N' ? "checked" : ""} class="custom-control-input" value="N">
	            <label class="custom-control-label" for="status-n">새상품</label>
	        </div>
	    </div>
	</div>
	<hr>
	<div class="input-area">
	    <div class="product-tag">교환</div>
	    <div class="product-insert">
	        <div class="custom-control custom-radio custom-control-inline">
	            <input type="radio" id="isTrade-y" name="isTrade" ${list[0].IS_TRADE eq 'Y' ? "checked" : ""} class="custom-control-input" value="Y">
	            <label class="custom-control-label" for="isTrade-y">교환가능</label>
	        </div>
	        <div class="custom-control custom-radio custom-control-inline">
	            <input type="radio" id="isTrade-n" name="isTrade" ${list[0].IS_TRADE eq 'N' ? "checked" : ""} class="custom-control-input" value="N">
	            <label class="custom-control-label" for="isTrade-n">교환불가</label>
	        </div>
	    </div>
	</div>
	<hr>
	<div class="input-area">
	    <div class="product-tag">가격</div>
	    <div class="product-insert">
	        <input type="text" id="price" value="${list[0].PRICE}">
	        <div class="custom-control custom-checkbox">
	            <input type="checkbox" class="custom-control-input" ${list[0].SHIPPING eq 'Y' ? "checked" : ""} id="shipping">
	            <label class="custom-control-label" for="shipping">무료 배송</label>
	        </div>
	        <div class="custom-control custom-checkbox">
	            <input type="checkbox" class="custom-control-input" ${list[0].HAGGLE eq 'Y' ? "checked" : ""} id="haggle">
	            <label class="custom-control-label" for="haggle">가격협의 가능</label>
	        </div>
	    </div>
	</div>
	<hr>
	<div class="input-area">
	    <div class="product-tag">설명</div>
	    <div class="product-insert">
	        <textarea name="" id="info" cols="30" rows="10" class="form-control"></textarea>
	    </div>
	</div>
	<hr>
	<button id="btn-reg" >수정하기</button>
</div>

<script>
$(()=>{
	selectRefCategory();
		
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
	var addrArr = ($address.val()).split(" ");


	$("#info").text("${list[0].INFO}");

	$("#productReg #btn-reg").click(()=>{
		console.log($title.val());
		if( $title.val() == null || $title.val().length == 0){
			alert("제목을 입력해주세요.");
			$title.focus();
			return false;
		}
		if($selectPre.val() == null || $selectEnd.val() == null){
			alert("카테고리를 선택해주세요.");
			$selectPre.focus();
			return false;
		}
		if($address.val() == null || $address.val().length == 0){
			alert("주소를 입력해주세요.");
			$address.focus();
			return false;
		}
		if($("#productReg [name=status]:checked").val() == null){
			alert("상태를 선택해주세요.");
			$("#productReg #status-o").focus();
			return false;
		}
		if($("#productReg [name=isTrade]:checked").val() == null){
			alert("교환 여부를 선택해주세요.");
			$("#productReg #isTrade-y").focus();
			return false;
		}
		if($price.val() == null || $price.val().length == 0){
			alert("가격을 입력해주세요.");
			$price.focus();
			return false;
		}
		var regex= /[^0-9]/g
		if(regex.test($price.val())){
			alert("숫자만 입력해주세요.");
			$price.focus();
			return false;
		}
		
		else{
			$.ajax({
				url: "${pageContext.request.contextPath}/product/productUpdateEnd",
				type: "post",
				data: {title : $title.val(),
					categoryId : $selectEnd.val(),
					sido : addrArr[0],
					sigungu : addrArr[1],
					dong : addrArr[2],
					status : $("#productReg [name=status]:checked").val(),
					isTrade : $("#productReg [name=isTrade]:checked").val(),
					info : $info.val(),
					price : $price.val(),
					shipping : $("#productReg #shipping").prop("checked"),
					haggle : $("#productReg #haggle").prop("checked"),
					productNo : '${list[0].PRODUCT_NO}'},
				success: data=>{
					if(data > 0){
						location.href="${pageContext.request.contextPath}/product/productView.do?productNo="+${list[0].PRODUCT_NO};
					}
					else{
						alert("상품 정보 수정 변경 실패");
					}
				},
				error: (x, s, e) => {
					console.log("실패", x, s, e);
				}
			});
		}

	});

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
    },
	complete: (data)=>{
		$selectPre.val("${category[0].CATEGORY_REF}").attr("selected","selected");
		selectedCategory();
  	}
});

$selectEnd.click(()=>{selectedCategory();});

//소분류 카테고리 새로 가져오기
$selectPre.click(()=>{
    $.ajax({
        url: "${pageContext.request.contextPath}/product/categoryRefList",
        data: {categoryRef: $selectPre.val()},
        dataType: "json",
        success: data => {
            let option = "";
            data.forEach(category => {
                option += "<option value='" + category.categoryId + "'>" + category.categoryName + "</option>";
            });

            $selectEnd.html(option);
           /*  selectedCategory(); */
        },
        error: (x, s, e) => {
            console.log("실패", x, s, e);
        },
    	complete: (data)=>{
    		$selectEnd.val("${category[0].CATEGORY_ID}").attr("selected","selected");
    		selectedCategory();
      	}
    });
});


function selectRefCategory(){
	var categoryRef = "${category[0].CATEGORY_REF}";
    $.ajax({
        url: "${pageContext.request.contextPath}/product/categoryRefList",
        dataType: "json",
        data: {categoryRef : categoryRef},
        success: data => {
            let option = "";
            data.forEach(category => {
                option += "<option value='" + category.categoryId + "'>" + category.categoryName + "</option>";
            });
            $selectEnd.html(option);
        },
        error: (x, s, e) => {
            console.log("실패", x, s, e);
        },
    	complete: (data)=>{
    		$selectEnd.val("${category[0].CATEGORY_ID}").attr("selected","selected");
    		selectedCategory();
      	}
    });
}

// 선택한 카테고리 동기화
function selectedCategory(){
    let html = "";
    html += $selectPre.children("[value="+$selectPre.val()+"]").html();
    html += ' > ';
    if($selectEnd.val() != undefined)
        html += $selectEnd.children("[value="+$selectEnd.val()+"]").html();

    $selectedCategory.html(html);
}

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

});

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>