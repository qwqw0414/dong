<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<style>
#memberEnroll .enroll-form{width: 450px; height: 360px; margin: auto; margin-top: 50px}
#memberEnroll .enroll-form input{margin-top: 40px;}
#memberEnroll .enroll-form select{margin-top: 40px;}
#memberEnroll h1{font-weight: bolder;}
#memberEnroll .enroll-btn{margin-top: 0px;}
#memberEnroll .enroll-btn button{width: 180px;}
#memberEnroll .enroll-btn .btn-pre{position: relative; left: -44px;}
#memberEnroll .enroll-btn .btn-next{position: relative; left: 44px;}
#memberEnroll #msg{font-size: 1.6em; margin-top: 40px; height: 60px;}
#memberEnroll #page-2{display: none;}
#memberEnroll #btn-2{display: none;}
#memberEnroll #page-2{margin-top: -20px; margin-bottom: 30px;}
</style>

<div id="memberEnroll" class="text-center">

    <h1>회원가입을 진행합니다.</h1>
    <div id="msg"></div>

    <div class="enroll-form" id="page-1">
        <input type="hidden" id="valid-Id" value="0">
        <input type="text" id="memberId" placeholder="사용할 아이디를 입력해주세요." class="form-control form-control-lg" maxlength="14">
        <input type="password" id="password" placeholder="비밀번호를 입력해주세요." class="form-control form-control-lg" maxlength="16">
        <input type="password" id="password-check" placeholder="비밀번호를 한번 더 입력해주세요." class="form-control form-control-lg" maxlength="16">
    </div>

    <div class="enroll-form" id="page-2">
        <input type="text" id="memberName" placeholder="성명을 입력해주세요." class="form-control form-control-lg" maxlength="8">
        <select id="gender" class="form-control form-control-lg">
            <option value="" disabled hidden selected>성별을 선택해주세요.</option>
            <option value="M">남</option>
            <option value="F">여</option>
        </select>
        <input type="text" id="birth" placeholder="생년월일을 입력해주세요." class="form-control form-control-lg" maxlength="8">
        <input type="text" id="phone" placeholder="연락처를 입력해주세요." class="form-control form-control-lg" maxlength="8">
        
    </div>

    <div class="enroll-btn" id="btn-1">
        <button class="btn btn-outline-primary btn-lg btn-pre" id="btn-cancel">가입 취소</button>
        <button class="btn btn-outline-primary btn-lg btn-next" id="next-page2">다음 단계</button>
    </div>

    <div class="enroll-btn" id="btn-2">
        <button class="btn btn-outline-primary btn-lg btn-pre" id="pre-page1">이전 단계</button>
        <button class="btn btn-outline-primary btn-lg btn-next" id="next-page3">다음 단계</button>
    </div>
</div>

<script>
$(()=>{
    var $page_1 = $("#memberEnroll #page-1");
    var $page_2 = $("#memberEnroll #page-2");
    var $btn_1 = $("#memberEnroll #btn-1");
    var $btn_2 = $("#memberEnroll #btn-2");

    var $msg = $("#memberEnroll #msg");
    var $memberId = $("#memberEnroll #memberId");
    var $validId = $("#memberEnroll #valid-Id");
    var $password = $("#memberEnroll #password");
    var $passwordChk = $("#memberEnroll #password-check");
    
    var memberId;
    var password;

    //페이지 전환
    $("#memberEnroll #next-page2").click(()=>{
        $page_1.hide();
        $btn_1.hide();
        $page_2.show();
        $btn_2.show();
        changeMsg("step2");
        return;

        if($validId.val() != 1){
            changeMsg("check_id",'f');
            changeForm($memberId,'f');
            $memberId.focus();
            return;
        }

        var regExp = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g;
        if(!regExp.test($password.val())){
            changeMsg("check_password",'f');
            changeForm($password,'f');
            $password.focus();
            return;
        }

        if($passwordChk.val() !== $password.val()){
            changeMsg("check_passwordChk",'f');
            changeForm($passwordChk,'f');
            $passwordChk.focus();
            return;
        }


    });

    $("#pre-page1").click(()=>{prePage(1)});
    $("#pre-page2").click(()=>{prePage(2)});
    $("#pre-page3").click(()=>{prePage(3)});

    function prePage(page){
        $("#page-"+page).show();
        $("#page-"+(page+1)).hide();
        $("#btn-"+page).show();
        $("#btn-"+(page+1)).hide();
    }

    // 아이디 유효성 검사
    $memberId.keyup((e)=>{
        var regExp = /^[a-z][a-z\d]{5,14}$/;

        if($validId.val() == 1 && e.keyCode == 13){
            $password.focus();
            changeForm($memberId,'t');
            return;
        }

        // 유효성 검사
        if(!regExp.test($memberId.val()) && e.keyCode == 13){
            changeMsg("check_id",'f');
            $validId.val(0);
            changeForm($memberId,'f');
            return;
        }
        
        if(!regExp.test($memberId.val())){
            $validId.val(0);
            changeMsg("check_id");
            changeForm($memberId);
            return;   
        } 

        // 중복 검사
        $.ajax({
            url: "${pageContext.request.contextPath}/member/idDuplicate",
            data: {memberId:$memberId.val()},
            dataType: "json",
            success : data =>{
                if(data == 0){
                    $validId.val(1);
                    changeMsg("valid_id",'t');
                    changeForm($memberId,'t');
                }
                else{
                    $validId.val(0);
                    changeMsg("invalid_id",'f');
                }
            },
            error : (x,s,e) =>{
                console.log("실패",x,s,e);
            }
        })
    });

    //비밀번호 유효성 검사
    $password.keyup((e)=>{
        var regExp = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g;
        
        if(regExp.test($password.val())){
            changeMsg("valid_password",'t');
            changeForm($password,'t');
        }
        else{
            changeMsg("check_password");
            changeForm($password);
        }
        if(e.keyCode == 13){
            $passwordChk.focus();
        }
    });

    $passwordChk.keyup((e)=>{

        if($password.val() === $passwordChk.val()){
            changeMsg("valid_passwordChk",'t');
            changeForm($passwordChk,'t');
        }else{
            changeMsg("check_passwordChk");
            changeForm($passwordChk);
        }
        

    });


    // 가입 취소 버튼 액션
    $("#btn-cancel").click(()=>{
        if(confirm("정말 가입을 취소하고 홈으로 이동하시겠습니까?"))
            location.href="${pageContext.request.contextPath}/";
    });

    // 반응형 폼
    function changeForm($type, level){
        try {
            $type.removeClass("is-valid");
            $type.removeClass("is-invalid");
        } catch (error) {}

        if(level == "t") $type.addClass("is-valid");
        else if(level == "f") $type.addClass("is-invalid");
    }

    // 반응형 메세지
    $memberId.focusin(()=>{
        if($memberId.val().length == 0) changeMsg("check_id");
    });
    $password.focusin(()=>{
        if($password.val().length == 0) changeMsg("check_password");
    });
    $passwordChk.focusin(()=>{
        if($passwordChk.val().length == 0) changeMsg("check_passwordChk");
    });

    changeMsg("step1");
    function changeMsg(type, level){

        //클래스 초기화
        try {
            $msg.removeClass("text-danger");
            $msg.removeClass("text-primary");
            $msg.removeClass("text-success");
        } catch (error) {}

        // 색 변경
        if(level == 't') $msg.addClass("text-success");
        else if(level == 'f') $msg.addClass("text-danger");
        else $msg.addClass("text-primary");

        //메세지 변경
        switch (type) {
            case "step1":$msg.html("먼저 아이디와 비밀번호를 입력해주세요.");break;
            case "check_id":$msg.html("아이디는 영소문자, 숫자 조합<br>6 ~ 14자리로 입력해주세요.");break;
            case "invalid_id":$msg.html("중복된 아이디입니다.");break;
            case "valid_id":$msg.html("사용 가능한 아이디입니다.");break;
            case "check_password":$msg.html("비밀번호는 영문자, 숫자, 특수문자 조합 <br>8 ~ 16자리로 입력해주세요.");break;
            case "valid_password":$msg.html("사용 가능한 비밀번호입니다.");break;
            case "check_passwordChk":$msg.html("비밀번호를 다시 한번 확인해주세요.");break;
            case "valid_passwordChk":$msg.html("비밀번호가 일치합니다.");break;
            case "invalid":$msg.html("다시 한번 확인해주세요.");break;
            case "step2":$msg.html("가입에 필요한 개인 정보를 입력해주세요.");break;
        }

    }

});
</script>






<jsp:include page="/WEB-INF/views/common/footer.jsp"/>