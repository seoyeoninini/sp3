<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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

.container { margin: 30px auto; width: 1000px; }
.box-container .box {
	display: inline-block;
	box-sizing: border-box;
	padding: 20px;
	width: 476px;
	height: 400px;
	border: 1px solid #ccc;
	margin: 10px;
	text-align: center;
}
</style>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/highcharts-3d.js"></script>

<script type="text/javascript">
// https://www.highcharts.com/demo

$(function(){
	let url = "${pageContext.request.contextPath}/hchart/line1";
	
	$.getJSON(url, function(data){
		//console.log(data);
		let titles = [];
		let values = [];
		
		for(let item of data.list) {
			titles.push(item.title); // 월
			values.push(item.value); // 기온(템프러처)
		}
		
		Highcharts.chart('lineContainer1', {
		    title: {
		        text: '서울 월별 평균 기온'
		    },

		    xAxis: {
		        categories :titles
		    },

		    yAxis: {
		        title:{
		        	text:'기온(C)'
		        }
		    },

		    series: [  // 시어리즈
		    	{ name: "서울", data: values}
		    ]
		});		
	});
});

$(function(){
	let url = "${pageContext.request.contextPath}/hchart/line2";
	
	$.getJSON(url, function(data){
		//console.log(data);
		
		Highcharts.chart('lineContainer2', {

		    title: {
		        text: data.year+'년 월별 평균 기온'
		    },

		    xAxis: {
		        categories :['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
		    },

		    yAxis: {
		        title:{
		        	text:'기온(C)'
		        }
		    },

		    series: data.series
		});		
	});
});

$(function(){
	let url = "${pageContext.request.contextPath}/hchart/bar";
	
	$.getJSON(url, function(data){
		//console.log(data);
		
		Highcharts.chart('barContainer', {
			chart: {
		        type: 'column'
		    },
		    
		    title: {
		        text: data.year+'년 월별 평균 기온'
		    },

		    xAxis: {
		        categories :['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
		    },

		    yAxis: {
		        title:{
		        	text:'기온(C)'
		        }
		    },

		    series: data.series
		});		
	});
});

$(function(){
	let url = "${pageContext.request.contextPath}/hchart/pie3d";
	$.getJSON(url, function(data){
		// console.log(data);
		
		let chartData = [];
		for(let item of data.list) {
			let obj = [item.title, item.value];
			chartData.push(obj);
		}		
		console.log(chartData);
		
		Highcharts.chart('pie3dContainer', {
		    chart: {
		        type: 'pie',
		        options3d: {
		            enabled: true,
		            alpha: 45
		        }
		    },
		    title: {
		        text: '시간별 접속자수 현황'
		    },
		    plotOptions: {
		        pie: {
		            innerSize: 100,
		            depth: 45
		        }
		    },
		    series: [
		    	{name: "접속자수", data: chartData}
		    ]
		});

	});
});

</script>

</head>
<body>

<div class="container">
	<h2>high chart 예제</h2>
	
	<div class="box-container" style="margin-top: 15px;">
	    <div id="lineContainer1" class="box"></div>
	    <div id="lineContainer2" class="box"></div>
	</div>
	
	<div class="box-container">
	    <div id="barContainer" class="box"></div>
	    <div id="pie3dContainer" class="box"></div>
	</div>
</div>

</body>
</html>