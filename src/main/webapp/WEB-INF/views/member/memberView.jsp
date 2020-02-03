<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<h1>회원 정보</h1>
<div id="update-container">
<input type="text" class="form-control" placeholder="아이디" name="memberId" id="memberId_" value="${member.memberId}" readonly required> <br />
		<input type="text" class="form-control" placeholder="이름" name="memberName" id="memberName" value="${member.memberName}" required> <br />
		<select class="form-control" name="gender" required><br />
		  <option value="" disabled selected>성별</option><br />
		  <option value="M" ${member.gender=='M'?'selected':'' }>남</option>
		  <option value="F" ${member.gender=='F'?'selected':'' }>여</option>
		</select><br />
		<input type="number" class="form-control" placeholder="생년월일" name="age" id="age" value="${member.birth}"><br />
		<input type="tel" class="form-control" placeholder="전화번호 " name="phone" id="phone" maxlength="11" value="${member.phone}" required><br />
		<input type="email" class="form-control" placeholder="이메일" name="email" id="email" value="${member.email}" required><br />
<%-- 		<input type="text" class="form-control" placeholder="주소" name="address" value="${member.address}" id="address"> --%>
</div>




<jsp:include page="/WEB-INF/views/common/footer.jsp"/>