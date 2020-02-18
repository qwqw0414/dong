<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8">
  <title>${param.pageTitle}</title>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.js"></script>
  <script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.1.js"></script>
  <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
  <script src="${pageContext.request.contextPath }/resources/js/js.js"></script>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
    integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
    integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
    crossorigin="anonymous"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
    integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
    crossorigin="anonymous"></script>
  <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/css.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/animation.css" />
  <style>
    table.table th,
    table.table td {
      text-align: center;
    }
  </style>
</head>
  <h2>동네톡</h2>
  <table class="table">
    <thead>
      <tr>
        <th scope="col">회원아이디</th>
        <th scope="col">메세지</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach items="${recentList }" var="m" varStatus="vs">
        <tr chatNo='<c:out value="${m.CHATID}.${m.MEMBERID}"/>' /><%-- el의 문자열 더하기 연산대신 jstl out태그 사용 --%>
        <td><a href="javascript:goChat('${m.CHATID}')">${m.MEMBERID }</a></td>
        <td>${m.MSG }<c:if test="${m.CNT != 0}"> (${m.CNT})</c:if>
        </td>
        </tr>
      </c:forEach>
    </tbody>
  </table>

<script>
  let socket = new SockJS('<c:url value="/stomp" />');
  let stompClient = Stomp.over(socket);

  chatRoomLoad();

  stompClient.connect({}, function (frame) {
    console.log('connected stomp over sockjs');
    console.log(frame);

    stompClient.subscribe('/chat/admin', function (message) {
      console.log("receive from /chat/admin :", message);
      location.reload();
      let messsageBody = JSON.parse(message.body);
      $("#data").append(messsageBody.memberId + ":" + messsageBody.msg + "<br/>");
    });

  });
  function goChat(chatId) {
    location.href = "${pageContext.request.contextPath}/ws/" + chatId + "/adminChat.do/";
  }
</script>

</body>

</html>