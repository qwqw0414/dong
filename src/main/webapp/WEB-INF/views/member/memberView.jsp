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

                                <div class="col">
                                    <p><label for="memberName">이름</label> : <input type="text" name="memberName"value="${member.MEMBER_NAME }" /></p>
                                	<p><label for="phone">연락처</label> : <input type="text" name="phone"value="${member.PHONE}" /></p>
                                	<p><label for="email">이메일</label> : <input type="text" name="email" value="${member.EMAIL }" /></p>
                                </div>

                                <div class="col">
                                	 <p>성별 : ${member.GENDER=='M'?'남자':'여자' }</p>
                                    <p>생년월일: ${member.BIRTH }</p>
                                </div>
                            </div>

                        <div class="mypage_btn">
                            
                            <input type="button"  class="btn_val btn_val_update" value="수정">
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
</style>





<jsp:include page="/WEB-INF/views/common/footer.jsp"/>