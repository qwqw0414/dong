<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
#memberEnroll .enroll-form{width: 450px; margin: auto;}
#memberEnroll .enroll-map{width: 450px; margin: auto;}
#memberEnroll .enroll-form input{margin-top: 40px;}
#memberEnroll .enroll-form select{margin-top: 40px;}
#memberEnroll h1{font-weight: bolder;}
#memberEnroll .enroll-btn{margin-top: 50px;}
#memberEnroll .enroll-btn button{width: 230px;}
#memberEnroll #msg{font-size: 1.6em; margin: 0px 0 40px; height: 60px;}
#memberEnroll #page-2{margin-top: 0px; margin-bottom: 30px;}
#memberEnroll #page-3{margin-top: 0px; margin-bottom: 30px;}
#memberEnroll #page-2{display: none;}
#memberEnroll #btn-2{display: none;}
#memberEnroll #page-3{display: none;}
#memberEnroll #btn-3{display: none;}
#memberEnroll #page-4{display: none;}
#memberEnroll #btn-4{display: none;}
#memberEnroll #page-5{display: none;}
#memberEnroll #page-5{display: none;}
#memberEnroll #map{display: none;}
#memberEnroll #centerAddr{display: none;}
</style>
<style>
#memberEnroll .map_wrap {position:relative;width:100%;height:300px;}
#memberEnroll .title {font-weight:bold;display:block;}
#memberEnroll .hAddr {position:absolute;left:10px;top:10px;border-radius: 2px;background:#fff;background:rgba(255,255,255,0.8);z-index:1;padding:5px;}
#memberEnroll #centerAddr {display:block;margin-top:2px;font-weight: normal;}
#memberEnroll .bAddr {padding:5px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
</style>
<div id="memberEnroll" class="text-center">

    <div id="msg"></div>

    <div class="enroll-form" id="page-1">
        <input type="hidden" id="valid-Id" value="0">
        <input type="text" id="memberId" placeholder="ID" class="form-control form-control-lg" maxlength="14">
        <input type="password" id="password" placeholder="Password" class="form-control form-control-lg" maxlength="16">
        <input type="password" id="password-check" placeholder="Password Check" class="form-control form-control-lg" maxlength="16">
    </div>

    <div class="enroll-form" id="page-2">
        <input type="text" id="memberName" placeholder="성명을 입력해주세요." class="form-control form-control-lg" maxlength="8">
        <select id="gender" class="custom-select custom-select-lg">
            <option disabled hidden selected>성별을 선택해주세요.</option>
            <option value="M">남</option>
            <option value="F">여</option>
        </select>
        <div class="input-group">
            <select id="year" class="custom-select custom-select-lg"></select>
            <select id="month" class="custom-select custom-select-lg">
                <option disabled hidden selected>월</option>
            </select>
            <select id="date" class="custom-select custom-select-lg">
                <option disabled hidden selected>일</option>
            </select>
        </div>
        <input type="text" id="phone" placeholder="연락처를 입력해주세요. ( - 제외)" class="form-control form-control-lg" maxlength="13">
    </div>
	
    <div class="enroll-map" id="page-3">
        <button id="btn-searchAddress" class="btn btn-info btn-block">위치 검색</button>
        <button id="btn-zipcode"  class="btn btn-info btn-block">우편번호 검색</button>
        <div class="input-group">
            <input type="text" id="sido" value="" class="form-control form-control text-center" readonly>
            <input type="text" id="sigungu" value="" class="form-control form-control text-center" readonly>
            <input type="text" id="dong" value="" class="form-control form-control text-center" readonly>
        </div>
        <div class="map_wrap">
            <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
            <div class="hAddr">
                <span class="title">지도중심기준 행정동 주소정보</span>
                <span id="centerAddr"></span>
            </div>
        </div>
    </div>

    <div class="enroll-form" id="page-4">
   	 	<input type="hidden" id="valid-email" value="0">
   	 	<br />
        <input type="email" name="email" id="email" value="" class="form-control text-center">
        <span id="emailAu"></span>
        <input type="button" value="이메일 번호 보내기" id="email-auth" class="btn btn-primary mb-2"/>
	
    </div>
	<div class="enroll-btn form-group mx-sm-3 mb-2" id="page-5">
		<p>이메일을 보냈습니다.</p>
		<input type="hidden" id="valid-auth" value="0">
        <input type="text" name="authKey" id="authKey" class="form-control"/>
        <br />
       	<input type="button" name="authKey-btn" id="authKey-btn" value="인증 확인" class="btn btn-primary mb-2" />
    </div>
    	
    <div class="enroll-btn" id="btn-1">
        <button class="btn btn-outline-primary btn-lg" id="next-page2">다음 단계로 진행<br>( 1 / 4 )</button>
    </div>
    
    <div class="enroll-btn" id="btn-2">
        <button class="btn btn-outline-primary btn-lg" id="next-page3">다음 단계로 진행<br>( 2 / 4 )</button>
    </div>

    <div class="enroll-btn" id="btn-3" style="margin-top:30px;">
        <button class="btn btn-outline-primary btn-lg" id="next-page4">다음 단계로 진행<br>( 3 / 4 )</button>
    </div>

    <div class="enroll-btn" id="btn-4">
        <button class="btn btn-outline-primary btn-lg" id="btn-enroll">회원 가입 완료<br>( 4 / 4 )</button>
    </div>
</div>

<script>
$(()=>{
    var $page_1 = $("#memberEnroll #page-1");
    var $page_2 = $("#memberEnroll #page-2");
    var $page_3 = $("#memberEnroll #page-3");
    var $page_4 = $("#memberEnroll #page-4");
    var $page_5 = $("#memberEnroll #page-5"); 
    var $btn_1 = $("#memberEnroll #btn-1");
    var $btn_2 = $("#memberEnroll #btn-2");
    var $btn_3 = $("#memberEnroll #btn-3");
    var $btn_4 = $("#memberEnroll #btn-4");

    var $msg = $("#memberEnroll #msg");
    var $memberId = $("#memberEnroll #memberId");
    var $validId = $("#memberEnroll #valid-Id");
    var $password = $("#memberEnroll #password");
    var $passwordChk = $("#memberEnroll #password-check");
    var $memberName = $("#memberEnroll #memberName");
    var $gender = $("#memberEnroll #gender");
    var $phone = $("#memberEnroll #phone");
    var $email = $("#memberEnroll #email");
    var $validEmail = $("#memberEnroll #valid-email");
    var $authKey = $("#memberEnroll #authKey");
    var $year = $("#memberEnroll #year");
    var $month = $("#memberEnroll #month");
    var $date = $("#memberEnroll #date");
    var $sido = $("#memberEnroll #sido");
    var $sigungu = $("#memberEnroll #sigungu");
    var $dong = $("#memberEnroll #dong");
    var $validAuth = $("#memberEnroll #valid-auth");
    
    //----------------------------------------근호
    /* 메일 인증 보내기 */
     $("#email-auth").click(()=>{
    	 var $email = $("#email").val();
    	 
    	  if($validEmail.val() != 1){
         	changeMsg("invalid",'f');
         	changeForm($email,'f');
         	$email.focus();
         	return;
         } 
    	 
    	 $.ajax({
    		url: "${pageContext.request.contextPath}/member/emailAuth.do?email=",
    		data: {email:$email},
    		dataType:"text",
    		success: data => {
    			console.log(data);
    	        $page_4.hide();
    	        $page_5.show();
    		},
    		
    		error : (x,s,e) =>{
    			console.log("실패", x,s,e);
    		}
    	 })
    }); 
    /* 메일 인증 받기 */
    $("#authKey-btn").click(()=>{
    	var $authKey = $("#authKey").val();
    	var $email = $("#email").val(); 

    	$.ajax({
	    	url: "${pageContext.request.contextPath}/member/verify.do",
			data: {authKey:$authKey,
				   email:$email
			       },
			dataType:"text",
			success: data=>{
				console.log(data);
				if(data=="true") {
					$validAuth.val(1); 
					changeMsg("auth_ok",'t');
					$("#authKey").attr("disabled", true);
				}
				else if(data=="false"){
					changeMsg("valid_auth",'f');
					$validAuth.val(0);
				}
			},
			error : (x,s,e) =>{
				console.log("실패", x,s,e);
			}
    	})
    });
    
    /* 이메일 유효성 검사 */
    $email.keyup((e)=>{
		var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		
		if($validEmail.val() == 1 && e.keyCode == 13){
            changeForm($email,'t');
            return;
        }
		
		if(!regExp.test($email.val()) && e.keyCode == 13){
			changeMsg("check_email",'f');
			$validEmail.val(0);
			changeForm($email,'f');
			return;
		}
		
		if(!regExp.test($email.val())){
			$validEmail.val(0);
			changeMsg("check_email");
			changeForm($email);
			return;
				
		}
		/* 이메일 중복검사 */
		$.ajax({
			url: "${pageContext.request.contextPath}/member/emailDuplicate",
			data:{email:$email.val()},
			dataType: "json",
			success: data =>{
				if(data == 0){
					$validEmail.val(1);
					changeMsg("valid_email",'t');
                    changeForm($email,'t');
				}
				else{
					$validEmail.val(0);
                    changeMsg("invalid_email",'f');
                    changeForm($email,'f');
				}
			},
			error : (x,s,e) =>{
				console.log("실패",x,s,e);
			}
		})
	});   
    	/* 우편번호 검색  */
    	$("#btn-zipcode").click(()=>{
    		new daum.Postcode({
	    	    oncomplete: function(data) {
	    	    	
	    	    	var sido = "";
	    			
	    	    	if(data.sido=='서울') {
	    	    		sido = data.sido+"특별시";
	    	    	}
	    	    	if(data.sido=='부산' || data.sido=='대구' || data.sido=='인천' || data.sido=='광주' || data.sido=='대전' || data.sido=='울산') {
	    	    		sido = data.sido+"광역시";
	    	    	}
	    	    	if(data.sido == '경기') {
	    	    		sido = data.sido+"도";
	    	    	}
	    	    	if(data.sido == '강원') {
	    	    		sido = data.sido+"도";
	    	    	}
	    	    	if(data.sido == '제주특별자치도') {
	    	    		sido = data.sido;
	    	    	}
	    	    	if(data.sido == '충북') {
	    	    		sido = "충청북도";
	    	    	}
	    	    	if(data.sido == '충남') {
	    	    		sido = "충청남도";
	    	    	}
	    	    	if(data.sido == '전북') {
	    	    		sido = "전라북도";
	    	    	}
	    	    	if(data.sido == '전남') {
	    	    		sido = "전라남도";
	    	    	}
	    	    	if(data.sido == '경북') {
	    	    		sido = "경상북도";
	    	    	}
	    	    	if(data.sido == '경남') {
	    	    		sido = "경상남도";
	    	    	}
	    	    	console.log(sido);
	    	   
	    	     document.getElementById("sido").value = sido;
	             document.getElementById("sigungu").value = data.sigungu;
	             document.getElementById("dong").value = data.bname; 
	    	    }
	    	}).open();
    		$("#map").hide();
    		$("#centerAddr").hide();
    	});
    	
    //------------------------------------------근호 끝
    
    //회원 가입
    $("#memberEnroll #btn-enroll").click(()=>{

        var birth = "";
        birth += $year.val();

        if($month.val().length < 2)
            birth += ("0"+$month.val());
        else
            birth += (""+$month.val());

        if($date.val().length < 2)
            birth += ("0"+$date.val());
        else
            birth += (""+$date.val());

        console.log(birth);
        
        /* 이메일 인증  유효성*/
        if($validAuth.val() != 1){
        	changeMsg("check_auth",'f');
        	changeForm($email,'f');
        	return;
        }

        $.ajax({
            url: "${pageContext.request.contextPath}/member/memberEnrollEnd",
            data: {memberId:$memberId.val(),
                   password:$password.val(),
                   memberName:$memberName.val(),
                   gender:$gender.val(),
                   phone:$phone.val(),
                   birth:birth,
                   email:$email.val(),
                   sido:$sido.val(),
                   sigungu:$sigungu.val(),
                   dong:$dong.val()},
            dataType: "json",
            success : data =>{
                if(data == 1){
                    alert("회원가입 완료");
                    location.href = "${pageContext.request.contextPath}/";
                }
                else{
                    alert("실패");
                    location.href = "${pageContext.request.contextPath}/";
                }
            },
            error : (x,s,e) =>{
                console.log("실패",x,s,e);
            }
        })
                       
    });

    //페이지 전환
    $("#memberEnroll #next-page2").click(()=>{
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
        $page_1.hide();
        $btn_1.hide();
        $page_2.show();
        $btn_2.show();
        changeMsg("step2");
        insertYear($year);
    });

    $("#memberEnroll #next-page3").click(()=>{

        var regExp = /^[가-힣]{2,5}$/;
        if(!regExp.test($memberName.val())){
            changeMsg("check_name",'f');
            changeForm($memberName,'f');
            $memberName.focus();
            return;
        }

        if($gender.val() == null){
            changeMsg("check_gender",'f');
            changeForm($gender,'f');
            $gender.focus();
            return;
        }

        if($year.val() == null){
            changeMsg("check_birth",'f');
            changeForm($year,'f');
            $year.focus();
            return;
        }

        if($month.val() == null){
            changeMsg("check_birth",'f');
            changeForm($month,'f');
            $month.focus();
            return;
        }

        if($date.val() == null){
            changeMsg("check_birth",'f');
            changeForm($date,'f');
            $date.focus();
            return;
        }

        regExp = /01{1}[016789]{1}[0-9]{7,8}/;
        if(!regExp.test($phone.val())){
            changeMsg("check_phone",'f');
            changeForm($phone,'f');
            $phone.focus();
            return;
        }
        $page_2.hide();
        $btn_2.hide();
        $page_3.show();
        $btn_3.show();
        changeMsg("step3");
    });
    
    $("#memberEnroll #next-page4").click(()=>{
        if($sido.val().length == 0){
            changeMsg("",'f');
            return;
        }

        changeMsg("step4");

        $page_3.hide();
        $btn_3.hide();
        $page_4.show();
        $btn_4.show();
    })
    
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

    $memberName.keyup(()=>{
        changeMsg("");
        changeForm($memberName);
    })
    $gender.blur(()=>{
        changeMsg("");
        changeForm($gender);
    })
    $year.blur(()=>{
        changeMsg("");
        changeForm($year);
    })
    $month.blur(()=>{
        changeMsg("");
        changeForm($month);
    })
    $date.blur(()=>{
        changeMsg("");
        changeForm($date);
    })
    $phone.keyup(()=>{
        changeMsg("");
        changeForm($phone);
    })

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
        else if(level == 'f') $msg.addClass("text-danger animated tada");
        else {
        	$msg.addClass("text-primary");
        	$msg.removeClass("animated tada");
        }

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
            case "check_email":$msg.html("이메일 형식으로 입력하세요.");break;
            case "check_auth":$msg.html("이메일 인증을 해주세요.");break;
            case "invalid_email":$msg.html("중복된 이메일입니다.");break;
            case "valid_email":$msg.html("사용 가능한 이메일입니다.");break;
            case "valid_auth":$msg.html("인증번호가 틀렸습니다.");break;
            case "auth_ok":$msg.html("인증완료.");break;
            case "invalid":$msg.html("다시 한번 확인해주세요.");break;
            case "step2":$msg.html("가입에 필요한 개인 정보를<br>입력해주세요.");break;
            case "check_name":$msg.html("본인 성명을 입력해주세요");break;
            case "check_gender":$msg.html("본인 성별을 선택해주세요.");break;
            case "check_birth":$msg.html("본인 생년월일을 선택해주세요.");break;
            case "check_phone":$msg.html("연락 가능한 번호를 입력해주세요. ('-' 제외)");break;
            case "step3":$msg.html("본인이 거주하는 위치를 알려주세요.");break;
            case "step4":$msg.html("본인 확인을 위해 이메일 인증을 시작합니다.");break;
        }

    }

    // 년, 월, 일 동적 처리
    function insertYear($obj){
        let title = "<option disabled hidden selected>년</option>";
        $obj.html(title);

        var now = new Date().getFullYear();

        for(var i = 0; i < 100; i++){
            $obj.append("<option value='"+(now-i)+"'>"+(now-i)+"년</option>");
        }
    }

    function insertMonth($obj){
        $obj.html("");
        for(var i = 1; i <= 12; i++){
            $obj.append("<option value='"+(i)+"'>"+(i)+"월</option>");
        }
    }

    function insertDate($obj, month){
        $obj.html("");
        for(var i = 1; i <= 31; i++){
            if(i > 29 && month == 2) return;
            if(i > 30 && (month == 4 || month == 6 || month == 9 || month == 11)) return;
            $obj.append("<option value='"+(i)+"'>"+(i)+"일</option>");
        }
    }

    $year.blur(()=>{
        if($year.val() != null)
            insertMonth($month);
    });
    $month.blur(()=>{
        if($month.val() != null)
            insertDate($date, $month.val());
    });

    // 위치 정보 저장하기
    function setAddress(address){
        addrArr = address.split(" ");
        console.log(addrArr);
        
        var dongIndex = 0;

        addrArr.forEach(addr => {
            dongIndex++;
            if(addr.substr(addr.length-1,1)=='동'){
                console.log(addr);
                return;
            }
        });

        $sido.val(addrArr[0]);
        $sigungu.val(addrArr[1]);
        $dong.val(addrArr[dongIndex-1]);
    }

    // 위치 정보 가져오기
    
    $("#memberEnroll #btn-searchAddress").click(()=>{
        var latitude;
        var longitude;
    
        if(navigator.geolocation){
            navigator.geolocation.getCurrentPosition(function(position){
                latitude = position.coords.latitude;
                longitude = position.coords.longitude;
    
                console.log(latitude);
                console.log(longitude);
    
                kakoMap(latitude,longitude);
            });
        }else{
            alert("gps를 지원하지 않는 브라우저 입니다. 크롬을 사용하거라.")
        }
    	$("#map").show();
    	$("centerAddr").show();
    });

    function kakoMap(latitude,longitude){
    
        var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
        mapOption = {
            center: new kakao.maps.LatLng(latitude, longitude), // 지도의 중심좌표
            level: 5 // 지도의 확대 레벨
        };  
    
        // 지도를 생성합니다    
        var map = new kakao.maps.Map(mapContainer, mapOption); 
    
        // 주소-좌표 변환 객체를 생성합니다
        var geocoder = new kakao.maps.services.Geocoder();
    
        var marker = new kakao.maps.Marker(), // 클릭한 위치를 표시할 마커입니다
            infowindow = new kakao.maps.InfoWindow({zindex:1}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다
    
        // 현재 지도 중심좌표로 주소를 검색해서 지도 좌측 상단에 표시합니다
        searchAddrFromCoords(map.getCenter(), displayCenterInfo);
    
        // 지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
        kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
            searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
                if (status === kakao.maps.services.Status.OK) {
                    var detailAddr = !!result[0].road_address ? '<div>도로명주소 : ' + result[0].road_address.address_name + '</div>' : '';
                    detailAddr += '<div>지번 주소 : ' + result[0].address.address_name + '</div>';
                    
                    var content = '<div class="bAddr">' +
                                    '<span class="title">법정동 주소정보</span>' + 
                                    detailAddr + 
                                '</div>';
    
                    // 마커를 클릭한 위치에 표시합니다 
                    marker.setPosition(mouseEvent.latLng);
                    marker.setMap(map);
    
                    // 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
                    infowindow.setContent(content);
                    infowindow.open(map, marker);
                }   
            });
        });
    
        // 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
        kakao.maps.event.addListener(map, 'idle', function() {
            searchAddrFromCoords(map.getCenter(), displayCenterInfo);
        });
    
        function searchAddrFromCoords(coords, callback) {
            // 좌표로 행정동 주소 정보를 요청합니다
            geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
        }
    
        function searchDetailAddrFromCoords(coords, callback) {
            // 좌표로 법정동 상세 주소 정보를 요청합니다
            geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
        }
    
        // 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
        function displayCenterInfo(result, status) {
            if (status === kakao.maps.services.Status.OK) {
                var infoDiv = document.getElementById('centerAddr');
    
                for(var i = 0; i < result.length; i++) {
                    // 행정동의 region_type 값은 'H' 이므로
                    if (result[i].region_type === 'H') {
                        infoDiv.innerHTML = result[i].address_name;
                        setAddress(result[i].address_name);
                        break;
                    }
                }
            }    
        }
    }
    	
});






</script>