/**
 * 공통 자바 스크립트
 */

// API ========================



// ============================

// 위치 좌표 호출
function getLocation() {
    var result;
    if (navigator.geolocation) { // GPS를 지원하면
        navigator.geolocation.getCurrentPosition(function (position) {
            result = position;
        }, function (error) {
            console.error(error);
        }, {
            enableHighAccuracy: false,
            maximumAge: 0,
            timeout: Infinity
        });
    } else {
        alert('GPS를 지원하지 않습니다');
    }
    console.log(result);
    return result;
}

function numberComma(num) {
    return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
  }

function lastDate(date){
var regDate = new Date(date);
var now = new Date();

var diffHour = Math.ceil((now.getTime() - regDate.getTime())/60000/60) - 9;

if(diffHour > 23){
    return Math.floor(diffHour/24)+"일 전";
}

return diffHour+"시간 전";
}

function life(date){
	var preDate = new Date(date);

	var year = preDate.getFullYear();
	var month = preDate.getMonth()+1;
	var date = preDate.getDate();

	if(month < 10) month = "0"+month;
	if(date < 10) date = "0"+date;

	return year+"/"+month+"/"+date;
}