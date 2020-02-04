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
				     				[memberId]님의 상점
                                    <br>
									상점이름 : <input type="text" value="shopName" /> <br />
									개설날짜 : [enrollDate] </div>
                              </div>
                              <div class="mypage_btn">
                                  <input type="button"  class="btn_val" value="수정">
                              </div>
                            </div>
                                
                                    
                                   
                            

                        </div>
                        <div id="mypage_point" class="mypage_con">
                            <h4>내 포인트</h4><br>
                            <div class="ms_content">
                                <p>보유 포인트 : [Point]P</p>

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
                                    <p><label for="memberName">이름</label> : <input type="text" name="memberName"value="memberName" /></p>
                                    <p><label for="gender">성별</label> : <input type="text" name="gender"value="gender" /></p>
                                    <p><label for="birth">생년월일</label> : <input type="text" name="birth"value="birth" /></p>
                                </div>

                                <div class="col">
                                	<p><label for="phone">연락처</label> : <input type="text" name="phone"value="phone" /></p>
                                	<p><label for="email">이메일</label> : <input type="text" name="email"value="email" /></p>
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
                            <p>설정된 동네 : [SIDO][SIGUNGU][DONG]</p>


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





<!-- <h1>회원 정보</h1> -->
<!-- <div id="update-container"> -->
<%-- <input type="text" class="form-control" placeholder="아이디" name="memberId" id="memberId_" value="${member.memberId}" readonly required> <br /> --%>
<%-- 		<input type="text" class="form-control" placeholder="이름" name="memberName" id="memberName" value="${member.memberName}" required> <br /> --%>
<!-- 		<select class="form-control" name="gender" required><br /> -->
<!-- 		  <option value="" disabled selected>성별</option><br /> -->
<%-- 		  <option value="M" ${member.gender=='M'?'selected':'' }>남</option> --%>
<%-- 		  <option value="F" ${member.gender=='F'?'selected':'' }>여</option> --%>
<!-- 		</select><br /> -->
<%-- 		<input type="number" class="form-control" placeholder="생년월일" name="age" id="age" value="${member.birth}"><br /> --%>
<%-- 		<input type="tel" class="form-control" placeholder="전화번호 " name="phone" id="phone" maxlength="11" value="${member.phone}" required><br /> --%>
<%-- 		<input type="email" class="form-control" placeholder="이메일" name="email" id="email" value="${member.email}" required><br /> --%>
<%-- <%-- 		<input type="text" class="form-control" placeholder="주소" name="address" value="${member.address}" id="address"> --%>
<!-- </div> -->





<jsp:include page="/WEB-INF/views/common/footer.jsp"/>