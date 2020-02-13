<%@page import="com.pro.dong.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<%
	Member memberLoggedIn = (Member)request.getSession().getAttribute("memberLoggedIn");
%>
<style>
td{
	padding-top: 75px !important;
}
#img-td{
	padding-top: 8px !important;
}
#btn-td{
	padding-top:39px !important;
}
select{
    width: 110px !important;
}
</style>
<script>
$(()=>{
	
	loadMyProductList(1);
	
	/*내 상품 list 뿌려주기*/
	function loadMyProductList(cPage){
		
		var memberId = '${memberLoggedIn.getMemberId()}';
		
		$.ajax({
			url:"${pageContext.request.contextPath}/shop/loadMyProduct",
			contentType: "application/json; charset=utf-8",
			data:{
				memberId:memberId,
				cPage:cPage
			},
			dataType:"json",
			success:data=>{
				
				console.log(data);
				
				let $table = $("#product-tbl");
				let header = "<thead><tr><th scope='col'>사진</th><th scope='col'>판매상태</th><th scope='col'>상품명</th><th scope='col'>가격</th><th scope='col'>최근수정일</th><th scope='col'>기능</th></tr></thead>";
				$table.html("");
				
				let html = "";
				data.product.forEach(product=>{
					html += "<tr>";
					html +=	"<tbody>";
					html += "<td id='img-td'><img style='width:152px; height:152px;' src='${pageContext.request.contextPath}/resources/upload/product/"+product.PHOTO+"'/></td>";
					html += "<td><select class='select' class='custom-select'><option ' value='N' selected>판매중</option><option value='Y'>판매완료</option></select></td>"
					html += "<input type='hidden' class='productNo' value='"+product.PRODUCT_NO+"'/>"
					html += "<td>"+product.TITLE+"</td>";
					html += "<td>"+numberComma(product.PRICE)+"원</td>";
					html += "<td>"+product.REG_DATE+"</td>";
					html += "<td id='btn-td'><button type='button' class='btn btn-outline-success btn-sm' id='btn-update' value='"+product.PRODUCT_NO+"' style='width: 45px;'>UP</button><br/>";
			      	html += "<button type='button' class='btn btn-outline-primary btn-sm'>수정</button><br/>"
			      	html += "<button type='button' class='btn btn-outline-danger btn-sm' id='btn-delete' value='"+product.PRODUCT_NO+"'>삭제</button></td>";
					html += "</tbody>";
					html += "</tr>";
					
				});
				
				$table.append(header+html);
				$("#pageBar").html(data.pageBar);
			},
			error:(x,s,e)=>{
				console.log("실패",x,s,e);
			},
			complete:(data)=>{
				$("#pageBar a").click((e)=>{
					loadMyProductList($(e.target).siblings("input").val());
	            });
				saleSelect();
			}
			
		});
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
					location.reload();
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

	function saleSelect(){

		$("#product-tbl .select").change((e)=>{
			var $select = $(e.target); // Y판매완료 N판매중
			console.log($select.val());

			var productNo = $(e.target).parents("tr").find(".productNo").val() //productNo

			$.ajax({
				url : "",
				data:{
					productNo:productNo,
					select: $select.val()
				},
				dataType:"json",
				success: data=>{

				},
				error: (a,b,c)=>{
				}

			})

		})
	}

	
	/*내 상품 판매상태 변경하기*/
	$(document).on("change",".sel2ect",function(e){
		
		/* var state = $(e).("#select option:selected").prop("id");
		console.log(state); */
		/* var state = $(e.target); */
		/* var state = $("#select option:selected");
		
		var stateId = e.$("#select option:selected");
		console.log(stateId);
		
		var optionId = stateId.prop("id");
		console.log(optionId);
		
		
		var saleTarget = $(e.target);
		var productNo = saleTarget.val();
		console.log(productNo);				 */
		
		
		
		
		var state = $(e.target).val();
		console.log(state);
		
		
		var inputTarget = $(e.target);
		var productNo = $("[name=productNo]").val();
		console.log(productNo);
		
		/* var optionId = state.prop("id");
		console.log(state.prop("id")); */
		
		
		
		
		  /* $.ajax({
			url:"${pageContext.request.contextPath}/shop/productDelete",
			data:{
				productNo:productNo
			},
			dataType:"json",
			type:"post",
			success: data=>{
				
				if(data==1){
					alert("상품이 정상적으로 삭제되었습니다.");
					location.reload();
				}
				else{
					alert("상품삭제를 실패하였습니다.");
				}
			},
			error:(x,s,e)=>{
				console.log("실패",x,s,e);
			}
		}); */
	});
	
});
</script>

<h1>상품관리</h1>

<table class="table text-center" id="product-tbl">
 
     
</table>

<div id="pageBar"></div>





















<jsp:include page="/WEB-INF/views/common/footer.jsp"/>