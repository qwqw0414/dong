<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<style>
    #boardWrite-contant{
        width: 600px;
        height: 600px;
        margin: 0 auto;
        padding-top: 100px;
    }


</style>


<div id="boardWrite-contanier" class="text-center">
	<form action="${pageContext.request.contextPath}/board/writeBoardEnd.do">
        <div id="boardWrite-contant">
                <div class="col-auto">
                        <label class="sr-only" for="inlineFormInputGroup">Username</label>
                        <div class="input-group mb-2">
                          <div class="input-group-prepend">
                            <div class="input-group-text">제목&nbsp;&nbsp;&nbsp;&nbsp;</div>
                          </div>
                          <input type="text" class="form-control" id="boardTitle" name="boardTitle" placeholder="제목을 입력하세요">
                        </div>
                      </div>
                <div class="col-auto">
                    <label class="sr-only" for="inlineFormInputGroup">Username</label>
                    <div class="input-group mb-2">
                        <div class="input-group-prepend">
                        <div class="input-group-text">작성자</div>
                        </div>
                        <input type="text" class="form-control" value="${memberLoggedIn.memberId}" name="memberId" placeholder="Username" readonly>
                    </div>
                </div>
                <div class="col-auto">
                        <label class="sr-only" for="inlineFormInputGroup">Username</label>
                        <div class="input-group mb-2">
                            <div class="input-group-prepend">
                            <div class="input-group-text">사진&nbsp;&nbsp;&nbsp;&nbsp;</div>
                            </div>
                            <input type="text" class="form-control" id="boardPicture" name="boardPicture" placeholder="사진">
                        </div>
                    </div>
                    <div class="form-group">
                            <label for="exampleFormControlTextarea1">내용</label>
                            <textarea class="form-control" id="boardContents" name="boardContents" rows="10"></textarea>
                    </div>
            
            <input type="submit" class="btn btn-success " value="글쓰기">
        </div>
       </form>
    </div>
    


	














</body>





<jsp:include page="/WEB-INF/views/common/footer.jsp"/>