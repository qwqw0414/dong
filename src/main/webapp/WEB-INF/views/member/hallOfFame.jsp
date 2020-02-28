<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<div id="hallOfFame-wrapper" class="mx-auto">
	<div class="card mb-3" id="hallOfFameCard">
		<img src="/dong/resources/images/ranking.png" class="card-img-top"
			alt="..." id="hallOfFameHeaderImg">
		<div class="card-body">
			<h5 class="card-title text-center" id="hallOfFameTitle">명예의 전당</h5>
			<div id="hallOfFameBody" class="float-left"></div>
		</div>
		<div id="hallOfFamePageBar"></div>
	</div>
</div>

<script>
$(()=>{
    loadHallOfFame(1);

    function loadHallOfFame(cPage){
    	$.ajax({
    		url: "${pageContext.request.contextPath}/research/loadHallOfFame",
    		type: "GET",
    		data:{cPage:cPage},
    		success:data=>{
				console.log(data);
			    let html = "";
			    for(var i=0; i<data.HallOfFameList.length;i++){
			        	if(i==0||i%3==0){
			            html += "<div class='card hof-each' style='width: 18rem;'><div class='card-body'><h5 class='card-title'>"+yearAndMonth(data.HallOfFameList[i].AWARD_DATE)+"</h5>";  
			        	}
				        	if('1G'===data.HallOfFameList[i].BADGE_TYPE){
				        	html += "<small><img class='badgeTypeImg' src='/dong/resources/images/goldMedal.png'></small>";					
				        	} else if('2S'===(data.HallOfFameList[i].BADGE_TYPE)){
				        	html += "<small><img class='badgeTypeImg' src='/dong/resources/images/silverMedal.png'></small>";					
				        	} else {
				        	html += "<small><img class='badgeTypeImg' src='/dong/resources/images/bronzeMedal.png'></small>";
				        	}
			       		html += "<span class='addr-gold'>"+data.HallOfFameList[i].SIDO+"</span>&nbsp;<span class='addr-gold'>"+data.HallOfFameList[i].SIGUNGU+"</span>&nbsp;<span class='addr-gold'>"+data.HallOfFameList[i].DONG+"</span><br>";			       		
			        	if(i==2||i%3==2){
			        	html += "</div></div>";  
			        	}            
			    	}
				$("#hallOfFameBody").html(html);
				$("#hallOfFamePageBar").html(data.pageBar);
			},
			error:(a,b,c)=>{
	            console.log(a,b,c);
	        },
	        complete: ()=>{
	    		 $("#hallOfFamePageBar a").click((e)=>{
	    			 loadHallOfFame($(e.target).siblings("input").val());
	    		});
	    	 }
    	});//end of ajax
    }//end of loadHallOfFame

    function yearAndMonth(date){
    	var preDate = new Date(date);
    	var year = preDate.getFullYear();
    	var month = preDate.getMonth();
    	var date = preDate.getDate();
    	
		if(month==0){
			year--;
			month = 12;
		}
    	if(month < 10) month = "0"+month;
    	if(date < 10) date = "0"+date;

    	return year+"/"+month;
    }
});

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>