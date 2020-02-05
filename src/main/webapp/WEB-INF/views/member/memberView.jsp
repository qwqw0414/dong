<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />



<h1 style="text-align: center;">마이페이지</h1><br>
<hr>
<br>


<div id="memberView">
    <div class="mv_content">
        <div class="row row-cols-2">

            <div class="col" id="col_left">
                <div class="mypage_shop">
                    <div id="mypage_shop" class="mypage_con shadow p-3 mb-5 bg-white rounded">
                        <h4>내 상점</h4><br>
                        <div class="ms_content">
                            <div class="row">
                                <div class="col-sm-4"> <img
                                        src="https://static.nid.naver.com/images/web/user/default.png" width="80"
                                        height="80" alt="" dispaly="block"></div>
                                <div class="col-sm-8">
                                    <label for="">${member.MEMBER_ID }</label>님의 상점
                                    <br>
                                    상점이름 : ${member.SHOP_NAME} <br />
                                    개설날짜 : ${member.OPEN_DATE} </div>
                            </div>
                            <div class="mypage_btn_more">
                                <input type="button" class="btn_val btn btn-outline-success btn-sm" value="수정 바로가기">
                            </div>
                        </div>





                    </div>
                    <div id="mypage_point" class="mypage_con shadow p-3 mb-5 bg-white rounded">
                        <h4>내 포인트</h4><br>
                        <div class="ms_content">
                            <p>보유 포인트 : ${member.POINT}P</p>

                            <div class="mypage_btn">
                                <input type="button" class="btn_val btn btn-outline-success btn-sm" value="충전">
                                <input type="button" class="btn_val btn btn-outline-success btn-sm" value="환불">
                                <input type="button" class="btn_val btn btn-outline-success btn-sm" value="내역보기">
                            </div>
                        </div>


                    </div>

                </div>
            </div>


            <div class="col" id="col_right">
                <div id="mypage_info" class="mypage_con shadow p-3 mb-5 bg-white rounded">
                    <h4>내정보</h4><br>
                    <div class="ms_content">
                        <div class="row row-cols-2">

                            <div id="change_con">
                                <div class="ms_change">
                                    <div class="before before_change1" style="display: block;">
                                        이름:<span id="curname">${member.MEMBER_NAME}</span> <input type="button"
                                            id="change_btn1" class="btn btn-outline-success btn-sm" value="수정" />
                                    </div>
                                    <div class="after after_change1" style="display: none;">
                                        <input type="text" id="username" placeholder="변경할 이름 입력">
                                        <button type="button" class="btn btn-outline-success btn-sm" id="button-addon1"
                                            class="btn btn-outline-success btn-sm">확인</button>
                                    </div>
                                </div>

                                <div id="ms_change">

                                    <div class="before before_change2" style="display: block;">
                                        연락처:<span id="curphone">${member.PHONE}</span> <input type="button"
                                            id="change_btn2" value="수정" class="btn btn-outline-success btn-sm" />
                                    </div>

                                    <div class="after after_change2" style="display: none;">
                                        <input type="text" id="userphone" maxlength="11"
                                            placeholder=" 변경할 연락처 입력 (-제외)">
                                        <button type="button" class="btn btn-outline-success btn-sm"
                                            id="button-addon2">확인</button>
                                    </div>

                                </div>



                                <div class="ms_change">
                                    <div class="before before_change3" style="display: block;">
                                        이메일:<span id="curemail">${member.EMAIL}</span> <input type="button"
                                            id="change_btn3" class="btn btn-outline-success btn-sm" value="수정" />
                                    </div>

                                    <div class="after after_change3" style="display: none;">
                                        <input type="email" id="useremail" placeholder="변경할 이메일 입력">
                                        <button type="button" class="btn btn-outline-success btn-sm"
                                            id="button-addon3">확인</button>
                                    </div>
                                </div>
                            </div>





                            <div class="col">
                                <p>성별 : ${member.GENDER=='M'?'남자':'여자' }</p>
                                <p>생년월일: ${member.BIRTH }</p>
                            </div>
                        </div>



                    </div>

                </div>

                <div id="mypage_location" class="mypage_con shadow p-3 mb-5 bg-white rounded">
                    <h4>우리 동네</h4><br>
                    <div class="ms_content">
                        <p>내 동네 : ${member.SIDO } ${member.SIGUNGU} ${member.DONG}</p>


                        <div class="mypage_btn_more">

                            <input type="button" value="수정 바로가기" class="btn_val btn btn-outline-success btn-sm">
                        </div>

                    </div>
                </div>

            </div>


        </div>



    </div>
</div>



<script>

    $(() => {

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
        });




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
        });

        //이메일
        $("#memberView #button-addon3").on('click', function () {
            var afterEmail = $("#useremail").val();
            console.log(afterEmail);

            $.ajax({
                url: "${pageContext.request.contextPath}/member/updateMemberEmail",
                data: { afterEmail: afterEmail },
                type: "POST",
                success: data => {
                    console.log(data);
                    $("#curemail").text(data.EMAIL)
                    $("#memberView .before_change3").css("display", "block");
                    $("#memberView .after_change3").css("display", "none")
                },
                error: (x, s, e) => {
                    console.log(x, s, e);
                }
            });
        });


    })





</script>







<style>
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




    .mypage_con {
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

 





    .btn_val {
        margin-top: 30px;
    }

    .btn_val_update {
        margin-top: 20px;
    }

    .col {
        width: 560px;
    }

    #col_right {
        padding-left: 30px;
    }

    .ms_change {
        width: 280px;
        height: 30px;
        display: inline-block;

    }

    #change_con {
        padding-left: 20px;
    }
</style>





<jsp:include page="/WEB-INF/views/common/footer.jsp" />