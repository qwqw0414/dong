<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ea166326e5dc5657d4a2feb24b4cfe0b&libraries=services"></script>
<style>
	.map_wrap {position:relative;width:100%;height:300px;}
	.title {font-weight:bold;display:block;}
	.hAddr {position:absolute;left:10px;top:10px;border-radius: 2px;background:#fff;background:rgba(255,255,255,0.8);z-index:1;padding:5px;}
</style>


<div class="modal fade " id="addressModal"  role="dialog" aria-labelledby="addressModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header ">
        <h5 class="modal-title " id="addressModalLabel"  >주소 수정하기</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
   		
   		<div class="modal-body">
			<button id="btn-searchAddress" class="btn btn-info btn-block">위치 검색</button>
       		<button id="btn-zipcode"  class="btn btn-info btn-block">우편번호 검색</button>
        	
        	<div class="input-group">
            	<input type="text" id="sido" name="sido" class="form-control form-control text-center" readonly>
            	<input type="text" id="sigungu" name="sigungu" class="form-control form-control text-center" readonly>
            	<input type="text" id="dong"  name="dong" class="form-control form-control text-center" readonly>
        	</div>
       		<div class="map_wrap">
            	<div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
            		<div class="hAddr">
                		<span class="title">지도중심기준 행정동 주소정보</span>
                		<span id="centerAddr"></span>
           		   </div>
        	</div>   	
        	<div class="text-center">
        	<button id="AddressUpdate" class="btn btn-outline-success btn-sm" >주소 변경하기</button>
        	<button type="button" class="btn btn-outline-danger btn-sm" data-dismiss="modal">취소</button>
        	</div>
        			
   	   </div>   
      
     </div>
     
   </div>
    
 </div>
   
<script>
$(()=>{
	var $sido = $("#sido");
    var $sigungu = $("#sigungu");
    var $dong = $("#dong");
    
	/* 우편번호 검색  */
	$("#btn-zipcode").click(()=>{
		new daum.Postcode({
    	    oncomplete: function(data) {
    	   
    	     document.getElementById('sido').value = data.sido;
             document.getElementById("sigungu").value = data.sigungu;
             document.getElementById("dong").value = data.bname; 
    	    }
    	}).open();
		$("#map").hide();
		$("#centerAddr").hide();
	});
	
	// 위치 정보 저장하기
    function setAddress(address){
        addrArr = address.split(" ");
        console.log(addrArr);
        
        var dongIndex = 0;

        addrArr.forEach(addr => {
            dongIndex++;
            if(addr.substr(addr.length-1,1)=='동'){
                console.log(addr);
                return;
            }
        });

        $sido.val(addrArr[0]);
        $sigungu.val(addrArr[1]);
        $dong.val(addrArr[dongIndex-1]);
    }
	
	$("#addressModal #btn-searchAddress").click(()=>{
        var latitude;
        var longitude;
    
        if(navigator.geolocation){
            navigator.geolocation.getCurrentPosition(function(position){
                latitude = position.coords.latitude;
                longitude = position.coords.longitude;
    
                console.log(latitude);
                console.log(longitude);
    
                kakoMap(latitude,longitude);
            });
        }else{
            alert("gps를 지원하지 않는 브라우저 입니다. 크롬을 사용하거라.")
        }
    	$("#map").show();
    	$("centerAddr").show();
    });
	
	function kakoMap(latitude,longitude){
	    
        var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
        mapOption = {
            center: new kakao.maps.LatLng(latitude, longitude), // 지도의 중심좌표
            level: 5 // 지도의 확대 레벨
        };  
    
        // 지도를 생성합니다    
        var map = new kakao.maps.Map(mapContainer, mapOption); 
    
        // 주소-좌표 변환 객체를 생성합니다
        var geocoder = new kakao.maps.services.Geocoder();
    
        var marker = new kakao.maps.Marker(), // 클릭한 위치를 표시할 마커입니다
            infowindow = new kakao.maps.InfoWindow({zindex:1}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다
    
        // 현재 지도 중심좌표로 주소를 검색해서 지도 좌측 상단에 표시합니다
        searchAddrFromCoords(map.getCenter(), displayCenterInfo);
    
        // 지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
        kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
            searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
                if (status === kakao.maps.services.Status.OK) {
                    var detailAddr = !!result[0].road_address ? '<div>도로명주소 : ' + result[0].road_address.address_name + '</div>' : '';
                    detailAddr += '<div>지번 주소 : ' + result[0].address.address_name + '</div>';
                    
                    var content = '<div class="bAddr">' +
                                    '<span class="title">법정동 주소정보</span>' + 
                                    detailAddr + 
                                '</div>';
    
                    // 마커를 클릭한 위치에 표시합니다 
                    marker.setPosition(mouseEvent.latLng);
                    marker.setMap(map);
    
                    // 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
                    infowindow.setContent(content);
                    infowindow.open(map, marker);
                }   
            });
        });
    
        // 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
        kakao.maps.event.addListener(map, 'idle', function() {
            searchAddrFromCoords(map.getCenter(), displayCenterInfo);
        });
    
        function searchAddrFromCoords(coords, callback) {
            // 좌표로 행정동 주소 정보를 요청합니다
            geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
        }
    
        function searchDetailAddrFromCoords(coords, callback) {
            // 좌표로 법정동 상세 주소 정보를 요청합니다
            geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
        }
    
        // 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
        function displayCenterInfo(result, status) {
            if (status === kakao.maps.services.Status.OK) {
                var infoDiv = document.getElementById('centerAddr');
    
                for(var i = 0; i < result.length; i++) {
                    // 행정동의 region_type 값은 'H' 이므로
                    if (result[i].region_type === 'H') {
                        infoDiv.innerHTML = result[i].address_name;
                        setAddress(result[i].address_name);
                        break;
                    }
                }
            }    
        }
    }
	//주소변경
	$("#AddressUpdate").click(()=>{
		
		$.ajax({
			url: "${pageContext.request.contextPath}/member/updateAddress",
			data: {sido: $sido.val(),
				   sigungu: $sigungu.val(),
				   dong: $dong.val()},
		 	dataType:"POST",
		 	success: data =>{
		 		console.log(data);	
		 		$("#updateAddress").text(data.SIDO);
		 	},
		 	error: (x,s,e) =>{
		 		console.log("실패", x,s,e);
		 		
		 	}
			
		})
		
	});
	
});



</script>  

  












	
