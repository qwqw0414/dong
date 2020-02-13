<%@page import="com.pro.dong.product.model.vo.Product"%>
<%@page import="com.pro.dong.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<%
	Member memberLoggedIn = (Member)request.getSession().getAttribute("memberLoggedIn");
%>
<h1>상품 상세보기</h1>
<hr>
<style>
#productView #photo img{position: absolute;}
</style>
<div class="card mb-3 border-light" id="productView">
    <div class="row">
		<div class="col-4" id="photo">
		<c:forEach items="${map.attachment}" var="attch">
  		  <img src="${pageContext.request.contextPath}/resources/upload/product/${attch.photo}" alt="">
		</c:forEach>
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
    <br /><br />
    
    <!-- 댓글 DIV-->
    <div class="pncontents">
	<input type="hidden" id="productNo" name="productNo" value="${map.product.productNo}" >
	</div>
	<input type="hidden" name="memberLoggedIn" value="<%= memberLoggedIn.getMemberId()%>"/>
	<div id="commentInsertView">
		<div class="input-group mb-3">
			<input type="text" class="form-control" id="comments_product"
				placeholder="댓글을 입력해 주세요">
			<div class="input-group-append">
				<button class="btn btn-outline-secondary" type="button"
					id="comments_insert">등록</button>
			</div>
		</div>
		<br />
		<h5>상품문의</h5>
		<hr />
		<br />
		<div id="commentListView"></div>
	</div>
	<div id="pageBar"></div>


	<script>
	$(()=>{
		showCommentList(1);
		//댓글등록
		$("#commentInsertView #comments_insert").on('click',function(){
			var productNo = $(".pncontents #productNo").val();    //보드넘버 바꾸면서 테스트 하면댐
			var contents = $("#comments_product").val();
			var memberId = $("[name=memberLoggedIn]").val();
			var commentLevel=1;
			$.ajax({
				url: "${pageContext.request.contextPath}/product/insertComments",
				data:{contents:contents,
					productNo:productNo,
					  memberId:memberId,
					  commentLevel:commentLevel},
				type:"POST",
				success:data=>{
					console.log(data);
						if(data=="1"){
							alert("성공 니 댓글 맨뒤에~");
						}
						else{
							alert("실패")
						}
						$("#comments_product").val("");
						showCommentList(1);
				},
				 error : (x,s,e) =>{
				        console.log("실패",x,s,e);
				      }
			});//end of ajax
		});//end of function
	});//end of onload
	
	
	
	
	
	
	function showCommentList(cPage){
	//댓글 조회
	var productNo = $(".pncontents #productNo").val();
	$.ajax({
		url: "${pageContext.request.contextPath}/product/selectProductComment",
		data:{productNo:productNo,
		      cPage:cPage},
		type:"GET",
		dataType:"json",
		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		success:data=>{
			console.log(data);
			let html="";
			html+="<div id='listdiv'>";
		for(var i=0; i<data.list.length;i++){
				html+="<div class='testas'>";
				if(data.list[i].COMMENT_LEVEL=="1"){
				html+="<input type='hidden' value="+data.list[i].COMMENT_NO+" id='commentNo_'/>";
				html+="<span style='margin-bottom:0px'><strong>"+data.list[i].MEMBER_ID+ ":</strong> "+data.list[i].CONTENTS+" <small>[" + data.list[i].WRITE_DAY+"]</small></span>";
				html+="<button id='showLevel2form' class='alcls btn btn-outline-success btn-sm' onclick='showLevel2form(this)'><img  src='https://assets.bunjang.co.kr/bunny_desktop/images/reply@2x.png' width='17' height='17'>답글</button>";
					//내가쓴 level1댓글에만 삭제버튼 생성	
					if($("[name=memberLoggedIn]").val()==data.list[i].MEMBER_ID){
					html+="<button class='btn btn-outline-success btn-sm' id='deleteLevel1' onclick='deleteLevel1(this)'><img src='https://assets.bunjang.co.kr/bunny_desktop/images/trash-sm@2x.png' width='15' height='17'></button>";
					}
					//ㅋㅋㅋㅋㅋㅋㅋㅋㅋ
					else{
						html+="<button id='fakebutton'>채우기용</button>";	
					}
					

				}
				
				else{
					
					if($("[name=memberLoggedIn]").val()==data.list[i].MEMBER_ID){
						html+="<div>"
						html+="<input type='hidden' value="+data.list[i].COMMENT_NO+" id='commentNo_'/>"
						html+="<img class='replyIcon' style='width:50px; height:50px;' src='${pageContext.request.contextPath}/resources/images/reply.PNG'/>"
						html+="<span style='margin-bottom:0px; padding-left:30px'><strong>"+data.list[i].MEMBER_ID+ "</strong> : " + data.list[i].CONTENTS + " <small>[ " +data.list[i].WRITE_DAY + "]</small>";
						html+="<button class='alcls btn btn-outline-success btn-sm' onclick='deleteLevel2(this);'><img src='https://assets.bunjang.co.kr/bunny_desktop/images/trash-sm@2x.png' width='10' height='10'></button></span></div>";
					}else{
						html+="<div><img class='replyIcon' style='width:50px; height:50px;' src='${pageContext.request.contextPath}/resources/images/reply.PNG'/>"
						html+="<span style='margin-bottom:0px; padding-left:30px'><strong>"+data.list[i].MEMBER_ID+ "</strong> : " + data.list[i].CONTENTS + " <small>[ " +data.list[i].WRITE_DAY + "]</small></span></div>";
					}
				}
				html+="<div id='level2Form'>";
				html+="<input type='text' id='level2CommentContent' placeholder='대댓글을 입력하세요.'>";
				html+="<button onclick='insertLevel2(this)'>등록</button><button onclick='hideLevel2form(this)'>취소</button><br>";
				html+="</div>";
				html+="</div>";
				
			};//end of forEach
			html+="</div>";
			$("#commentListView").html(html);
            $("#pageBar").html(data.pageBar);
		},//end of success
		 error : (x,s,e) =>{
		        console.log("실패",x,s,e);
		      },
		      complete: ()=>{
	                $("#pageBar a").click((e)=>{
	                	showCommentList($(e.target).siblings("input").val());
	                });
	            }
		});//end of ajax
	}
	//댓글 삭제
	function deleteLevel1(e){
	var commentNo= $(e).prev().prev().prev().val();
	var productNo = $(".pncontents #productNo").val();
	console.log(commentNo);
	$.ajax({
		url:"${pageContext.request.contextPath}/product/deleteLevel1",
		data:{commentNo:commentNo,
			productNo:productNo},
		type:"POST",
		success:data=>{
			console.log(data);
			showCommentList(1);
		},
		 error : (x,s,e) =>{
		        console.log("실패",x,s,e);
		}
	});//end of ajax
	};//end of function
	
	
	//대댓글 등록
	function insertLevel2(e){
		var productNo = $(".pncontents #productNo").val();
		var level2Content = $(e).prev().val();
		var memberId = $("[name=memberLoggedIn]").val();
		var commentLevel=2;
		var commentRef=$(e).parent().parent().children("input").val();
		$.ajax({
			url:"${pageContext.request.contextPath}/product/insertLevel2",
			data:{commentLevel:commentLevel,
				productNo:productNo,
				contents:level2Content,
				memberId:memberId,
				commentRef:commentRef,
				},
				type:"POST",
				success:data=>{
						console.log(data);
						if(data=="1"){
								alert("성공");
						}
						else{
							alert("실패");
						}
						showCommentList(1);
				},//end of success,
				 error : (x,s,e) =>{
				        console.log("실패",x,s,e);
				}//end of error
		})//end of ajax
	}//end of function
	
	
	
	//대댓삭제
	function deleteLevel2(e){
		var commentNo=$(e).parent().parent().children("input").val();
		$.ajax({
			url:"${pageContext.request.contextPath}/product/deleteLevel2",
			data:{commentNo:commentNo},
			type:"POST",
			success:data=>{
				console.log(data);
				if(data=="1"){
					alert("성공");
			}
			else{
				alert("실패");
			}
				showCommentList(1);
		},//end of success,
		 error : (x,s,e) =>{
		        console.log("실패",x,s,e);
		}//end of error
			
		})//end of ajax
		
	
	}
	
	
	
	
	
	
	
	//대댓글 등록창 보이기
	function showLevel2form(e){
// 		$("#level2Form").css("display","block");
		$(e).next().next().css("display","block");
	}
	//대댓글 등록창 숨기기
	function hideLevel2form(e){
		$(e).parent().css("display","none");
	}
	



</script>

<style>
.alcls{ 
 		margin-left:30px;
	} 
	
	#fakebutton{
		visibility:hidden;
	}
#commentListView #level2Form {
	display: none;
}
#level2Form #level2CommentContent {
	width:1000px;
}
#listdiv .testas{
margin-bottom:20px;
}
</style>











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