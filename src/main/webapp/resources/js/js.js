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
