<%@page import="java.util.Map"%>
<%@page import="com.pro.dong.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/common/header.jsp" />
<%
	Member memberLoggedIn = (Member) request.getSession().getAttribute("memberLoggedIn");
	Map<String, Object> map = (Map<String, Object>) request.getAttribute("member");
%>

<h1 style="text-align: center;">마이페이지</h1>
<br>
<hr>
<br>
<div id="memberView">
	<div class="mv_content">
		<div class="row row-cols-2">
			<div class="col" id="col_left">
				<div class="mypage_shop">
					<div id="mypage_shop"
						class="mypage_con shadow p-3 mb-5 bg-white rounded">
						<h4>내 상점 	<img class="imgsrcs"
														src="${pageContext.request.contextPath}/resources/images/mysp.png" /> </h4>
						<br>
						<div class="ms_content">
							<div class="row">
								<div class="col-sm-4">
									<img id="shopImg1" class="img-thumbnail"
										src="${pageContext.request.contextPath}/resources/upload/shopImage/${member.IMAGE}"
										alt="" />
								</div>
								<div class="col-sm-8">
									<label for="">${member.MEMBER_ID }</label>님의 상점 <br> 상점이름
									: ${member.SHOP_NAME} <br /> 개설날짜 : ${member.OPEN_DATE} <input
										type="button" class="btn_val btn btn-outline-success btn-sm"
										value="내상점 가기" style="margin-left: 200px;"
										onclick="location.href='${pageContext.request.contextPath}/shop/shopView.do?memberId=<%=memberLoggedIn != null ? memberLoggedIn.getMemberId() : ""%>'">
								</div>
							</div>
						</div>
					</div>
					<div id="mypage_point"
						class="mypage_con shadow p-3 mb-5 bg-white rounded">
						<h4>내 포인트 <span><input type="button"
								class="" value="상세보기"
								id="godetails" style="font-size: 10px; padding: 0; background-color: transparent; border: 0; color: green; margin-left: 14px;	"
								onclick="location.href='${pageContext.request.contextPath}/member/memberChargingDetails.do'">
								</span>	</h4>
						<br>
						<div class="ms_content">
							<div class="row">
								<div class="col-sm-6" id="mypntdiv">
									<div class="card">
										<div class="card-body">
											<div>
												<small>보유 포인트 : </small><span id="memberPoint">${member.POINT}</span>P
											</div>
											<div id="chrgdiv">
												<input type="number" name="pointAmount" id="pointAmount"
													step="1000" min="5000" max="1000000" />&nbsp;
												<button class="btn btn-outline-warning btn-sm" id="chrgBtn"
													style="font-color: black;" onclick="chargePoint();">
													<img class="imgsrcs"
														src="${pageContext.request.contextPath}/resources/images/kkopay.png" />충전
												</button>
											</div>
										</div>
									</div>

								</div>
							</div>
							<div class="mypage_btn"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="col" id="col_right">
				<div id="mypage_info"
					class="mypage_con shadow p-3 mb-5 bg-white rounded">
					<h4>내정보 <img class="imgsrcs"
														src="${pageContext.request.contextPath}/resources/images/profile.png" /></h4>
					<br>
					<div class="ms_content">
						<div class="row row-cols-2">

							<div id="change_con">
								<div class="ms_change">
									<div class="before before_change1" style="display: block;">
										<small>이름: </small><span id="curname">${member.MEMBER_NAME}</span><input
											type="button" id="change_btn1" class="" value="수정"
											style="font-size: 4px; padding: 0; background-color: transparent; border: 0; color: gray; margin-left: 100px" />
									</div>
									<div class="after after_change1" style="display: none;">
										<small>이름: </small><input type="text" id="username"
											placeholder="변경할 이름" style="width: 120px; font-size: 10px">
										<button type="button" class="btn btn-outline-success btn-sm"
											id="button-addon1" class=""
											style="font-size: 4px; padding: 0; background-color: transparent; border: 0; color: gray;; margin-left: 24px">확인</button>
									</div>
								</div>
								<div id="ms_change">

									<div class="before before_change2" style="display: block;">
										<small>연락처: </small><span id="curphone">${member.PHONE}</span>
										<input type="button" id="change_btn2" value="수정" class=""
											style="font-size: 4px; padding: 0; background-color: transparent; border: 0; color: gray; margin-left: 36px" />
									</div>
									<div class="after after_change2" style="display: none;">
										<small>연락처: </small><input type="text" id="userphone"
											maxlength="11" placeholder=" 변경할 연락처 (-제외)"
											style="font-size: 8px">
										<button type="button" class="" id="button-addon2"
											style="font-size: 10px; padding: 0; background-color: transparent; border: 0; color: gray; margin-left: 14px">확인</button>
									</div>
								</div>
								<div class="ms_change">
									<div class="before before_change3" style="display: block;">
										<small>이메일: </small><span id="curemail">${member.EMAIL}</span>
										<input type="button" id="change_btn3"
											class="btn btn-outline-success btn-sm" value="수정"
											style="font-size: 10px; padding: 0; background-color: transparent; border: 0; color: gray;" />
									</div>

									<div class="after after_change3" style="display: none;">
										<input type="hidden" id="valid-email" value="0"> <small>이메일:
										</small><input type="email" id="useremail" name="useremail"
											placeholder="변경할 이메일" style="font-size: 8px">
										<button type="button" class="btn btn-outline-success btn-sm"
											id="button-addon3"
											style="font-size: 10px; padding: 0; background-color: transparent; border: 0; color: gray;">인증하기</button>
									</div>
									<div class="email_authKey" style="display: none">
										<input type="text" name="authKey" id="authKey"
											placeholder="인증번호를 입력해주세요." />
										<button type="button" class="btn btn-outline-success btn-sm"
											id="authCode-btn">확인</button>
									</div>
									<div class="emailMsg" style="font-size: 10px"></div>
								</div>
							</div>
							<div class="col">
								<p>성별 : ${member.GENDER=='M'?'남자':'여자' }</p>
								<p>생년월일: ${member.BIRTH }</p>
							</div>
						</div>
					</div>
				</div>
				<div id="mypage_location"
					class="mypage_con shadow p-3 mb-5 bg-white rounded">
					<h4>우리 동네 <img class="imgsrcs"
														src="${pageContext.request.contextPath}/resources/images/pin.png" /></h4>
					<br>
					<div class="ms_content">
						<p id="cureEmail">내 동네 : ${member.SIDO } ${member.SIGUNGU}
							${member.DONG}</p>

						<div class="mypage_btn_more">
							<!-- <input type="button" value="수정 바로가기" class="btn_val btn btn-outline-success btn-sm"> -->
							<button class="btn btn-outline-success btn-sm" id="updateAddress"
								data-toggle="modal" data-target="#addressModal">수정 바로가기</button>
						</div>

					</div>
				</div>

			</div>

		</div>

		<span class="byement">더이상 동네한바퀴를 이용하고 싶지 않다면 
			<a class="byelink" href="#" data-toggle="modal" data-target="#myModal">회원탈퇴<small>▶</small></a>
		</span>
		<div class="modal fade" id="myModal" role="dialog">
			<div class="modal-dialog">
				<!-- Modal content-->
				<div class="modal-content">
					<!--모달헤더 시작-->
					<div class="modal-header">
						<h5 class="modal-title">회원탈퇴</h5>
						<button type="button" class="close" data-dismiss="modal">×</button>
					</div>
					<!--모달헤더 끝-->
					<!--모달바디시작-->
					<div class="modal-body">
						<div class="container">
							<div style="text-align: center;" class="form-group">
								<form action="${pageContext.request.contextPath}/member/memberByeForm.do" method="post">
									<div class="bye-form">
        								<input type="password" id="password" name="password" placeholder="비밀번호를 입력하세요." class="form-control form-control-lg">
        								<input type="hidden" id="memberId" name="memberId" value="${memberLoggedIn.memberId}">
    								</div>
									<div class="modal-footer">
										<button type="submit" class="btn btn-danger btn-sm">탈퇴</button>
									</div>
								</form>
							</div>
						</div>
					</div>
					<!--모달바디끝-->
				</div>
			</div>
		</div>
	</div>
</div>

<div id="addressModel-wrapper">
	<div class="modal-body" id="AddressPage">
		<jsp:include page="/WEB-INF/views/member/updateAddress.jsp" />
	</div>
</div>


<script>
function insertPoint(){
	var pointAmount = $("#pointAmount").val();
	console.log(pointAmount);
	var memberId = "<%=memberLoggedIn.getMemberId()%>";
	console.log(memberId);
	$.ajax({
    	url: "${pageContext.request.contextPath}/member/updatePoint",
    	data: {pointAmount:pointAmount,
    		memberId:memberId},
    	type: "POST",
    	success: data=>{
    		console.log(data);
    		var pointUpdated = data.resultMap.POINT;
    		$("#memberPoint").text(pointUpdated);
    		console.log($("#pointAmount").val());
    		$("#pointAmount").val('0');
    		console.log($("#pointAmount").val());
    	},
    	error : (x, s, e) => {
			console.log("ajax 요청 실패!",x,s,e);
		}
    });//end of ajax
}

function chargePoint(){
	var IMP = window.IMP; // 생략가능
    IMP.init('imp29966768'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
    var msg;
    var pointAmount = $("#pointAmount").val();
    var email = "${member.EMAIL}";
    var name = "${member.MEMBER_NAME}";
    var phone = "${member.PHONE}";
    var addr = "${member.SIDO}"+"${member.SIGUNGU}"+"${member.DONG}";
    var postcode = '123-456';
    console.log(email);
    console.log(name);
    console.log(phone);
    console.log(addr);
    console.log(postcode);

    IMP.request_pay({
        pg : 'kakaopay',
        pay_method : 'card',
        merchant_uid : 'merchant_' + new Date().getTime(),
        name : '동네한바퀴 포인트충전',
        amount : pointAmount,
	    buyer_email : email,
	    buyer_name : name,
	    buyer_tel : phone,
	    buyer_addr : addr,
	    buyer_postcode : postcode,
}, function(rsp) {
	console.log(rsp);
	if ( rsp.success ) {
		 msg = '결제가 완료되었습니다.';
         msg += '\n고유ID : ' + rsp.imp_uid;
         msg += '\n상점 거래ID : ' + rsp.merchant_uid;
         msg += '\결제 금액 : ' + rsp.paid_amount;
         msg += '카드 승인번호 : ' + rsp.apply_num;
         alert(msg);
		 insertPoint();
	  /*    $.ajax({
	        url: "", // url
	        type: 'POST',
	        dataType: 'json',
	        data: {imp_uid : rsp.imp_uid},
	        error:(a,b,c)=>{
	        	console.log(a,b,c);
	        }
	    }).done(function(data) {
	    	console.log(data); 
	        //[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
	        if ( everythings_fine ) {
	            msg = '결제가 완료되었습니다.';
	            msg += '\n고유ID : ' + rsp.imp_uid;
	            msg += '\n상점 거래ID : ' + rsp.merchant_uid;
	            msg += '\결제 금액 : ' + rsp.paid_amount;
	            msg += '카드 승인번호 : ' + rsp.apply_num;
	            alert(msg);
	           // insertPoint();
	        } else {
	        	alert("충전오류");
	        }
	     }); 
	    //성공시 이동할 페이지 */
	    
	} else {
	    msg = '결제에 실패하였습니다.';
	    msg += '에러내용 : ' + rsp.error_msg;
	    alert(msg);
	    //실패시 이동할 페이지
	    
	}
});
    
}//end of chargePoint

    $(() => {

    	
    	$()
    	
        //수정 버튼 누를시 태그변환
        $("#memberView #change_btn1").on('click', function () {
            $("#memberView .before_change1").css("display", "none");
            $("#memberView .after_change1").css("display", "block")
        });
        $("#memberView #change_btn2").on('click', function () {
            $("#memberView .before_change2").css("display", "none");
            $("#memberView .after_change2").css("display", "block")
        });
        $("#memberView #change_btn3").on('click', function () {
            $("#memberView .before_change3").css("display", "none");
            $("#memberView .after_change3").css("display", "block")
        });

        
        
        
        
        
        //이름 변경
        $("#memberView #button-addon1").on('click', function () {
            var afterName = $("#username").val();
            console.log(afterName);
            var regExp = /^[가-힣]{2,5}$/;

            if(!regExp.test(afterName)){
            alert("잘못된 이름입니다")
            return;
        }

            $.ajax({
                url: "${pageContext.request.contextPath}/member/updateMemberName",
                data: { afterName: afterName },
                type: "POST",
                success: data => {
                    console.log(data);
                    $("#curname").text(data.MEMBER_NAME)
                    $("#memberView .before_change1").css("display", "block");
                    $("#memberView .after_change1").css("display", "none")
                },
                error: (x, s, e) => {
                    console.log(x, s, e);
                }
            });
        });//end of updatename

        //연락처
        $("#memberView #button-addon2").on('click', function () {
            var afterPhone = $("#userphone").val();
            console.log(afterPhone);

            regExp = /01{1}[016789]{1}[0-9]{7,8}/;
            if(!regExp.test(afterPhone)){
            alert("잘못된 번호")
            return;
        }
            

            $.ajax({
                url: "${pageContext.request.contextPath}/member/updateMemberPhone",
                data: { afterPhone: afterPhone },
                type: "POST",
                success: data => {
                    console.log(data);
                    $("#curphone").text(data.PHONE)
                    $("#memberView .before_change2").css("display", "block");
                    $("#memberView .after_change2").css("display", "none")
                },
                error: (x, s, e) => {
                    console.log(x, s, e);
                }
            });
        });//end of updatephone

//----------------------------------------------------근호
		//메일보내기
        $("#memberView #button-addon3").on('click', function () {
        	var $validEmail = $("#valid-email");
            var email = $("#useremail").val();
            console.log(email);
            
            /* 이메일 중복검사 */
    		 $.ajax({
    			url: "${pageContext.request.contextPath}/member/emailDuplicate",
    			data:{email: email},
    			dataType: "json",
    			success: data =>{
    				console.log(data);
    				if(data == 0){
    					$validEmail.val(1); 
    					alert("인증번호를 보냈습니다.");
    					
    					$.ajax({
    		                url: "${pageContext.request.contextPath}/member/emailAuth.do",
    		                data: { email: email },
    		                type: "POST",
    		                success: data => {
    							$(".after_change3").css("display","none");
    							$(".email_authKey").css("display","block");
    		                },
    		                error: (x, s, e) => {
    		                    console.log(x, s, e);
    		                }
    		            }); 
    				}
    				else{
    					$validEmail.val(0);
    					$(".emailMsg").text("중복된 이메일").css("color","red");
    				}
    			},
    			error : (x,s,e) =>{
    				console.log("실패",x,s,e);
    			}
    		}) 
        });
        
        //메일인증확인
        $("#memberView #authCode-btn").on('click', function(){
        	var authKey = $("#authKey").val();
        	var email = $("#useremail").val();
        	
        	$.ajax({
        		url: "${pageContext.request.contextPath}/member/emailUpdate",
        		data: {authKey:authKey,
        			  email:email},
        		type: "POST",
        		success: data =>{
        			console.log(data);
        			console.log(data.email);
        			console.log(authKey);
        			if(data.result == 1){
        				$("#curemail").text(data.email);
        				$("#memberView .before_change3").css("display", "block");
        				$(".email_authKey").css("display","none");
        				$(".emailMsg").css("display","none");
        			}
        			else if(data.result != 1){
        				$(".email_authKey").css("display","block");
        				$(".emailMsg").text("인증번호 틀림").css("color","red");
        			}
        		},
        		 error: (x, s, e) => {
                     console.log(x, s, e);
                 }
        	});
        });
//----------------------------------------------------------------근호 끝
   });//end of script      


</script>







<style>


#memberView .byement {
	font-size: 10px;
	margin-left: 900px;
}

#memberView .byelink {
	color: green;
	font-size: 10px;
}

#memberView .mypage_btn_more {	
	margin-left: 380px;
}

#memberView .mypage_btn {
	margin-left: 300px;
}

#memberView .after {
	padding-top: 15px;
	padding-bottom: 15px;
}

#memberView .before {
	padding-top: 15px;
	padding-bottom: 15px;
}

#memberView .after_change1 {
	width: 280px;
	height: 30px;
}

#memberView .before_change3 {
	padding-top: 5px !important;
	padding-bottom: 5px !important;
}

#memberView .after_change3 {
	padding-top: 5px !important;
	padding-bottom: 5px !important;
}

#memberView .imgsrcs {
	width: 20px;
	height: 20px;
}

#memberView .mypage_con {
	background: #f3f3f3;
	border: 1px solid #dedede;
	width: 540px;
	height: 250px;
	margin-top: 30px;
	margin-bottom: 120px;
	padding: 15px;
	box-shadow: 0px 0px 1px 0 rgba(0, 0, 0, 0.2);
	position: relative;
	box-sizing: border-box;
}

#memberView #godetails {
	margin-top: 15px;
	margin-left: 380px;
}

#memberView .btn_val {
	margin-top: 30px;
}

#memberView .btn_val_update {
	margin-top: 20px;
}

#memberView .col {
	width: 560px;
}

#memberView #col_right {
	padding-left: 30px;
}

#memberView .ms_change {
	width: 280px;
	height: 30px;
	display: inline-block;
}

#memberView #change_con {
	padding-left: 20px;
}

#memberView #mypntdiv {
	margin-left: 120px;
}

#memberView #chrgdiv {
	margin-top: 15px;
}
#memberView #chrgBtn{
	margin-left: 15px;
}
#memberView #cureEmail{
	margin-top:30px;
}
</style>





<jsp:include page="/WEB-INF/views/common/footer.jsp" />