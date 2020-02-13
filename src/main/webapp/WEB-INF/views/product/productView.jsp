<%@page import="java.util.Map"%>
<%@page import="com.pro.dong.product.model.vo.ProductAttachment"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.pro.dong.product.model.vo.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<h1>상품 상세보기</h1>
<hr>
<style>
	.product-info{margin-left: 100px;}
	.something-btn{margin-left: 100px;}
</style>
<%
 	Map<String,Object> map = (Map<String,Object>)request.getAttribute("map");
	List<ProductAttachment> list = new ArrayList<>();
	list = (List<ProductAttachment>)map.get("attachment");
	String html = "";
	String li = "";
	for(int i=0;i<list.size();i++){
		if(i==0){
		html += "<div class='carousel-item active'><img src='"+request.getContextPath()+"/resources/upload/product/"+list.get(i).getPhoto()+"' class='d-block w-100'></div>";	
		} else {
		html += "<div class='carousel-item'><img src='"+request.getContextPath()+"/resources/upload/product/"+list.get(i).getPhoto()+"' class='d-block w-100'></div>";	
		}
	}
	for(int i=0;i<list.size();i++){
		if(i==0){
			li += "<li data-target='#carouselExampleIndicators' data-slide-to='i' class='active'></li>";
		}
		else{
			li += "<li data-target=''#carouselExampleIndicators' data-slide-to='i'></li>";
		}
	} 
%>

<div class="card mb-3 border-light" id="productView">
    <div class="row">

					<div id="carouselExampleIndicators" class="carousel slide carousel-fade" data-ride="carousel" style="width: 320px; height: 320px;">
					<div class="carousel-inner">
					  <ol class="carousel-indicators">
					    <%=li %>
					  </ol>
					  
					   <%=html %>
					  </div>
					   <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
					    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
					    <span class="sr-only">Previous</span>
					  </a>
					  <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
					    <span class="carousel-control-next-icon" aria-hidden="true"></span>
					    <span class="sr-only">Next</span>
					  </a>
			</div>
		<div class="col-8">
			<div>
                <div class="product-info">
                    <h3>${map.product.title }</h3>
                    <br>
                    <p>좋아요/조회수:${map.product.incount }/등록일:${map.product.regDate }</p>
                    <span>가격:${map.product.price }원</span>
                    <hr>
                    <dl>
                    <dt>상세정보</dt>
                    <br>
                    <dd>${map.product.info }</dd>
				    <dd>상품 상태:${map.product.status }</dd>
				    <dd>교환 여부:${map.product.isTrade }</dd>
				    <dd>배송여부:${map.product.shipping }</dd>
				    <dd>거래지역:${map.product.sido } ${map.product.sigungu } ${map.product.dong }</dd>
                
                </dl>
                    <hr>
                    <br />
                    <span>판매자 정보:${map.product.shopNo }</span> <hr><br>
                </div>
                    
                <div class="something-btn">
                    <c:if test="${map.likeCnt eq '0'}">
                        <button class="btn btn-outline-warning" id="btn-like">찜하기</button>
                    </c:if>                        
                    <c:if test="${map.likeCnt ne '0'}">
                        <button class="btn btn-warning" id="btn-like">찜취소</button>
                    </c:if>                        
                    <button class="btn btn-danger">연락하기</button>
                    <button class="btn btn-info">구매하기</button>
                </div>
			</div>
        </div>
    </div>
</div>


<script>
$(()=>{
	
	
// 예찬 시작 =======================================
    var $btnLike = $("#productView #btn-like");

    $btnLike.click(()=>{

        $.ajax({
            url: "${pageContext.request.contextPath}/product/productLike",
            data: {
                memberId: '${memberLoggedIn.memberId}',
                productNo: '${map.product.productNo}'
            },
            type: "POST",
            dataType: "json",
            success: data =>{
                if(data.result != 0){
                    if(data.type == 'I'){
                        $btnLike.removeClass("btn-outline-warning");
                        $btnLike.addClass("btn-warning");
                        $btnLike.text("찜취소");
                    }
                    else{
                        $btnLike.removeClass("btn-warning");
                        $btnLike.addClass("btn-outline-warning");
                        $btnLike.text("찜하기");
                    }


                }else{
                    alert("실패");
                }
            },
            error: (a,b,c) =>{
                console.log(a,b,c);
            }
        });
    });

// ======================================= 예찬 끝
// 민호 시작 =======================================

// ======================================= 민호 끝


})

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>