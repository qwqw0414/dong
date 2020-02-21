<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<style>
</style>


<button id="insertHallOfFame">산정하기</button>

<div id="kingOfDongnae-wrapper">
    <h1 class="text-center"><span id="isMonth"></span>월 동네왕</h1>
    <hr class="divide-main">
	<div class="card-deck">
	  <div class="card" id="silverCard">
	    <img src="/dong/resources/images/silverMedal.png" class="card-img-top" alt="...">
	    <div class="card-body">
	      <h5 class="card-title text-center" id="silverTitle"></h5>
	    </div>
	  </div>
	  <div class="card" id="goldCard">
	    <img src="/dong/resources/images/goldMedal.png" class="card-img-top" alt="...">
	    <div class="card-body">
	      <h5 class="card-title text-center" id="goldTitle"></h5>
	    </div>
	  </div>
	  <div class="card" id="bronzeCard">
	    <img src="/dong/resources/images/bronzeMedal.png" class="card-img-top" alt="...">
	    <div class="card-body">
	      <h5 class="card-title text-center" id="bronzeTitle"></h5>
	    </div>
	  </div>
	</div>
</div>
<div id="hallOfFame-wrapper" class="mx-auto">
	<div class="card mb-3" id="hallOfFameCard">
		<img src="/dong/resources/images/ranking.png" class="card-img-top"
			alt="..." id="hallOfFameHeaderImg">
		<div class="card-body">
			<h5 class="card-title text-center" id="hallOfFameTitle">명예의 전당</h5>
			<div id="hallOfFameBody"></div>
		</div>
		<div id="hallOfFamePageBar"></div>
	</div>
</div>
<script>
$(()=>{

    listLoad(3,2020,1);
    loadHallOfFame(1);
    function listLoad(rank,year,month){

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
				html += "<span id='goldSido'>"+data[0].SIDO+"</span>&nbsp;<span id='goldSigungu'>"+data[0].SIGUNGU+"</span>&nbsp;<span id='goldDong'>"+data[0].DONG+"</span>&nbsp;<small>("+data[0].CNT+"건)</small>";
				$("#goldTitle").html(html);
				html = "";
				html += "<span id='silverSido'>"+data[1].SIDO+"</span>&nbsp;<span id='silverSigungu'>"+data[1].SIGUNGU+"</span>&nbsp;<span id='silverDong'>"+data[1].DONG+"</span>&nbsp;<small>("+data[1].CNT+"건)</small>";
				$("#silverTitle").html(html);
				html = "";
				html += "<span id='bronzeSido'>"+data[2].SIDO+"</span>&nbsp;<span id='bronzeSigungu'>"+data[2].SIGUNGU+"</span>&nbsp;<span id='bronzeDong'>"+data[2].DONG+"</span>&nbsp;<small>("+data[2].CNT+"건)</small>";
				$("#bronzeTitle").html(html);
                $("#kingOfDongnae-wrapper #isMonth").text(month);
            },
            error:(a,b,c)=>{
                console.log(a,b,c);
            }
        });
    }// end of listLoad
    
    $("#insertHallOfFame").on('click',function(){
    	insertHallOfFame();
    });
    
    function loadHallOfFame(cPage){
    	$.ajax({
    		url: "${pageContext.request.contextPath}/research/loadHallOfFame",
    		type: "GET",
    		success:data=>{
				console.log(data);
				let html = "";
				html += "<div class='card' style='width: 18rem;'>";
				html += " <div class='card-body'><h5 class='card-title'>"+yearAndMonth(data.HallOfFameList[0].AWARD_DATE)+"</h5>";
				for(var i=0; i<data.HallOfFameList.length;i++){
				html += "<span>"+data.HallOfFameList[i].SIDO+"</span>&nbsp;<span>"+data.HallOfFameList[i].SIGUNGU+"</span>&nbsp;<span>"+data.HallOfFameList[i].DONG+"</span>&nbsp;<small>";
				if("G"==(data.HallOfFameList[i].BADGE_TYPE)){
				html += "<img class='badgeTypeImg' src='/dong/resources/images/goldMedal.png'></small><br>";					
				} else if("S"==(data.HallOfFameList[i].BADGE_TYPE)){
					html += "<img class='badgeTypeImg' src='/dong/resources/images/silverMedal.png'></small><br>";					
				} else {
					html += "<img class='badgeTypeImg' src='/dong/resources/images/bronzeMedal.png'></small><br>";
				}
				}
				html+="</div></div>";
				
				$("#hallOfFameBody").html(html);
				$("#hallOfFamePageBar").html(data.pageBar);
			},
			error:(a,b,c)=>{
	            console.log(a,b,c);
	        },
	        complete: ()=>{
	    		 $("#pageBar a").click((e)=>{
	    			 loadHallOfFame($(e.target).siblings("input").val());
	    		});
	    	 }
    	});//end of ajax
    }//end of loadHallOfFame
    
    function insertHallOfFame(){
    	var goldSido = $("#goldSido").text();
    	var silverSido = $("#silverSido").text();
    	var bronzeSido = $("#bronzeSido").text();
    	
    	var goldSigungu = $("#goldSigungu").text();
    	var silverSigungu = $("#silverSigungu").text();
    	var bronzeSigungu = $("#bronzeSigungu").text();
    	
    	var goldDong = $("#goldDong").text();
    	var silverDong = $("#silverDong").text();
    	var bronzeDong = $("#bronzeDong").text();
    	console.log("gold="+goldSido+" "+goldSigungu+" "+goldDong);
    	console.log("silver="+silverSido+" "+silverSigungu+" "+silverDong);
    	console.log("bronze="+bronzeSido+" "+bronzeSigungu+" "+bronzeDong);
    	$.ajax({
    		url: "${pageContext.request.contextPath}/research/insertHallOfFame",
    		data:{goldSido:goldSido,silverSido:silverSido,bronzeSido:bronzeSido,
    			goldSigungu:goldSigungu,silverSigungu:silverSigungu,bronzeSigungu:bronzeSigungu,
    			goldDong:goldDong,silverDong:silverDong,bronzeDong:bronzeDong},
    		success:data=>{
    				console.log(data);
    			},
    		error:(a,b,c)=>{
    	                console.log(a,b,c);
    	        }
    	});//end of ajax
    }//end of insertHallOfFame
    
    function yearAndMonth(date){
    	var preDate = new Date(date);

    	var year = preDate.getFullYear();
    	var month = preDate.getMonth();
    	var date = preDate.getDate();

    	if(month < 10) month = "0"+month;
    	if(date < 10) date = "0"+date;

    	return year+"/"+month;
    }
});

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>