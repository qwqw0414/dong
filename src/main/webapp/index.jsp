<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<div class="jumbotron jumbotron-fluid">
  <div class="container">

    <h1>AWS 연결 테스트</h1>

    <div class="input-group mb-3" id="test">
      <input type="text" class="form-control" placeholder="test" maxlength="30">
      <div class="input-group-append">
        <button class="btn btn-outline-secondary" type="button">작성</button>
      </div>
    </div>
	ㄱㄷㄱㄷㄱㄷ
    <div id="testShow"></div>
  </div>
</div>
<!-- ${pageContext.request.contextPath}/test/test.do -->
<script>

$(()=>{
  $("#test [type=text").keyup((e)=>{
    if(e.keyCode == 13) testInsert();
  })
  $("#test button").click(()=>{
    testInsert();
  });
});

function testInsert(){
  var $text = $("#test [type=text]");

  if($text.val().length == 0) return;

  $.ajax({
    url: "${pageContext.request.contextPath}/test/test",
    data: {text:$text.val()},
    type: "POST",
    success : data => {

      $text.val("");
      if(data != "0") testReload();
    },
    error : (x,s,e) =>{
      console.log("실패",x,s,e);
    }
  });
}

function testReload(){
  $.ajax({
      url: "${pageContext.request.contextPath}/test/test",
      dataType: "json",
      success : data => {
        let table = '<table class="table table-sm"><thead><tr><th scope="col">No</th>'
                  + '<th scope="col">Text</th><th scope="col">Date</th></tr></thead><tbody>';
        $.each(data,(idx, test)=>{
          table += '<tr>';
          table += '<td>'+test.testNo+'</td>';
          table += '<td>'+test.testText+'</td>';
          table += '<td>'+test.testDate+'</td>';
          table += '</tr>';
        });
        table += '</tbody></table>';
        $("#testShow").html(table);
      },
      error : (x,s,e) =>{
        console.log("실패",x,s,e);
      }
    });
}

</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>