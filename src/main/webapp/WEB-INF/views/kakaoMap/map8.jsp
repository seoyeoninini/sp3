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
		<p> 주소로 마커  표시, 검색 : 파라미터에 libraries=services 필요</p>
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
function ajaxFun(url, method, query, dataType, fn) {
	$.ajax({
		type:method,
		url:url,
		data:query,
		dataType:dataType,
		success:function(data) {
			fn(data);
		},
		beforeSend:function(jqXHR) {
			jqXHR.setRequestHeader("AJAX", true);
		},
		error:function(jqXHR) {
			if(jqXHR.status === 400) {
				alert("요청 처리가 실패 했습니다.");
				return false;
			}

			console.log(jqXHR.responseText);
		}
	});
}
</script>

<script type="text/javascript">
	var mapContainer = document.getElementById('map');
	var locPosition = new kakao.maps.LatLng(37.557714093880406, 126.92450981105797);
	var mapOption = {
		center: locPosition,  // 지도의 중심좌표 : 위도(latitude), 경도(longitude)
		level: 3  // 지도의 레벨(확대, 축소 정도)
	};

	// 지도를 생성
	var map = new kakao.maps.Map(mapContainer, mapOption);
	
	// Chrome 브라우저는 https 환경에서만 geolocation을 지원할 수 있음
	// IP 기반 위도, 경도 받아오기
	if (navigator.geolocation) {
		// GeoLocation을 이용해서 접속 위치를 얻어 오기
	    navigator.geolocation.getCurrentPosition(function(position) {
	        
	        var lat = position.coords.latitude, // 위도
	            lon = position.coords.longitude; // 경도
	        
	        locPosition = new kakao.maps.LatLng(lat, lon); // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성
	        
	        // 지도의 중심을 현재 위치 정보로 변경
	        map.setCenter(locPosition);
	    });
	}

	// 주소 - 좌표 변환 객체를 생성
	var geocoder = new kakao.maps.services.Geocoder();

	// AJAX - 마커를 출력할 위도/경도 및 제목을 불러오기
	var url = "${pageContext.request.contextPath}/maps/regions";
	var query = null;
	var fn = function(data) {
		createMarker(data);
	}
	ajaxFun(url, "get", query, "json", fn);

	// 마커를 담을 배열
	var markers = [];
	// 인포 윈도우를 담을 배열
	var infoWinArray = [];
	
	function createMarker(data) {
		// 모든 마커 지우기
		removeMarker();
		
		$(data.list).each(function(index, item){
			var num = item.num;
			var subject = item.subject;
			var addr = item.addr;

			// 주소로 마커 찍기
			geocoder.addressSearch(addr, function(result, status) {

			    // 정상적으로 검색이 완료됐으면 
			     if (status === kakao.maps.services.Status.OK) {

			        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

			        // 결과값으로 받은 위치를 마커로 표시
			        var marker = new kakao.maps.Marker({
			            map: map,
			            position: coords
			        });
			        markers.push(marker);
			        
			        // 인포 윈도우로 장소에 대한 설명을 표시
			        var infowindow = new kakao.maps.InfoWindow({
			        	content:"<div class='marker-info' data-num='"+num+"'>"+subject+"</div>"
			        	 ,removable: true // 인포윈도우를 닫을 수 있는 x버튼이 표시
			        });
			        infoWinArray.push(infowindow);
			        
			        if(infoWinArray.length == 1) {
			        	map.setCenter(coords);
			        }
			        
				    // 마커에 click 이벤트를 등록
				    kakao.maps.event.addListener(marker, 'click', makeClickListener(map, marker, infowindow));
			    } 
			});

		});
		
		function makeClickListener(map, marker, infowindow) {
		    return function() {
		    	closeInfoWindow();
		    	
		    	infowindow.open(map, marker);
		    };
		}
		
		// 모든 infoWindow 닫기
		function closeInfoWindow() {
		    for(var idx = 0; idx < infoWinArray.length; idx++){
		        infoWinArray[idx].close();
		    }
		}

		// 모든  marker 지우기
		function removeMarker() {
			// infoWindow 초기화
			closeInfoWindow();
			infoWinArray = [];
			
    		for ( var i = 0; i < markers.length; i++ ) {
        		markers[i].setMap(null);
    		}   
    		markers = [];
		}
		
		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
			// 지도의 다른 영역을 클릭한 경우
			closeInfoWindow();
		});

	}
	
	$("body").on("click", ".marker-info", function(){
		var num = $(this).attr("data-num");
		alert(num);
	});
	
	$(".btnSearch").on("click", function(){
		var keyword = $("#keyword").val().trim();
		var query = "keyword=" + encodeURIComponent(keyword);
		var url = "${pageContext.request.contextPath}/maps/regions";
		var fn = function(data) {
			createMarker(data);
		}
		ajaxFun(url, "get", query, "json", fn);
	});
	
</script>
	
</body>
</html>