<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">

<style type="text/css">
* { padding: 0; margin: 0; }
*, *::after, *::before { box-sizing: border-box; }

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
.btn[disabled], fieldset[disabled] .btn {
	pointer-events: none;
	cursor: default;
	opacity: .65;
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
.td-border td { border: 1px solid #ced4da; }

/* container */
.container { width: 800px; margin: 30px auto; }
.title { width:100%; font-size: 16px; font-weight: bold; padding: 13px 0; }

.list-header { padding-top: 25px; padding-bottom: 10px; display: flex; justify-content: space-between; }
.list-header .list-header-left { padding-left: 5px; display: flex; align-items: center; }
.list-header .list-header-right { padding-right: 5px; display: flex; align-items: center; }
.list-content {
	list-style: none; 
	width: 100%;
	margin-top: 3px; margin-bottom: 5px;
	 
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
	gap: 10px;
	justify-content: center;
}

.card { border: 1px solid #ced4da; cursor: pointer; padding: 5px 5px 0; }
.card img { display: block; width: 100%; height: 200px; border-radius: 5px; } /* 이미지 크기를 부모 크기로 */
.card img:hover { scale: 100.7%; } /* 해당 요소를 지정한 크기만큼 확대 또는 축소 */
.card .card-title {
	font-size: 14px;
	font-weight: 500;
	padding: 10px 2px;
	
	width: 175px;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}
</style>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

</head>
<body>


<div class="container">
	<h3 class="title"> 공공 API : JSP 에서 AJAX 로 API 접속 </h3>
	<p> 한국관광공사_관광사진 정보 </p>
	<div style="width: 800px; margin: 10px auto;">
		<div class="list-header">
			<span class="list-header-left">
				<input type="text" id="keyword" class="form-control">
				<button type="button" class="btn btnSearch">검색</button>
			</span>
			<span class="list-header-right"></span>
		</div>	
		<ul class="list-content"></ul>
	</div>
	
</div>

<script type="text/javascript">
function ajaxFun(url, method, formData, dataType, fn, file = false) {
	const settings = {
			type: method, 
			data: formData,
			dataType:dataType,
			success:function(data) {
				fn(data);
			},
			beforeSend: function(jqXHR) {
			},
			complete: function () {
			},
			error: function(jqXHR) {
				console.log(jqXHR.responseText);
			}
	};
	
	if(file) {
		settings.processData = false;  // file 전송시 필수. 서버로전송할 데이터를 쿼리문자열로 변환여부
		settings.contentType = false;  // file 전송시 필수. 서버에전송할 데이터의 Content-Type. 기본:application/x-www-urlencoded
	}
	
	$.ajax(url, settings);
}

$(function(){
	searchTour('서울');
	
	$(".btnSearch").click(function(){
		let keyword = $("#keyword").val().trim();
		
		if(! keyword) {
			return false;
		}
		
		searchTour(keyword);
	});
	
	function searchTour(keyword = '서울') {
		let spec = "http://apis.data.go.kr/B551011/PhotoGalleryService1/gallerySearchList1";
		let serviceKey = "p7n6IP102nDf2VS2RR0lUwD%2BUcwvFfKW8fbSebL2ZZX9x3L1O%2F157yGNVlwKCUgjarfOff2ZTVvgUkGAs9xkvw%3D%3D";
			
		let numOfRows = 16; // 한페이지 결과수
		let pageNo = 1; // 페이지 번호
		let _type = "json";
		let MobileOS = "ETC";
		let MobileApp ="spring";
		let arrange = "C";
		
		let query = "serviceKey=" + serviceKey;
		query += "&numOfRows=" + numOfRows;
		query += "&pageNo=" + pageNo;
		query += "&_type=" + _type;
		query += "&MobileOS=" + MobileOS;
		query += "&MobileApp=" + MobileApp;
		query += "&arrange=" + arrange;
		query += "&keyword=" + encodeURIComponent(keyword);
		query += "&_type=" + _type;
		
		const fn = function(data) {
			$('.list-content').empty();
			
			printJSON(data);
		};
			
		ajaxFun(spec, "get", query, "json", fn);
	}
	
	function printJSON(data) {
		// console.log(data);
		
		if(! data.response.body.items) {
			alert('데이터가 존재하지 않습니다.');
			return;
		}
		
		let numOfRows = data.response.body.numOfRows;
		let pageNo = data.response.body.pageNo;
		let totalCount = data.response.body.totalCount;
		
		let list = data.response.body.items.item;
		
		$('.list-header-right').html('검색 결과 : ' + totalCount + '개');
		
		let htmlText;
		for(let item of list) {
			let galTitle = item.galTitle;
			let galPhotographyLocation = item.galPhotographyLocation;
			let galWebImageUrl = item.galWebImageUrl;
			
			htmlText =  '<li class="card">';
			htmlText += '    <img src="' + galWebImageUrl + '">';
			htmlText += '    <p class="card-title">'+ galTitle + '</p>';
			htmlText += '</li>';
			
			$('.list-content').append(htmlText);		
		}
		
	}
});
</script>

</body>
</html>