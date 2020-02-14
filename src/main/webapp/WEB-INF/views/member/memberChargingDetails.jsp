<%@page import="java.util.Map"%>
<%@page import="com.pro.dong.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div id="charging_">	
<div id="chargingDetails"></div>
<div id="pageBar"></div>
</div>



<script>
showchargingDetails(1);
	
	
	
function showchargingDetails(cPage){
	$.ajax({
		url: "${pageContext.request.contextPath}/member/selectAllDetails",
		data:{cPage:cPage},
		type:"GET",
		dataType:"json",
		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		success:data=>{
			console.log(data);
			let html="";
			html+="<div id='detailList'>";
			html+="<table class='table table-striped'>";
			html+="<thead>";
			html+="<tr>";
			html+="<th scope='col'>#No.</th>";
			html+="<th scope='col'>날짜</th>";
			html+="<th scope='col'>금액</th>";
			html+="<th scope='col'>충전/사용</th>";
			html+="</tr>";
			html+="</thead>";
			html+="<tbody>";

			for(var i=0; i<data.list.length; i++){
				html+="<th scope='row'>"+(i+1)+"</th>";				
				html+="<td>"+data.list[i].REG_DATE+"</td>";
				html+="<td>"+data.list[i].POINT_AMOUNT+"</td>";
				html+="<td>"+data.list[i].STATUS+"</td>";
			html+="</tbody>";
			}//end of for
			
			html+="</table>";
			html+="</div>";
			
			$("#chargingDetails").html(html);
			$("#charging_ #pageBar").html(data.pageBar);
			
		},//end of success
		 error : (x,s,e) =>{
		        console.log("실패",x,s,e);
		      }//end of error
	});//end of ajax
};//end of function 	
	
	
	
	
</script>










<jsp:include page="/WEB-INF/views/common/footer.jsp" />