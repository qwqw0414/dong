<%@page import="com.pro.dong.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<%
	Member memberLoggedIn = (Member)request.getSession().getAttribute("memberLoggedIn");
%>

<script>
$(()=>{
	
	loadMyProductList(1);
	
	/*내 상품 list 뿌려주기*/
	function loadMyProductList(cPage){
		
		var memberId = '${memberLoggedIn.getMemberId()}';
		var saleCategory = $("#saleCategory").val();
		var searchKeyword = $("#searchKeyword").val();
		
		$.ajax({
			url:"${pageContext.request.contextPath}/shop/loadMyProductManage",
			type: "GET",
			dataType: "json",
			data:{
				memberId:memberId,
				cPage:cPage,
				saleCategory:saleCategory,
				searchKeyword:searchKeyword
			},
			success:data=>{
				
				let $table = $("#product-tbl");
				let header = "<thead><tr><th scope='col'>사진</th><th scope='col'>판매상태</th><th scope='col'>상품명</th><th scope='col'>가격</th><th scope='col'>최근수정일</th><th scope='col'>기능</th></tr></thead>";
				$table.html("");
				
				let html = "";
				data.product.forEach(product=>{
	
					html += "<tr>";
					if(product.IS_SALE=='Y'){
						html += "<td class='img-td' style='width:235px;'><div style:'position:relative; width:211px; height:152px;'><a href='${pageContext.request.contextPath}/product/productView.do?productNo="+product.PRODUCT_NO+"'><div style=' margin-left:30.5px; position:absolute; background-color:rgba(0, 0, 0, 0.65); z-index:10; height:152px; width:152px;'><p style='margin-top:64px;'>판매완료</p></div></a><img style='width:152px; height:152px; position:relative; z-index:1;' src='${pageContext.request.contextPath}/resources/upload/product/"+product.PHOTO+"'/></div></td>";
					}
					else{
						html += "<td class='img-td'><a href='${pageContext.request.contextPath}/product/productView.do?productNo="+product.PRODUCT_NO+"'><img style='width:152px; height:152px;' src='${pageContext.request.contextPath}/resources/upload/product/"+product.PHOTO+"'/></a></td>";
					}
					if(product.IS_SALE=='N'){
						html += "<td><select class='select' class='custom-select'><option value='N' selected>판매중</option><option value='I'>거래중</option><option value='Y'>판매완료</option></select></td>"
					}
					else if(product.IS_SALE=='I'){
						html += "<td><select class='select' class='custom-select'><option value='N'>판매중</option><option value='I' selected>거래중</option><option value='Y'>판매완료</option></select></td>"
					}
					else{

						html += "<td><select class='select' class='custom-select' disabled><option value='N'>판매중</option><option value='I'>거래중</option><option value='Y' selected >판매완료</option></select></td>"
					}
					html += "<input type='hidden' class='productNo' value='"+product.PRODUCT_NO+"'/>"
					html += "<td>"+product.TITLE+"</td>";
					html += "<td>"+numberComma(product.PRICE)+"원</td>";
					html += "<td>"+product.REG_DATE+"</td>";
					if(product.IS_SALE=='Y'){
						html += "<td class='btn-td'><button type='button' disabled class='btn btn-outline-success btn-sm' id='btn-update' value='"+product.PRODUCT_NO+"' style='width: 45px;'>UP</button><br/>";
					}
					else{
						html += "<td class='btn-td'><button type='button' class='btn btn-outline-success btn-sm' id='btn-update' value='"+product.PRODUCT_NO+"' style='width: 45px;'>UP</button><br/>";
					}
					
					if(product.IS_SALE=='Y'){
						html += "<button  type='button' disabled class='btn btn-outline-primary btn-sm'>수정</button><br/>"
					}
					else{
						html += "<button type='button' class='btn btn-outline-primary btn-sm' id='updateBtn' value='"+product.PRODUCT_NO+"'>수정</button><br/>"
					}
			      	
			      	html += "<button type='button' class='btn btn-outline-danger btn-sm' id='btn-delete' value='"+product.PRODUCT_NO+"'>삭제</button></td>";
					html += "</tr>";
				});
				
				$table.html(header+html);
				$("#pageBar").html(data.pageBar);
			},
			error:(x,s,e)=>{
				console.log("실패",x,s,e);
			},
			complete:(data)=>{
				$("#pageBar a").click((e)=>{
					loadMyProductList($(e.target).siblings("input").val());
	            });
			}
		});
	}
	
	/* 상품수정 페이지로 이동 */
	$(document).on("click", "#updateBtn", function(e){
		var no = $(e.target).val();
		location.href="${pageContext.request.contextPath}/product/productUpdate.do?productNo="+no;
	});
	
	/*판매상태로 정렬*/
	$("#saleCategory").change(function(){
		$("#searchKeyword").val('');
		loadMyProductList(1);
	});
	
	/* $("#searchKeyword").keyup((e)=>{if(e.keyCode == 13) search();}); */
	$("#searchProduct").click(function search(){
		searchProduct();
	});
	
	function searchProduct(){
		var cPage = $("#cPage").val();
		var saleCategory = $("#saleCategory").val();
		var searchKeyword = $("#searchKeyword").val();

		loadMyProductList(1);
	}
	
	/*내 상품 끌어올리기*/
	$(document).on("click","#btn-update",function(e){

		var confirmflag = confirm("끌어올리기를 하시겠습니까?");
		if(!confirmflag){
			return;
		}
		
		var btnUpdateTarget = $(e.target);
		var productNo = btnUpdateTarget.val();
		console.log(productNo);
		
		 $.ajax({
			url:"${pageContext.request.contextPath}/shop/productUpdate",
			data:{
				productNo:productNo
			},
			dataType:"json",
			type:"post",
			success: data=>{
				
				if(data==1){
					alert("끌어올리기 성공");
					loadMyProductList(1);
				}
				else{
					alert("끌어올리기 실패");
				}
			},
			error:(x,s,e)=>{
				console.log("실패",x,s,e);
			}
		});
	});
	
	/*내 상품 삭제하기*/
	$(document).on("click","#btn-delete",function(e){

		var confirmflag = confirm("상품삭제를 하시겠습니까?");
		if(!confirmflag){
			return;
		}
		
		var btnDeleteTarget = $(e.target);
		var productNo = btnDeleteTarget.val();
		console.log(productNo);
		
		  $.ajax({
			url:"${pageContext.request.contextPath}/shop/productDelete",
			data:{
				productNo:productNo
			},
			dataType:"json",
			type:"post",
			success: data=>{
				
				if(data==1){
					alert("상품이 정상적으로 삭제되었습니다.");
					loadMyProductList(1);
				}
				else{
					alert("상품삭제를 실패하였습니다.");
				}
			},
			error:(x,s,e)=>{
				console.log("실패",x,s,e);
			}
		});
	});
	
	/*상품판매상태변경*/
	$(document).on("change","#product-tbl .select",function(e){
			var $select = $(e.target); // Y판매완료 N판매중
			console.log($select.val());

			var productNo = $(e.target).parents("tr").find(".productNo").val() //productNo
			console.log(productNo);
			$.ajax({
				url : "${pageContext.request.contextPath}/shop/saleSelect",
				data:{
					productNo:productNo,
					select: $select.val()
				},
				dataType:"json",
				success: data=>{
					console.log(data);
					var select = $(".select").val();
					
					if(data==1){
						alert("상품 판매상태가 정상적으로 변경되었습니다.");
						loadMyProductList(1);
					}
					else{
						alert("상품 판매상태 변경이 실패하였습니다.");
					}
				},
				error: (a,b,c)=>{
				}

			});

		});		
});
</script>

<h1>상품관리</h1>
<div id="myProductManageDiv">
	<div class="col-md-6">
		<div class="input-group">
	      <select class="custom-select" id="saleCategory" required>
	     	<option value="">전체</option>
	     	<option value="N">판매중</option>
	     	<option value="I">거래중</option>
	     	<option value="Y">판매완료</option>
	      </select>
		  <input style="margin-left: 20px;" type="text" size="30" id="searchKeyword" placeholder="상품명을 입력하세요.">
		  <div class="input-group-append">
	      	<button style="margin-left: 20px;" class="btn btn-primary btn-sm" id="searchProduct">검색하기</button>
          </div>
	    </div>
	    <br />
    </div>

<table class="table text-center" id="product-tbl">
 
     
</table>
</div>
<div id="pageBar"></div>





















<jsp:include page="/WEB-INF/views/common/footer.jsp"/>