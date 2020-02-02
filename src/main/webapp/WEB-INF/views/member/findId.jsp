<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<h1>아이디 찾기</h1>

<form action="${pageContext.request.contextPath}/member/findIdEnd.do" method="post">
  <div class="form-group">
    <label for="exampleInputEmail1">이름</label>
    <input type="text" class="form-control" name="name" id="name" aria-describedby="emailHelp" required>
  </div>
  <div class="form-group">
    <label for="exampleInputPassword1">이메일</label>
    <input type="email" class="form-control" name="email" id="email" required>
  </div>
  <button type="submit" class="btn btn-primary">아이디찾기</button>
</form>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>