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
</style>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

</head>
<body>


<div class="container">
	<h3 class="title"> 공공 API : JSP 에서 AJAX 로 API 접속 </h3>
	
	<div>
		<p style="margin-bottom: 5px;">
			<select id="selectRegion" class="form-select">
				<option data-nx="59" data-ny="126">마포구 서교동</option>
				<option data-nx="61" data-ny="125">강남구 역삼동</option>
				<option data-nx="60" data-ny="127">강북구 성북동</option>
			</select>
		</p>
		<p>
			<button type="button" class="btn btnWeather">날씨 XML</button>
			<button type="button" class="btn btnWeather2">날씨 JSON</button>
		</p>
	</div>
	
	<br> <hr> <br>
	
	<div class="resultLayout"></div>	
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
	$(".btnWeather").click(function(){
		let spec = "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst";
		let serviceKey = "p7n6IP102nDf2VS2RR0lUwD%2BUcwvFfKW8fbSebL2ZZX9x3L1O%2F157yGNVlwKCUgjarfOff2ZTVvgUkGAs9xkvw%3D%3D";
		
		let numOfRows = 10; // 한페이지 결과수
		let pageNo = 1; // 페이지번호
		let dataType = "XML"; // XML 또는 JSON, 기본:XML
		let base_date = "20240712";
		let base_time = "0900";
		// let nx = "59"; // 격자 x
		// let ny = "126" // 격자 y
		let nx = $("#selectRegion option:selected").attr("data-nx");
		let ny = $("#selectRegion option:selected").attr("data-ny");

		let query = "serviceKey="+serviceKey;
		query += "&numOfRows="+numOfRows+"&pageNo="+pageNo;
		query += "&base_date="+base_date+"&base_time="+base_time;
		query += "&nx="+nx+"&ny="+ny;
		query += "&dataType="+dataType;

		const fn = function(data) {
			// console.log(data);
			
			printXML(data);
		};
		
		ajaxFun(spec, "get", query, "xml", fn);
		
	});
	
	function printXML(data) {
		if( ! $(data).find("body") ) {
			alert("데이터가 존재하지 않습니다.");
			return;
		}
		
		let out = "<h3>날씨 - 초단기 실황 조회(XML)</h3>";
		
		$(data).find("item").each(function(){
			let item = $(this);
			let baseDate = item.find("baseDate").text();
			let baseTime = item.find("baseTime").text();
			let category = item.find("category").text();
			let obsrValue = item.find("obsrValue").text();
			
			if(category === "PTY") {
				// 강수형태-0:없음,1:비,2:눈/비,3:눈,4:소나기
			} else if(category === "REH") {
				// 습도
			} else if(category === "RN1") {
				// 강수량-0:없음,1:1mm이하,5:1~4mm,10:5~9,20:10~19,40:20~39,70:40~69,100:100mm이상
			} else if(category === "T1H") {
				// 섭씨온도
				out += "<p>섭씨온도 : " + obsrValue +"</p>";
			} else if(category === "UUU") {
				// 동서바람성분
			} else if(category === "VEC") {
				// 풍향
			} else if(category === "VVV") {
				// 남북바람성분
			} else if(category === "WSD") {
				// 풍속
			}
		});
		
		$(".resultLayout").html(out);
	}
	
});

$(function(){
	$(".btnWeather2").click(function(){
		let spec = "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst";
		let serviceKey = "s2xXqG3w8vjfTN6o2z%2FcgxYXULB1RVLnE%2Bv6EIyicnSxy1slQrHfZMTiq3zZxjyiPSZvMnRCEepFB1CXj2oAGw%3D%3D";
		
		let numOfRows = 10; // 한페이지 결과수
		let pageNo = 1; // 페이지번호
		let dataType = "JSON";
		let base_date = "20240712";
		let base_time = "0900";
		// let nx = "59"; // 격자 x
		// let ny = "126" // 격자 y
		let nx = $("#selectRegion option:selected").attr("data-nx");
		let ny = $("#selectRegion option:selected").attr("data-ny");

		let query = "serviceKey="+serviceKey;
		query += "&numOfRows="+numOfRows+"&pageNo="+pageNo;
		query += "&base_date="+base_date+"&base_time="+base_time;
		query += "&nx="+nx+"&ny="+ny;
		query += "&dataType="+dataType;

		const fn = function(data) {
			printJSON(data);
		};
		
		ajaxFun(spec, "get", query, "json", fn);

	});
	
	function printJSON(data) {
		// console.log(data);
		
		if( ! "body" in data.response ) {
			alert("데이터가 존재하지 않습니다.");
			return;
		}
		
		let out = "<h3>날씨 - 초단기 실황 조회(JSON)</h3>";
		
		let list = data.response.body.items.item;
		let category;
		let obsrValue;
		
		for(let item of list) {
			category = item.category;
			obsrValue = item.obsrValue;
			
			if(category === "PTY") {
				// 강수형태
			} else if(category === "RN1") {
				// 강수량
			} else if(category === "T1H") {
				// 섭씨온도
				out += "<p>섭씨온도 : " + obsrValue +"</p>";
			}
		}
		
		$(".resultLayout").html(out);
	}
});

</script>

</body>
</html>