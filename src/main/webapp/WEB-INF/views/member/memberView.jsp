<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>



<div class="container">
        <div class="content">
            <div class="row row-cols-2">
                
                <div class="col" id="col_left">
                    <div class="mypage_shop">
                        <div id="mypage_shop" class="mypage_con">
                            <h4>내 상점</h4><br>
                            <div class="ms_content">
                            <div class="row">
                                <div class="col-sm-4"> <img src="https://static.nid.naver.com/images/web/user/default.png" width="80" height="80" alt="" dispaly="block"></div>
                                <div class="col-sm-8">
				     				<label for="">${member.MEMBER_ID }</label>님의 상점
                                    <br>
									상점이름 : ${member.SHOP_NAME} <br />
									개설날짜 : ${member.OPEN_DATE} </div>
                              </div>
                              <div class="mypage_btn">
                                  <input type="button"  class="btn_val" value="수정">
                              </div>
                            </div>
                                
                                    
                                   
                            

                        </div>
                        <div id="mypage_point" class="mypage_con">
                            <h4>내 포인트</h4><br>
                            <div class="ms_content">
                                <p>보유 포인트 : ${member.POINT}P</p>

                                <div class="mypage_btn">
                                    <input type="button"  class="btn_val" value="충전">
                                    <input type="button"  class="btn_val" value="환불">
                                </div>
                            </div>

                            
                        </div>
                    
                    </div>
                </div>


                <div class="col" id="col_right">
                    <div id="mypage_info" class="mypage_con">
                        <h4>내정보</h4><br>
                        <div class="ms_content">
                            <div class="row row-cols-2">
                            
                            <div id="change_con">
                            <div class="ms_change">
                                <div class="before_change1">
                              		  이름:<span id="curname">${member.MEMBER_NAME}</span> <input type="button" class="change_btn1" value="수정" />
                                </div>
                                <div class="input-group mb-3  after_change1" >
                                    <input type="text" class="form-control" id="username" aria-label="Recipient's username" aria-describedby="button-addon2">
                                    <div class="input-group-append">
                                      <button class="btn btn-outline-secondary" type="button" id="button-addon1">확인</button>
                                    </div>
                                  </div>
                            </div>
                            
                            <div class="ms_change">

                                <div class="before_change2">
                                <span>연락처:${member.PHONE}</span> <input type="button" class="change_btn2" value="수정" />
                                </div>

                                <div class="input-group mb-3 after_change2" style="display: none;">
                                    <input type="text" class="form-control" aria-label="Recipient's" aria-describedby="button-addon2">
                                    <div class="input-group-append">
                                      <button class="btn btn-outline-secondary" type="button" id="button-addon2">확인</button>
                                    </div>
                                  </div>

                            </div>
                            


                            <div class="ms_change">
                                <div class="before_change3">
                                <span>이메일:${member.EMAIL}</span> <input type="button" class="change_btn3" value="수정" />
                            </div>
                                <div class="input-group mb-3  after_change3" style="display: none;">
                                    <input type="text" class="form-control" aria-label="Recipient's username" aria-describedby="button-addon2">
                                    <div class="input-group-append">
                                      <button class="btn btn-outline-secondary" type="button" id="button-addon3">확인</button>
                                    </div>
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

                    <div id="mypage_location" class="mypage_con">
                        <h4>우리 동네</h4><br>
                        <div class="ms_content">
                            <p>내 동네 : ${member.SIDO } ${member.SIGUNGU} ${member.DONG}</p>


                            <div class="mypage_btn">
                            
                                <input type="button"  class="btn_val" value="수정">
                            </div>

                        </div>
                    </div>

                </div>


              </div>



        </div>
    </div>
    
    
    
    <script>
    //이름 변경
	$("#button-addon1").on('click',function(){
		var afterName = $("#username").val();
		console.log(afterName);
		
		$.ajax({
			url:"${pageContext.request.contextPath}/member/updateMemberName",
			data:{afterName:afterName},
			type:"POST",
			success: data => {
				console.log(data);
				$("#curname").text(data.MEMBER_NAME)
    		},
    		error: (x,s,e) => {
				console.log(x,s,e);
			}
		});
	});
    
    //


    
    </script>
    
    
    
    
    
    

<style>
.mypage_con{
    border:solid black 1px;
    width:540px;
    height: 250px;
    margin-top: 30px;
    margin-bottom: 120px;
    padding:15      px;
}
.btn_val{
    margin-top: 30px;
}
.btn_val_update{
    margin-top: 20px;
}
.col{
	width:560px;
}
#col_right{
    padding-left: 100px;
}
.ms_change{
	width:280px;
	height: 30px;
	display:inline-block;
	
}
#change_con{
	padding-left:20px;
}
</style>





<jsp:include page="/WEB-INF/views/common/footer.jsp"/>