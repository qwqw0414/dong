<%@page import="java.util.Map"%>
<%@page import="com.pro.dong.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<%
	Member memberLoggedIn = (Member)request.getSession().getAttribute("memberLoggedIn");
	Map<String, String> map = (Map<String,String>)request.getAttribute("map");
	
%>
<script>
function test1(){
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
    		var pointUpdated = data.POINT;
    		$("#memberPoint").val(pointUpdated);
    	},
    	error : (x, s, e) => {
			console.log("ajax 요청 실패!");
		}
    });//end of ajax
}


function chargePoint(){
	var IMP = window.IMP; // 생략가능
    IMP.init('imp29966768'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
    var msg;
    var pointAmount = $("#pointAmount").val();
    var email = "testing1@naver.com";
    var name = "<%=map.get("MEMBER_NAME")%>";
    var phone = "<%=map.get("PHONE")%>";
    var addr = "<%=map.get("SIDO")%>"+"<%=map.get("SIGUNGU")%>"+"<%=map.get("DONG")%>";
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
        name : '민호마켓',
        amount : pointAmount,
    buyer_email : email,
    buyer_name : name,
    buyer_tel : phone,
    buyer_addr : addr,
    buyer_postcode : postcode,
//m_redirect_url : 'http://www.naver.com'
}, function(rsp) {
if ( rsp.success ) {

    jQuery.ajax({
        url: "", // url
        type: 'POST',
        dataType: 'json',
        data: {
            imp_uid : rsp.imp_uid
            //기타 필요한 데이터가 있으면 추가 전달
        }
    }).done(function(data) {
        //[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
        if ( everythings_fine ) {
            msg = '결제가 완료되었습니다.';
            msg += '\n고유ID : ' + rsp.imp_uid;
            msg += '\n상점 거래ID : ' + rsp.merchant_uid;
            msg += '\결제 금액 : ' + rsp.paid_amount;
            msg += '카드 승인번호 : ' + rsp.apply_num;

            alert(msg);
            
        } else {
        }
    });
    //성공시 이동할 페이지
    //ex)
    //location.href='<%=request.getContextPath()%>/order/paySuccess?msg='+msg;
} else {
    msg = '결제에 실패하였습니다.';
    msg += '에러내용 : ' + rsp.error_msg;
    //실패시 이동할 페이지
    //location.href="<%=request.getContextPath()%>/order/payFail";
    alert(msg);
}
});
    
}
</script>
</body>

<h1>포인트 충전</h1>
<div class="row">
  <div class="col-sm-6">
    <div class="card">
      <div class="card-body">
        <h5 class="card-title">${memberLoggedIn.memberName }(${memberLoggedIn.memberId })님의 포인트 현황</h5>
        <input class="card-text" id="memberPoint" value="${map.POINT }" readonly/>점<br>
        <input type="number" name="pointAmount" id="pointAmount" min="0" max="100000"/>&nbsp;<button class="btn btn-warning" onclick="chargePoint();">충전하기</button>
      </div>
    </div>
  </div>
 </div>
<button onclick="test1();">포인트 충전 실험</button>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>