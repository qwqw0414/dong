<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<style>
#shopList #shop-list img{width: 100px; height: 100px;}
#shopList #shop-list{margin: auto; padding: 20px;}
#shopList{background-color: rgb(245, 245, 245);}
#shopList .shop{border: rgb(219, 219, 219) 1px solid; position: relative;}
#shopList .shop .title{display: inline;}
#shopList .shop .date{float: right; position: absolute; right: 0px; top: 40px;}
</style>
<div id="shopList">
    
    <div id="shop-list">
        <div class="shop">
            <img src=".">
            <div class="title">
                <a href="">타이틀</a>
            </div>
            <div class="date">
                가입일
            </div>
        </div>
    </div>

</div>

<script>
$(()=>{
    $("header #search-bar").val('@${keyword}');

    shopList('${keyword}');

    function shopList(keyword){
        $.ajax({
            url: "${pageContext.request.contextPath}/shop/searchShop",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: {keyword:keyword},
            success: data =>{
                let html = "";
                var photo = "";
            
                data.forEach(shop => {

                    if(shop.image === undefined)
                        photo = "${pageContext.request.contextPath}/resources/upload/shopImage/shopping-store.png";
                    else
                        photo = '${pageContext.request.contextPath}/resources/upload/shopImage/'+shop.image;

                    html += '<div class="shop">';
                    html += '<img src="'+photo+'">';
                    html += '<div class="title">';
                    html += "<a href='${pageContext.request.contextPath}/shop/shopView.do?shopNo="+shop.shopNo+"'>";
                    html += shop.shopName+'</a></div>';
                    html += '<div class="date">';
                    html += shop.openDate;
                    html += '</div></div>';
                });

                $("#shopList #shop-list").html(html);
            },
            error: (x, s, e)=>{
                console.log(x, s, e);
            }
        });
    }
});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>