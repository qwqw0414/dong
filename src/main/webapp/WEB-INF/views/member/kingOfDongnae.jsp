<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.1.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/js.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/css.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/animation.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.7.2/animate.min.css">

<div id="kingOfDongnae-wrapper">
	<h1 class="text-center">
		<span id="isMonth"></span>월 동네왕
	</h1>
	<hr class="divide-main">
	<div class="card-deck">
		<div class="card" id="silverCard">
			<img src="/dong/resources/images/silverMedal.png"
				class="card-img-top" alt="...">
			<div class="card-body">
				<h5 class="card-title text-center" id="silverTitle"></h5>
			</div>
		</div>
		<div class="card" id="goldCard">
			<img src="/dong/resources/images/goldMedal.png" class="card-img-top"
				alt="...">
			<div class="card-body">
				<h5 class="card-title text-center" id="goldTitle"></h5>
			</div>
		</div>
		<div class="card" id="bronzeCard">
			<img src="/dong/resources/images/bronzeMedal.png"
				class="card-img-top" alt="...">
			<div class="card-body">
				<h5 class="card-title text-center" id="bronzeTitle"></h5>
			</div>
		</div>
	</div>
</div>
<div class="float-right" id="kingOfDongnae-menu">

<input type="checkbox" name="neverShow" id="neverShow"/>
<label for="neverShow">다시 보지 않기</label>
<button class="btn btn-secondary" id="btn-close">닫기</button>
</div>
<script>
$(()=>{
	var year;
	var month;

	now();

	function now(){
		var now = new Date();
		year = now.getFullYear();
		month = now.getMonth() + 1;

		if(month == 1){
			month = 12;
			year--;
		}
		else{
			month--;
		}
	}

    listLoad(3,year,month);
    function listLoad(rank,year,month){
		console.log(rank, year, month);
        $.ajax({
            url:"${pageContext.request.contextPath}/research/selectTop",
            data:{
                rank:rank,
                year:year,
                month:month
            },
            dataType:"json",
            success:data=>{

            	console.log(data);
                let html = '';
				html += "<span id='goldSido'>"+data.addr[0].SIDO+"</span>&nbsp;<span id='goldSigungu'>"+data.addr[0].SIGUNGU+"</span>&nbsp;<span id='goldDong'>"+data.addr[0].DONG+"</span>&nbsp;<small>("+data.addr[0].AVG+"%)</small>";
				$("#goldTitle").html(html);
				html = "";
				html += "<span id='silverSido'>"+data.addr[1].SIDO+"</span>&nbsp;<span id='silverSigungu'>"+data.addr[1].SIGUNGU+"</span>&nbsp;<span id='silverDong'>"+data.addr[1].DONG+"</span>&nbsp;<small>("+data.addr[1].AVG+"%)</small>";
				$("#silverTitle").html(html);
				html = "";
				html += "<span id='bronzeSido'>"+data.addr[2].SIDO+"</span>&nbsp;<span id='bronzeSigungu'>"+data.addr[2].SIGUNGU+"</span>&nbsp;<span id='bronzeDong'>"+data.addr[2].DONG+"</span>&nbsp;<small>("+data.addr[2].AVG+"%)</small>";
				$("#bronzeTitle").html(html);
                $("#kingOfDongnae-wrapper #isMonth").text(month);
            },
            error:(a,b,c)=>{
                console.log(a,b,c);
            }
        });
    }// end of listLoad
    
	//닫기 버튼 클릭시 팝업 닫기
    $("#btn-close").on('click',function(){
    	close();
    });
 
});
//다시보지않음	
$(function() {
	   var closeToday = $('#neverShow');

	   closeToday.click(function() {
	      setCookie( "popup", "end" , 1);
	      // 하루동안이므로 1을 설정
	      window.close();
	      // 현재 열려있는 팝업은 닫으면서 쿠키값을 저장
	   });
	});
function setCookie(cname, value, expire) {
	   // 오늘 날짜를 변수에 저장
	   var todayValue = new Date();

	   todayValue.setDate(todayValue.getDate() + expire);
	   document.cookie = cname + "=" + encodeURI(value) + "; expires=" + todayValue.toGMTString() + "; path=/;";
	   
	}

</script>