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

.marker-info { cursor: pointer; font-size: 11px; font-weight: 600; font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif; line-height: 1.5; padding: 5px; }

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
		<p> 주소로 마커  표시 : 파라미터에 libraries=services 필요</p>
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
	var mapOption = {
		center: new kakao.maps.LatLng(37.557714093880406, 126.92450981105797),  // 지도의 중심좌표 : 위도(latitude), 경도(longitude)
		level: 3  // 지도의 레벨(확대, 축소 정도)
	};
	
	// 지도를 생성
	var map = new kakao.maps.Map(mapContainer, mapOption);
	
	// 주소-좌표 변환 객체를 생성
	var geocoder = new kakao.maps.services.Geocoder();
	
	// AJAX - 마커를 출력할 위도/경도 및 제목을 불러오기
	var url = "${pageContext.request.contextPath}/maps/regions";
	var query = null;
	var fn = function(data) {
		createMarker(data);
	}
	ajaxFun(url, "get", query, "json", fn);

	function createMarker(data) {
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

			        // 인포윈도우로 장소에 대한 설명을 표시
			        var infowindow = new kakao.maps.InfoWindow({
			        	content:"<div class='marker-info'>"+subject+"</div>"
			        });

			        // 지도의 중심을 결과값으로 받은 위치로 이동
			        // map.setCenter(coords);
			        
				    kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
				    kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));			        
			    } 
			});
			
		});
		
		// 인포윈도우를 표시하는 클로저를 만드는 함수
		function makeOverListener(map, marker, infowindow) {
		    return function() {
		        infowindow.open(map, marker);
		    };
		}

		// 인포윈도우를 닫는 클로저를 만드는 함수
		function makeOutListener(infowindow) {
		    return function() {
		        infowindow.close();
		    };
		}			
		
	}
</script>
	
</body>
</html>