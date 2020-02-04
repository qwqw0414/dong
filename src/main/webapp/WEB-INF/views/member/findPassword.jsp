<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<h1>비밀번호 찾기</h1>
<div id="pwdFrm">
    <div class="form-group">
    <label for="exampleInputPassword1">아이디</label>
    <input type="text" class="form-control" name="memberId" id="memberId" required>
  </div>
  <div class="form-group">
    <label for="exampleInputPassword1">이메일</label>
    <input type="email" class="form-control" name="email" id="email" required>
  </div>
<button type="submit" class="btn btn-primary" id="btn-pwdFrm">비밀번호 확인</button>
<button type="submit" class="btn btn-primary" id="btn-Update">비밀번호 변경</button>
</div>

<div id="pwdUpdateFrm">
    <div class="form-group">
    <label for="exampleInputPassword1">비밀번호</label>
    <input type="password" class="form-control" name="pwd" id="pwd" required>
  </div>
    <input type="hidden" class="form-control" name="id" id="id" required>
  <div class="form-group">
    <label for="exampleInputPassword1">비밀번호 확인</label>
    <input type="password" class="form-control" name="pwdChk" id="pwdChk" required>
  </div>
<button type="submit" class="btn btn-primary" id="btn-pwdUpdate">변경</button>
</div>


<script>
$(function(){
	$("#pwdUpdateFrm").hide();
});

$(()=> {
	var $memberId = $("#pwdFrm #memberId");
	var $email = $("#pwdFrm #email");
	var $pwd = $("#pwdUpdateFrm #pwd");
	var $pwdChk = $("#pwdUpdateFrm #pwdChk");
	
$("#pwdFrm #btn-pwdFrm").click(function(){
	
	$.ajax({
		url: "${pageContext.request.contextPath}/member/findPasswordEnd",
		data : {memberId:$memberId.val(),
				email:$email.val()},
		dataType : "json",
		type: "GET",
		success: data =>{
			console.log(data);
			if(data>0){
				console.log(data.memberId);
				console.log(data.email);
			}else{
				console.log("입력한 값 없음");
			}
			
		},error :(x,s,e) => {
			console.log("ajax요청 실패!",x,s,e);
		}
	});
});
	
	
$("#pwdFrm #btn-Update").click(function(){
	$("#pwdFrm").hide();
	$("#pwdUpdateFrm").show();
});
	

$("#pwdUpdateFrm #btn-pwdUpdate").click(function(){
	$pwd.keyup((e)=>{
    var regExp = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g;
		
    	if(regExp.test($pwd.val())){
    		changeMsg("valid_password",'t');
            changeForm($pwd,'t');
    	}else{
    		changeMsg("check_password");
            changeForm($pwd);
    	}
    	if(e.keyCode == 13){
    		$pwdChk.focus();
    	}
	});
	
	$pwdChk.keyup((e)=>{
		if($pwd.val() !== $pwdChk.val()){
			alert("비밀번호가 올바르지 않습니다.");
			return;
		}    
		$.ajax({
			url: "${pageContext.request.contextPath}/member/passwordUpdate",
			data: {pwd:$pwd.val(), pwdChk:$pwdChk.val()},
			dataType: "json",
			type: "POST",
			success: data => {
				console.log(data);
				if(data>0){
					console.log(data);	
					
				}else{
					console.log("비밀번호 변경 실패");
				}
				
			},error(x,s,e){
				console.log("비밀번호 변경 ajax요청 실패!",x,s,e);
			}
		});
		
	});

});
	
	
});


</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>