<%@page import="com.pro.dong.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	Member memberLoggedIn = (Member)request.getSession().getAttribute("memberLoggedIn");
%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<style>
.productList .card {width: 201px; border-radius: 0; height: 280px;}
.productList .card img{width: 200px; height: 200px; border: none;}
#productList .productList .card{float: left; margin: 10px 8px 10px 8px}
#productList .product {width: 1200px; margin: auto; height: 620px;}
#productList {width: 1300px; min-height: 200px;}
#productList .productList{width: 1100px;}
#productList .productList .card-body{padding: 10px 0 0px 8px;}
#productList .productList .regDate{font-size: 0.9em; position: absolute; right: 10px; bottom: 10px;}
</style>
<div id="productList">
    <div class="productList">

    </div>
</div>

<script>
$(()=>{

    var categoryId = '${categoryId}';
    var keyword = '${keyword}';
    var sido = "${memberLoggedIn.sido}";
    var sigungu = "${memberLoggedIn.sigungu}";
    var dong = "${memberLoggedIn.dong}";

    pageLoad(1);

    function pageLoad(cPage){
        console.log(categoryId);
        $.ajax({
            url: "${pageContext.request.contextPath}/product/searchProduct",
            contentType: "application/json; charset=utf-8",
            // type:"POST",
            data: {
                categoryId:categoryId,
                keyword:keyword,
                cPage:cPage,
                sido:sido,
                sigungu:sigungu,
                dong:dong
            },
            dataType: "json",
            success: data=>{
                
                let html = "";

                data.product.forEach(product => {

                    let preTitle = product.title;

                    if(preTitle.length > 12) 
                        preTitle = preTitle.substring(0,12)+"..."

                    html += "<div class='card'>";
                    html += "<img src='${pageContext.request.contextPath}/resources/upload/product/" + product.photo + "' class='card-img-top'>";
                    html += '<div class="card-body">';
                    html += '<p class="card-title">' + preTitle + '</p>';
                    html += '<p class="card-text"><span>' + numberComma(product.price) + '<small>원</small></span></p>';
                    html += '<div class="regDate">'+lastDate(product.regDate)+'</div>';
                    html += '</div></div>'
                });

                $("#productList .productList").html(html);

            },
            error: (x, s, e) => {
            console.log("실패", x, s, e);
            }
        });
    }


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

});


</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>