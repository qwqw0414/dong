<%@page import="java.util.Map"%>
<%@page import="com.pro.dong.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 
<jsp:include page="/WEB-INF/views/common/header.jsp" />







<div id="charging_">	
<div class="container">
  <div class="row justify-content-md-center">
	<span>검색조건</span>
    <div class="col col-lg-2">
     <input type="text" class='form-control' id="startDate" placeholder='시작날짜선택' readonly>
    </div>
    <span>~</span>
    <div class="col-md-auto">
     <input type="text" class='form-control'id="endDate" placeholder='종료날짜선택' readonly>
    </div>
     <div class="col col-lg-2">
      <select id="inputState" class="form-control">
        <option selected>전체</option>
        <option>충전</option>
        <option>사용</option>
      </select>
      
    </div>
      <input type="button" class='btn btn-secondary' value='검색' onclick='selectByOption(1)'/>
  </div>
  <br />
<br />
</div>
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
			html+="<table class='table table-hover'>";
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
				html+="<th scope='row'>"+(i+1+((cPage-1)*10))+"</th>";				
				html+="<td>"+data.list[i].REG_DATE+"</td>";
				html+="<td>"+numberComma(data.list[i].POINT_AMOUNT)+"원</td>";
				if(data.list[i].STATUS=='I'){
				html+="<td>충전</td>";
				}
				else{
					html+="<td>사용</td>";
				}
			html+="</tbody>";
			}//end of for
			
			html+="</table>";
			html+="</div>";
			
			$("#chargingDetails").html(html);
			$("#charging_ #pageBar").html(data.pageBar);
			
		},//end of success
		 error : (x,s,e) =>{
		        console.log("실패",x,s,e);
		      },//end of error
		      complete: ()=>{
	                $("#pageBar a").click((e)=>{
	                	showchargingDetails($(e.target).siblings("input").val());
	                });
	            }//end of complete
	});//end of ajax
};//end of function 	
	
	
	
function selectByOption(cPage){
	var start = $("#startDate").val();
	var end = $("#endDate").val();
	var option = "";
	if($("#inputState").val()=="충전"){
		option = "I";
	}
	else if($("#inputState").val()=="사용"){
		option = "O";
	}
	else 
		option="";
	
	console.log(start);
	console.log(end);
	console.log(option);
	console.log(cPage)
	
	
	$.ajax({
		url: "${pageContext.request.contextPath}/member/selectByOption",
		data:{
			cPage:cPage,
			start:start,
			end:end,
			option:option
		},
		type:"GET",
		dataType:"json",
		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		success:data=>{
			console.log(data);
			let html="";
			html+="<div id='detailList'>";
			html+="<table class='table table-hover'>";
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
				html+="<th scope='row'>"+(i+1+((cPage-1)*10))+"</th>";				
				html+="<td>"+data.list[i].REG_DATE+"</td>";
				html+="<td>"+numberComma(data.list[i].POINT_AMOUNT)+"원</td>";
				if(data.list[i].STATUS=='I'){
				html+="<td>충전</td>";
				}
				else{
					html+="<td>사용</td>";
				}
			html+="</tbody>";
			}//end of for
			
			html+="</table>";
			html+="</div>";
			
			$("#chargingDetails").html(html);
			$("#charging_ #pageBar").html(data.pageBar);
			
		},//end of success
		 error : (x,s,e) =>{
		        console.log("실패",x,s,e);
		      },//end of error
		      complete: ()=>{
	                $("#pageBar a").click((e)=>{
	                	showchargingDetails($(e.target).siblings("input").val());
	                });
	            }//end of complete
	});//end of ajax
	
	
};//end of function

	
//숫자 컴마 함수
function numberComma(num) {
    return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
  }

	
	
	
</script>







<!-- 달력 스크립트 -->
<script type="text/javascript">
  $(document).ready(function () {
          $.datepicker.setDefaults($.datepicker.regional['ko']); 
          $( "#startDate" ).datepicker({
               changeMonth: true, 
               changeYear: true,
               nextText: '다음 달',
               prevText: '이전 달', 
               dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
               dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], 
               monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
               monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
               dateFormat: "yymmdd",
               maxDate: 0,                       // 선택할수있는 최소날짜, ( 0 : 오늘 이후 날짜 선택 불가)
               onClose: function( selectedDate ) {    
                    //시작일(startDate) datepicker가 닫힐때
                    //종료일(endDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
                   $("#endDate").datepicker( "option", "minDate", selectedDate );
               }    

          });
          $( "#endDate" ).datepicker({
               changeMonth: true, 
               changeYear: true,
               nextText: '다음 달',
               prevText: '이전 달', 
               dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
               dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], 
               monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
               monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
               dateFormat: "yymmdd",
               maxDate: 0,                       // 선택할수있는 최대날짜, ( 0 : 오늘 이후 날짜 선택 불가)
               onClose: function( selectedDate ) {    
                   // 종료일(endDate) datepicker가 닫힐때
                   // 시작일(startDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 시작일로 지정
                   $("#startDate").datepicker( "option", "maxDate", selectedDate );
               }    

          });    
  });
</script>










<jsp:include page="/WEB-INF/views/common/footer.jsp" />