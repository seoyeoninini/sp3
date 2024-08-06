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

.box { padding: 5px; }
.box p { padding: 5px; }
</style>
</head>
<body>

<div class="container">
	<div class="title">
	    <h3> 카카오 맵 </h3>
	</div>
	
	<div class="box">
		<p>
			<button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/maps/map1';">간단한 카카오 지도</button>
			<button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/maps/map2';">클릭한 위치에 마커 찍기</button>
		</p>
		<p>
			<button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/maps/map3';">여러개 마커 및 이벤트 등록 - mouseover/mouseout</button>
			<button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/maps/map4';">여러개 마커 및 이벤트 등록 - click</button>
		</p>
		<p>
			<button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/maps/map5';"> 커스텀 오버레이 </button>
		</p>
		<p>
			<button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/maps/map6';"> 주소로 마커  표시 </button>
			<button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/maps/map7';"> 주소로 마커  표시, IP 위치기반-커스텀 오버레이 </button>
		</p>
		<p>
			<button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/maps/map8';"> 검색 </button>
			<button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/maps/map9';"> 카카오 키워드 검색 </button>
		</p>
		
	</div>
	
</div>
	
</body>
</html>