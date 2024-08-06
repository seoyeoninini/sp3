<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>study</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<style type="text/css">
* { padding: 0; margin: 0; }
*, ::after, ::before { box-sizing: border-box; }

body {
	font-family:"Malgun Gothic", "맑은 고딕", NanumGothic, 나눔고딕, 돋움, sans-serif;
	font-size: 14px;
	color: #222;
}

a { color: #222; text-decoration: none; cursor: pointer; }
a:active, a:hover { color: #f28011; text-decoration: underline; }

/* form-control */
.btn {
	color: #333;
	border: 1px solid #999;
	background-color: #fff;
	padding: 5px 10px;
	border-radius: 4px;
	font-weight: 500;
	cursor:pointer;
	font-size: 14px;
	font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
	vertical-align: baseline;
}
.btn:active, .btn:focus, .btn:hover {
	background-color: #f8f9fa;
	color:#333;
}

.form-control {
	border: 1px solid #999; border-radius: 4px; background-color: #fff;
	padding: 5px 5px; 
	font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
	vertical-align: baseline;
}
.form-control[readonly] { background-color:#f8f9fa; }

textarea.form-control { height: 170px; resize : none; }

.form-select {
	border: 1px solid #999; border-radius: 4px; background-color: #fff;
	padding: 4px 5px; 
	font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
	vertical-align: baseline;
}
.form-select[readonly] { background-color:#f8f9fa; }

textarea:focus, input:focus { outline: none; }
input[type=checkbox], input[type=radio] { vertical-align: middle; }

/* table */
.table { width: 100%; border-spacing: 0; border-collapse: collapse; }
.table th, .table td { padding-top: 10px; padding-bottom: 10px; }

.table-border thead > tr { border-top: 2px solid #212529; border-bottom: 1px solid #ced4da; }
.table-border tbody > tr { border-bottom: 1px solid #ced4da; }
.table-border tfoot > tr { border-bottom: 1px solid #ced4da; }

.container { width: 800px; margin: 30px auto; }

.title { width:100%; font-size: 16px; font-weight: bold; padding: 13px 0; }

.main-header { padding: 10px 0 10px; margin-bottom: 10px; }
.main-header p { padding-bottom: 10px; }

.map { width:700px; height:450px; border: 1px solid #777; }

.box{ padding: 10px; text-align: center; }

.marker-info { cursor: pointer; font-size: 11px; font-weight: 600; font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif; line-height: 1.5; padding: 5px; }

.overlaybox { position: absolute; left: 0; bottom: 40px; width: 300px; height: 130px; margin-left: -144px;text-align: left; overflow: hidden; font-size: 12px; font-family: 'Malgun Gothic', dotum, '돋움', sans-serif; line-height: 1.5; }
.overlaybox * { padding: 0;margin: 0; }
.overlaybox .overlay-info { width: 298px; height: 118px; border-radius: 5px; border-bottom: 2px solid #ccc; border-right: 1px solid #ccc; overflow: hidden; background: #fff; }
.overlaybox .overlay-info:nth-child(1) { border: 0; box-shadow: 0px 1px 2px #888; }
.overlay-info .overlay-title { padding: 5px 0 0 10px; height: 30px; background: #f8f9fa; border-bottom: 1px solid #ddd; font-size: 13px; font-weight: bold; }
.overlay-info .close { position: absolute; top: 10px; right: 10px; color: #888; width: 17px; height: 17px; background: url('${pageContext.request.contextPath}/resources/images/close_icon.png'); background-repeat: no-repeat; }
.overlay-info .close:hover { cursor: pointer; }
.overlay-info .overlay-body { position: relative; overflow: hidden; }
.overlay-info .desc { position: relative; margin: 13px 0 0 90px; height: 75px; }
.desc div { padding 3px; }
.desc .ellipsis { overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
.desc .other { font-size: 11px; color: #888; margin-top: -2px; }
.overlay-info .img { position: absolute; top: 6px; left: 5px; width: 73px; height: 71px; border: 1px solid #ddd; color: #888; overflow: hidden; }
.overlay-info:after { content: '';position: absolute; margin-left: -16px; left: 50%; bottom: 0; width: 22px; height: 12px; background: url('${pageContext.request.contextPath}/resources/images/vertex_white.png'); }
.overlay-info .link { color: #333; }
.overlay-info .link:hover { color: #5085BB; }
</style>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

</head>
<body>

<div class="container">
	<div class="title">
	    <h3> 카카오 맵 </h3>
	</div>
	<div class="main-header">
		<p>
			<button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/maps/main';">돌아가기</button>
		</p>
		<p> 카카오 키워드 검색 </p>
	</div>
	<div class="box">
		<p>
			<input type="text" id="keyword" class="form-control">
			<button type="button" class="btn btnSearch"> 검색 </button>
		</p>
	</div>
	
	<div id="map" class="map"></div>
	
</div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3d3ecc0e7b2428718ab1513f8ce6cb86&libraries=services"></script>
<script type="text/javascript">
	var mapContainer = document.getElementById('map');
	var locPosition = new kakao.maps.LatLng(37.557714093880406, 126.92450981105797);
	var mapOption = {
		center: locPosition,  // 지도의 중심좌표 : 위도(latitude), 경도(longitude)
		level: 3  // 지도의 레벨(확대, 축소 정도)
	};

	// 지도를 생성
	var map = new kakao.maps.Map(mapContainer, mapOption);
	
	// 마커를 클릭하면 장소명을 표출할 인포윈도우
	var infowindow = new kakao.maps.InfoWindow({zIndex:1});	
	var markers = [];
	
	$(".btnSearch").on("click", function(){
		var keyword = $("#keyword").val().trim();
		if(! keyword ) {
			$("#keyword").focus();
			return false;
		}
		
		keywordSearch(keyword);
	});
	
	function keywordSearch(keyword) {
		// 장소 검색 객체를 생성
		var ps = new kakao.maps.services.Places(); 

		removeMarker();
		
		// 키워드로 장소를 검색
		ps.keywordSearch(keyword, placesSearchCB); 
	}
	
	// 키워드 검색 완료 시 호출되는 콜백함수
	function placesSearchCB (data, status, pagination) {
	    if (status === kakao.maps.services.Status.OK) {

	        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
	        // LatLngBounds 객체에 좌표를 추가
	        var bounds = new kakao.maps.LatLngBounds();

	        for (var i=0; i<data.length; i++) {
	            displayMarker(data[i]);    
	            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
	        }       

	        // 검색된 장소 위치를 기준으로 지도 범위를 재설정
	        map.setBounds(bounds);
	    } 
	}

	// 지도에 마커를 표시하는 함수
	function displayMarker(place) {
	    // 마커를 생성하고 지도에 표시
	    var marker = new kakao.maps.Marker({
	        map: map,
	        position: new kakao.maps.LatLng(place.y, place.x) 
	    });
	    markers.push(marker);
	    
	    // 마커에 클릭이벤트를 등록
	    kakao.maps.event.addListener(marker, 'click', function() {
	        // 마커를 클릭하면 장소명이 인포윈도우에 표출
	        infowindow.setContent('<div class="marker-info">' + place.place_name + '</div>');
	        infowindow.open(map, marker);
	    });
	}
	
	// 모든  marker 지우기
	function removeMarker() {
		for ( var i = 0; i < markers.length; i++ ) {
    		markers[i].setMap(null);
		}   
		markers = [];
	}
	
</script>
	
</body>
</html>