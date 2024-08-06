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

.container { margin: 30px auto; width: 800px; }
.box-container .box {
	box-sizing: border-box;
	padding: 20px;
	width: 100%;
	height: 400px;
	border: 1px solid #ccc;
	margin: 10px;
	text-align: center;
}
</style>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/echarts/5.5.0/echarts.min.js"></script>

<script type="text/javascript">
// https://echarts.apache.org/en/index.html

$(function(){
	let url = "${pageContext.request.contextPath}/echart/line1";
	
	$.getJSON(url, function(data){
		// console.log(data);
		let titles = [];
		let values = [];
		
		for(let item of data.list) {
			titles.push(item.title); // 월
			values.push(item.value); // 기온(템프러처)
		}
		
		var chartDom = document.getElementById('lineContainer1');
		var myChart = echarts.init(chartDom);
		var option;

		option = {
		  title: {
			text:'서울 월별 평균 기온'  
		  },
		  xAxis: {
		    type: 'category',
		    data: titles
		  },
		  yAxis: {
		    type: 'value'
		  },
		  
		  // series: data.series
		  series: [
    		{
      			data: values,
      			type: 'line'
    		}
  		  ]		  
		};

		option && myChart.setOption(option);
		
	});
	
});

$(function(){
	let url = "${pageContext.request.contextPath}/echart/line2";
	
	$.getJSON(url, function(data){
		// console.log(data);
		
		var chartDom = document.getElementById('lineContainer2');
		var myChart = echarts.init(chartDom);
		var option;

		option = {
		  title: {
			text: data.year + '년 월별 평균 기온'  
		  },
		  legend: {
			data: data.legend
		  },
		  tooltip: {
			trigger: 'axis'  
		  },
		  xAxis: {
		    type: 'category',
		    data: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
		  },
		  yAxis: {
		    type: 'value'
		  },
		  
		  series: data.series
		};

		option && myChart.setOption(option);
		
	});
	
});

$(function(){
	let url = "${pageContext.request.contextPath}/echart/bar";

	$.getJSON(url, function(data){
		// console.log(data);
		
		var chartDom = document.getElementById('barContainer');
		var myChart = echarts.init(chartDom);
		var option;

		option = {
		  title: {
			text: data.year + '년 월별 평균 기온'  
		  },
		  legend: {
			data: data.legend
		  },
		  tooltip: {
			trigger: 'axis'  
		  },
		  xAxis: {
		    type: 'category',
		    data: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
		  },
		  yAxis: {
		    type: 'value'
		  },
		  
		  series: data.series
		};

		option && myChart.setOption(option);
		
	});
	
});

$(function(){
	let url = "${pageContext.request.contextPath}/echart/pie";
	
	$.getJSON(url, function(data){
		// console.log(data);
		
		let chartData = [];
		for(let item of data.list) {
			let obj = {value:item.value, name:item.title};
			chartData.push(obj);
		}		
		
		var chartDom = document.getElementById('pieContainer');
		var myChart = echarts.init(chartDom);
		var option;

		option = {
		  title: {
			  text: '접속자 수'
		  },
		  tooltip: {
		    trigger: 'item'
		  },
		  legend: {
		    top: '5%',
		    left: 'center'
		  },
		  series: [
		    {
		      name: '인원수',
		      type: 'pie',
		      radius: ['40%', '70%'],
		      avoidLabelOverlap: false,
		      itemStyle: {
		        borderRadius: 10,
		        borderColor: '#fff',
		        borderWidth: 2
		      },
		      label: {
		        show: false,
		        position: 'center'
		      },
		      emphasis: {
		        label: {
		          show: true,
		          fontSize: 40,
		          fontWeight: 'bold'
		        }
		      },
		      labelLine: {
		        show: false
		      },
		      data: chartData
		    }
		  ]
		};

		option && myChart.setOption(option);
		
	});
	
});

</script>

</head>
<body>

<div class="container">
	<h2> chart 예제 </h2>
	
	<div class="box-container" style="margin-top: 15px;">
	    <div id="lineContainer1" class="box"></div>
	    <div id="lineContainer2" class="box"></div>
	</div>
	
	<div class="box-container">
	    <div id="barContainer" class="box"></div>
	    <div id="pieContainer" class="box"></div>
	</div>
</div>

</body>
</html>