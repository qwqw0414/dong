<%@page import="com.pro.dong.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	Member memberLoggedIn = (Member)request.getSession().getAttribute("memberLoggedIn");
%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<style>
#productList .productList img{width: 200px; height: 200px;}
#productList .productList{position: static; display: inline-block; margin-left: 50px;}
#productList .card{width: 201px; height: 300px; float: left;cursor: pointer}
#productList .card .card-body{padding: 5px 0 0 8px;}
#productList .card .card-text{margin: 0;}
#pageBar{position: static; display:block; }
</style>
<div id="productList" style="position: static;">
    <div class="productList">

    </div>
</div>
<div id="pageBar"></div>

<script>
$(()=>{

    var categoryId = '${categoryId}';
    var keyword = '${keyword}';
    var sido = "${memberLoggedIn.sido}";
    var sigungu = "${memberLoggedIn.sigungu}";
    var dong = "${memberLoggedIn.dong}";

    pageLoad(1);
    $("header #search-bar").val(keyword);

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
                    html += "<input type='hidden' class='productNo' value='"+product.productNo+"'>";
                    html += "<img src='${pageContext.request.contextPath}/resources/upload/product/" + product.photo + "' class='card-img-top'>";
                    html += '<div class="card-body">';
                    html += '<p class="card-title">' + preTitle + '</p>';
                    html += '<p class="card-text"><span>' + numberComma(product.price) + '<small>원</small></span></p>';
                    html += '<div class="regDate">'+lastDate(product.regDate)+'</div>';
                    html += '</div></div>'
                });

                $("#productList .productList").html(html);
                $("#pageBar").html(data.pageBar);
            },
            error: (x, s, e) => {
            console.log("실패", x, s, e);
            },
            complete: ()=>{
                $("#pageBar a").click((e)=>{
                    pageLoad($(e.target).siblings("input").val());
                });
                $("#productList .card").click(function(){
                	console.log($(this).children("input"));
                    var productNo = $(this).children("input").val();
                    console.log(productNo);
                    location.href = "${pageContext.request.contextPath}/product/productView.do?productNo="+productNo;
                  });
            }
        });
    }


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

});


</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>