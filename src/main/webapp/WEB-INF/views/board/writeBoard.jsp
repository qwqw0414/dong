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
                        <input type="text" class="form-control" value="${memberLoggedIn.memberId}" placeholder="Username" readonly>
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
                            <textarea class="form-control" id="boardContent" name="boardContent" rows="10"></textarea>
                    </div>
            
            <input type="button" class="btn btn-success btn-send" value="글쓰기">
        </div>
    </div>
    
    <script>
    $("#boardWrite-contanier .btn-send").click(function(){
    	var boardTitle = $("#boardTitle").val();
    	var boardContent = $("#boardContent").val();
    	
    	$.ajax({
    		url: "${pageContext.request.contextPath}/board/writeBoardEnd",
    		data: {boardTitle:boardTitle,
    				boardContent:boardContent},
    		dataType: "json",
    		type: "POST",
    		contentType: "application/json; charset=utf-8",
    		success: data => {
				console.log(data);
    		},
    		error: (x,s,e) => {
				console.log(x,s,e);
			}
    	});
    	
    });
    
    
    </script>

	














</body>





<jsp:include page="/WEB-INF/views/common/footer.jsp"/>