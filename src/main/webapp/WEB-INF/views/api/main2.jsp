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
	<h3 class="title"> 자바 XML/JSON 문서 </h3>
	
	<div style="width: 95%;margin-top: 5px; margin-bottom: 5px;">
     	<p style="padding: 5px;">
     		<button type="button" id="btnXmlZip" class="btn">우편번호-XML로 받기</button>
     		<button type="button" id="btnJsonZip" class="btn">우편번호-JSON으로 받기</button>
     	</p>
     	<p style="padding: 5px;">
     		<button type="button" id="btnWeather1" class="btn">날씨-초단기 실황 조회</button>
     		<button type="button" id="btnWeather2" class="btn">날씨-초단기 예보 조회</button>
     		<button type="button" id="btnWeather3" class="btn">날씨-단기 예보 조회</button>

     		<button type="button" id="btnWeather4" class="btn">날씨-지역날씨</button>
     	</p>
	</div>

	<div id="resultLayout" style="width: 95%;"></div>	
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
	// 우편번호-XML로 받아 오기
	$("#btnXmlZip").click(function(){
		let url = "${pageContext.request.contextPath}/api/xmlZip";
		let search = "세종로 17";
		search = encodeURIComponent(search);
		let query="search="+search;
		
		const fn = function(data) {
			// console.log(data);
			printZip(data);
		};
		
		ajaxFun(url, "get", query, "xml", fn);
	});
	
	function printZip(data){
		let out = "<h3>우편번호-XML</h3><hr>";
		
		$(data).find("newAddressListAreaCd").each(function(){
			let item = $(this);
			let zipNo = item.find("zipNo").text();
			let lnmAdres = item.find("lnmAdres").text();
			let rnAdres = item.find("rnAdres").text();
			
			out += "우편번호:"+zipNo+"<br>";
			out += "도로명주소:"+lnmAdres+"<br>";
			out += "지번:"+rnAdres+"<br><hr>";
		});
		$("#resultLayout").html(out);
	}
});

$(function(){
	// 우편번호-JSON으로 받아 오기
	$("#btnJsonZip").click(function(){
		let url = "${pageContext.request.contextPath}/api/jsonZip";
		let search = "세종로 17";
		search = encodeURIComponent(search);
		let query = "search="+search;
		
		const fn = function(data) {
			// console.log(data);
			printZip(data);
		};
		
		ajaxFun(url, "get", query, "json", fn);
	});
	
	function printZip(data){
		let out = "<h3>우편번호-JSON</h3><hr>";
		
		if(data.NewAddressListResponse.newAddressListAreaCd.length) {
			$.each(data.NewAddressListResponse.newAddressListAreaCd, function(index, item){
				let zipNo = item.zipNo;
				let lnmAdres = item.lnmAdres;
				let rnAdres = item.rnAdres;
				
				out += "우편번호:"+zipNo+"<br>";
				out += "도로명주소:"+lnmAdres+"<br>";
				out += "지번:"+rnAdres+"<br><hr>";
			});
		} else {
			let item = data.NewAddressListResponse.newAddressListAreaCd;
			let zipNo = item.zipNo;
			let lnmAdres = item.lnmAdres;
			let rnAdres = item.rnAdres;
			
			out += "우편번호:"+zipNo+"<br>";
			out += "도로명주소:"+lnmAdres+"<br>";
			out += "지번:"+rnAdres+"<br>";
		}

		$("#resultLayout").html(out);
	}
});

$(function(){
	$("#btnWeather1").click(function(){
		// 날씨-초단기 실황 조회
		let url = "${pageContext.request.contextPath}/api/weather1";
		let base_date = "20240712";
		let base_time = "0900";
		// 마포구 서교동(격자 x, 격자 y). 기상청41_단기예보 조회서비스_오픈API활용가이드_최종.zip 의 엑셀에 있음
		let nx = "59";
		let ny = "126";
		let query = "base_date="+base_date+"&base_time="+base_time+"&nx="+nx+"&ny="+ny;
		
		const fn = function(data) {
			// console.log(data);
			printJSON(data);
		};
		
		ajaxFun(url, "get", query, "json", fn);
	});
	
	function printJSON(data) {
		let out = "<h3>날씨-초단기 실황 조회</h3><hr>";
		
		if(! data.response.body) {
			alert("등록된 정보가 없습니다.");
			return false;
		}
		
		let list = data.response.body.items.item;
		let category;
		let obsrValue;
		$.each(list, function(index, item){
			// 초단기 실황
			category = item.category;
			obsrValue = item.obsrValue;
			
			if(category==="PTY") { // 강수형태-0:없음,1:비,2:눈/비,3:눈,4:소나기 
			} else if(category==="REH") { // 습도
			} else if(category==="RN1") { // 강수량-0:없음,1:1mm이하,5:1~4mm,10:5~9mm,20:10~19mm,40:20~39mm,70:40~69mm,100:100mm이상
			} else if(category==="T1H") { // 섭씨온도
				out += "섭씨온도:" + obsrValue;
			} else if(category==="UUU") { // 동서바람성분
			} else if(category==="VEC") { // 풍향
			} else if(category==="VVV") { // 남북바람성분
			} else if(category==="WSD") { // 풍속
			}
		});
		
		$("#resultLayout").html(out);
	}
});

$(function(){
	$("#btnWeather2").click(function(){
		// 날씨-초단기 예보 조회
		let url = "${pageContext.request.contextPath}/api/weather2";
		let base_date = "20240712";
		let base_time = "0900";
		// 마포구 서교동. 기상청41_단기예보 조회서비스_오픈API활용가이드_최종.zip 의 엑셀에 있음
		let nx = "59";
		let ny = "126";
		let query = "base_date="+base_date+"&base_time="+base_time+"&nx="+nx+"&ny="+ny;
		
		const fn = function(data) {
			// console.log(data);
			printJSON(data);
		};
		
		ajaxFun(url, "get", query, "json", fn);
	});
	
	function printJSON(data) {
		let out = "<h3>날씨-초단기 예보 조회</h3><hr>";
		
		let category;
		let fcstDate, fcstTime; // 예측일자, 예측시간
		let fcstValue; // 예측값
		
		let fdate=[], ftime=[];
		let t1h=[], sky=[], pty=[], rn1=[]; 
		let pty_data = ["없음","비","비/눈","눈","소나기","빗방울","빗방울/눈날림","눈날림"];
		
		if(! data.response.body) {
			alert("등록된 정보가 없습니다.");
			return false;
		}

		let list = data.response.body.items.item;
		$.each(list, function(index, item){
			category = item.category;
			fcstDate = item.fcstDate;
			fcstTime = item.fcstTime;
			fcstValue = item.fcstValue;
			
			if(category==="T1H") { // 기온
				fdate.push(fcstDate);
				ftime.push(fcstTime);
				t1h.push(fcstValue);
			} else if(category==="SKY") { // 하늘상태
				if(fcstValue==="1") {
					sky.push("맑음");
				} else if(fcstValue==="3") {
					sky.push("구름 많음");
				} else if(fcstValue==="4") {
					sky.push("흐림");
				}
			} else if(category==="PTY") { // 강수형태
				pty.push(pty_data[parseInt(fcstValue)]);
 			} else if(category==="RN1") { // 1시간강수량
 				rn1.push(fcstValue);
			}
		});
		
		for(let i=0; i<fdate.length; i++) {
			out+=fdate[i]+", "+ftime[i];
			out+=", 기온:"+t1h[i];
			out+=", 하늘상태:"+sky[i];
			out+=", 강수상태:"+pty[i];
			out+=", 강수량:"+rn1[i]+"<br>";
		}

		$("#resultLayout").html(out);
	}
});

$(function(){
	$("#btnWeather3").click(function(){
		// 날씨-단기 예보 조회
		let url = "${pageContext.request.contextPath}/api/weather3";
		let base_date = "20240712";
		let base_time = "0500";
		// 마포구 서교동. 기상청41_단기예보 조회서비스_오픈API활용가이드_최종.zip.zip 의 엑셀에 있음
		let nx = "59";
		let ny = "126";
		let query = "base_date="+base_date+"&base_time="+base_time+"&nx="+nx+"&ny="+ny;
		
		const fn = function(data) {
			// console.log(data);
			printJSON(data);
		};
		
		ajaxFun(url, "get", query, "json", fn);
	});
	
	function printJSON(data) {
		let out = "<h3>날씨-단기 예보 조회</h3><hr>";
		
		let category;
		let fcstDate, fcstTime; // 예측일자, 예측시간
		let fcstValue; // 예측값
		let pop, sky;
		
		if(! data.response.body) {
			alert("등록된 정보가 없습니다.");
			return false;
		}

		let list = data.response.body.items.item;
		$.each(list, function(index, item){
			category = item.category;
			fcstDate = item.fcstDate;
			fcstTime = item.fcstTime;
			fcstValue = item.fcstValue;
			
			if(category==="POP") { // 강수확률
				pop=fcstValue;
			} else if(category==="SKY") { // 하늘상태
				if(fcstValue==="1") {
					sky="맑음";
				} else if(fcstValue==="3") {
					sky="구름 많음";
				} else if(fcstValue==="4") {
					sky="흐림";
				}
			}
		});
		
		out += fcstDate + " : " + fcstTime + " : " + pop + " : " + sky;
		$("#resultLayout").html(out);
	}
});

$(function(){
	$("#btnWeather4").click(function(){
		// 현재 지역 날씨 
		let url="${pageContext.request.contextPath}/api/weather4";
		let query="time="+new Date().getTime();
		
		const fn = function(data) {
			// console.log(data);
			printXML(data);
		};
		
		ajaxFun(url, "get", query, "xml", fn);
	});

/*
// icon
01 : 맑음, 02 : 구름조금, 03 : 구름많음, 04 : 흐림, 07 : 소나기, 08 : 비,
11 : 눈, 12 : 비 또는 눈, 13 : 눈 또는 비, 14 : 천둥번개, 15 : 안개,
16 : 황사, 17 : 박무, 18 : 연무, 20 : 가끔 비, 한때 비, 21 : 가끔 눈, 한때 눈,
22 : 가끔 비 또는 눈, 한때 비 또는 눈, 23 : 가끔 눈 또는 비, 한때 눈 또는 비
*/
	function printXML(data) {
		let out = "<h3>날씨-지역 예보</h3><hr>";
		let iconUrl = "${pageContext.request.contextPath}/resources/wicon/";
		
		let year = $(data).find("weather").attr("year");
		let month = $(data).find("weather").attr("month");
		let day = $(data).find("weather").attr("day");
		let hour = $(data).find("weather").attr("hour");
		
		out += "<p>"+year+"년 "+month+"월 "+day+"일 "+hour+"시<p>" ;
		
		let icon, desc, ta, city, rn_hr1, iconSrc;
		$(data).find("local").each(function(){
			city = $(this).text(); // 지역
			
			icon = $(this).attr("icon"); // 아이콘
			desc = $(this).attr("desc"); // 날씨
			ta = $(this).attr("ta"); // 현재 온도
			rn_hr1 = $(this).attr("rn_hr1"); // 시간당 강수량
			
			out += "<p><b>"+city+"</b>";
			if( ta ) {
				out += ", 기온 : " + ta;
			}
			if( rn_hr1 ) {
				out += ", 시간당 강수량 : " + rn_hr1;
			}
			if( icon ) {
				iconSrc = iconUrl + icon+".png";
				out += "<img src='"+iconSrc+"' style='vertical-align: middle;' title='"+desc+"'>";
			}
			out += "</p>";
		});
		
		$("#resultLayout").html(out);
	}
});

</script>

</body>
</html>