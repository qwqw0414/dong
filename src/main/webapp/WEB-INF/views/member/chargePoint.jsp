<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<script>
    $(function(){
        var IMP = window.IMP; // 생략가능
        IMP.init('imp29966768'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
        var msg;

        IMP.request_pay({
                    pg : 'kakaopay',
                    pay_method : 'card',
                    merchant_uid : 'merchant_' + new Date().getTime(),
                    name : '민호마켓',
                    amount : 15000,
                buyer_email : 'rhfpdk92@naver.com',
                buyer_name : '홍길동',
                buyer_tel : '01051213088',
                buyer_addr : '경기도수원',
                buyer_postcode : '123-456',
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

    });
   
</script>
</body>

<h1>포인트 충전</h1>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>