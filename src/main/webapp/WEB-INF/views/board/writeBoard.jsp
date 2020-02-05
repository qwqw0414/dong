<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<style>
    #boardWrite-contant{
        width: 600px;
        height: 600px;
        margin: 0 auto;
        padding-top: 100px;
    }
    .col-auto{
        padding: 0px;
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
               <div class="input-group mb-3">
				 <div class="input-group-prepend">
				    <label class="input-group-text" for="inputGroupSelect01">카테고리</label>
				 </div>
				 <select class="custom-select" id="boardCategory" name="boardCategory">
				    <option selected>공지</option>
				    <option value="1">정보</option>
				    <option value="2">홍보</option>
				    <option value="3">자유</option>
				 </select>
				</div>
               <div class="input-group mb-3" style="padding:0px;">
				  <div class="input-group-prepend" style="padding:0px;">
				    <span class="input-group-text">첨부파일</span>
				  </div>
				  <div class="custom-file">
				    <input type="file" class="custom-file-input" name="upFile" id="upFile1" >
				    <label class="custom-file-label" for="upFile1">파일을 선택하세요</label>
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